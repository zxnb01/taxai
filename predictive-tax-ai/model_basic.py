# import json
# # from langchain_community.llms import Ollama
# from langchain_ollama import OllamaLLM
# from langchain.prompts import PromptTemplate

# # Load user data
# with open("user_data.json", "r") as f:
#     user_data = json.load(f)

# # Load tax rules
# with open("tax_rules.txt", "r") as f:
#     tax_rules = f.read()

# # Load prompt template
# with open("prompts/tax_prompt.txt", "r") as f:
#     prompt_template = f.read()

# # Format prompt
# filled_prompt = prompt_template.format(
#     user_data=json.dumps(user_data, indent=2),
#     tax_rules=tax_rules
# )

# # Initialize Ollama LLM (make sure it's running locally)
# # llm = Ollama(model="mistral")  # or 'llama2'
# llm = OllamaLLM(model="mistral")

# # Get the response
# response = llm.invoke(filled_prompt)

# # Print the result
# print("\n--- Tax Optimization Advice ---\n")
# print(response)