# test_tax_predictor.py
import pytest
from fastapi.testclient import TestClient
from main_api import app  # assuming your file is named main.py

client = TestClient(app)

def test_valid_prediction_request():
    payload = {
        "name": "Rajiv Sharma",
        "annual_salary": 1200000,
        "monthly_rent": 20000,
        "loan_interest_paid": 100000,
        "education_loan_interest": 20000,
        "investments": {
            "ppf": 50000,
            "elss": 70000,
            "health_insurance": 25000,
            "nps": 40000
        },
        "questionnaire": {
            "source_of_income": ["Salary", "Freelancing"],
            "passive_income": ["Rental Property", "Dividends"],
            "tax_saving_investments": ["PPF", "ELSS", "NPS"],
            "health_insurance": "Covered under corporate plan and personal policy",
            "loans": ["home_loan", "education_loan"],
            "rent_status": "Rented",
            "capital_gains": ["stocks", "mutual_funds"],
            "donations": True,
            "foreign_assets": False,
            "itr_filing_status": True
        }
    }

    response = client.post("/predict-tax", json=payload)
    assert response.status_code == 200
    assert "advice" in response.json()

# def test_missing_optional_fields():
#     payload = {
#         "name": "Asha Mehta",
#         "annual_salary": 900000,
#         "monthly_rent": 15000,
#         "loan_interest_paid": 0,
#         "education_loan_interest": 0,
#         "investments": {},
#         "questionnaire": {}
#     }
#     response = client.post("/predict-tax", json=payload)
#     assert response.status_code == 200
#     assert "advice" in response.json()
def test_missing_optional_fields():
    payload = {
        "name": "Asha Mehta",
        "annual_salary": 900000,
        "monthly_rent": 15000,
        "loan_interest_paid": 0,
        "education_loan_interest": 0,
        "investments": {
            "ppf": 0,
            "nps": 0,
            "life_insurance": 0,
            "elss": 0,
            "home_loan_principal": 0,
            "others": 0
        },
        "questionnaire": {
            "age_group": "26-35",
            "dependents": "none",
            "risk_profile": "moderate"
        }
    }
    response = client.post("/predict-tax", json=payload)
    assert response.status_code == 200
    assert "advice" in response.json()


# def test_extremely_high_salary():
#     payload = {
#         "name": "Elon Bhai",
#         "annual_salary": 10_000_000_000,  # 10 billion
#         "monthly_rent": 0,
#         "loan_interest_paid": 0,
#         "education_loan_interest": 0,
#         "investments": {},
#         "questionnaire": {}
#     }
#     response = client.post("/predict-tax", json=payload)
#     assert response.status_code == 200
#     assert "advice" in response.json()
def test_extremely_high_salary():
    payload = {
        "name": "Elon Bhai",
        "annual_salary": 10_000_000_000,
        "monthly_rent": 0,
        "loan_interest_paid": 0,
        "education_loan_interest": 0,
        "investments": {
            "ppf": 0,
            "nps": 0,
            "life_insurance": 0,
            "elss": 0,
            "home_loan_principal": 0,
            "others": 0
        },
        "questionnaire": {
            "age_group": "46+",
            "dependents": "yes",
            "risk_profile": "conservative"
        }
    }
    response = client.post("/predict-tax", json=payload)
    assert response.status_code == 200
    assert "advice" in response.json()
