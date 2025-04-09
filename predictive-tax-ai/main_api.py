from typing import List, Optional
from fastapi import FastAPI
from pydantic import BaseModel
from langchain_ollama import OllamaLLM
from langchain.prompts import PromptTemplate
import json

app = FastAPI()

# Load the tax rules once at startup
with open("tax_rules.txt", "r") as f:
    tax_rules = f.read()

# Load the prompt template
with open("prompts/tax_prompt.txt", "r") as f:
    prompt_template = f.read()

# Create LangChain PromptTemplate
template = PromptTemplate.from_template(prompt_template)

# Define input model using Pydantic
class InvestmentData(BaseModel):
    ppf: float = 0
    nps: float = 0
    health_insurance: float = 0
    elss: float = 0

class TaxQuestionnaire(BaseModel):
    source_of_income: Optional[List[str]] = []
    passive_income: Optional[List[str]] = []
    tax_saving_investments: Optional[List[str]] = []
    health_insurance: Optional[str] = None
    loans: Optional[List[str]] = []
    rent_status: Optional[str] = None
    capital_gains: Optional[List[str]] = []
    donations: Optional[bool] = False
    foreign_assets: Optional[bool] = False
    itr_filing_status: Optional[bool] = False


class UserData(BaseModel):
    name: str
    annual_salary: int
    monthly_rent: int
    investments: InvestmentData = InvestmentData()
    loan_interest_paid: int
    education_loan_interest: int
    questionnaire: TaxQuestionnaire = TaxQuestionnaire()


# POST endpoint to receive user input and return AI response
@app.post("/predict-tax")
# async def predict_tax(user_data: UserData):
#     # Convert input to dict and format as JSON
#     # user_data_dict = user_data.dict()
#     user_data_dict = user_data.model_dump()

#     user_data_json = json.dumps(user_data_dict, indent=2)

#     # Fill the prompt
#     filled_prompt = template.format(
#         user_data=user_data_json,
#         tax_rules=tax_rules
#     )

#     # Load Ollama model
#     llm = OllamaLLM(model="mistral")

#     # Invoke the model
#     response = llm.invoke(filled_prompt)

#     return {"advice": response}

async def predict_tax(user_data: UserData):
    # Convert input to dict and format as JSON
    # user_data_dict = user_data.dict()
    user_data_dict = user_data.model_dump()

    user_data_json = json.dumps(user_data_dict, indent=2)

    # Fill the prompt
    filled_prompt = template.format(
        user_data=user_data_json,
        tax_rules=tax_rules
    )

    # Load Ollama model
    llm = OllamaLLM(model="mistral")

    # Invoke the model
    response = llm.invoke(filled_prompt)

    return {"advice": response}