import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class TaxQuestionnairePage extends StatefulWidget {
  @override
  _TaxQuestionnairePageState createState() => _TaxQuestionnairePageState();
}

class _TaxQuestionnairePageState extends State<TaxQuestionnairePage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController salaryController = TextEditingController();
  final TextEditingController rentController = TextEditingController();
  final TextEditingController loanController = TextEditingController();
  final TextEditingController eduLoanController = TextEditingController();
  final TextEditingController ppfController = TextEditingController();
  final TextEditingController npsController = TextEditingController();
  final TextEditingController insuranceController = TextEditingController();
  final TextEditingController elssController = TextEditingController();

  bool _isLoading = false;
  String _aiAdvice = "";

  Future<String> getTaxAdvice(Map<String, dynamic> payload) async {
    final url = Uri.parse("http://127.0.0.1:8000/predict-tax");

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json; charset=UTF-8"},
      body: jsonEncode(payload),
    );
    final decodedResponse =
        utf8.decode(response.bodyBytes); // this fixes weird chars
    final json = jsonDecode(decodedResponse);

    if (response.statusCode == 200) {
      final decoded = jsonDecode(response.body);
      return decoded["advice"];
    } else {
      throw Exception(
          "Failed to get advice: ${response.statusCode} ${response.body}");
    }
  }

  void _submit() async {
    final payload = {
      "name": nameController.text,
      "annual_salary": int.tryParse(salaryController.text) ?? 0,
      "monthly_rent": int.tryParse(rentController.text) ?? 0,
      "loan_interest_paid": int.tryParse(loanController.text) ?? 0,
      "education_loan_interest": int.tryParse(eduLoanController.text) ?? 0,
      "investments": {
        "ppf": int.tryParse(ppfController.text) ?? 0,
        "nps": int.tryParse(npsController.text) ?? 0,
        "health_insurance": int.tryParse(insuranceController.text) ?? 0,
        "elss": int.tryParse(elssController.text) ?? 0,
      },
      "questionnaire": {
        "source_of_income": ["job"],
        "passive_income": ["none"],
        "tax_saving_investments": ["ppf"],
        "health_insurance": "yes",
        "loans": ["education"],
        "rent_status": "rented",
        "capital_gains": ["none"],
        "donations": false,
        "foreign_assets": false,
        "itr_filing_status": true
      }
    };

    setState(() {
      _isLoading = true;
      _aiAdvice = "";
    });

    try {
      final advice = await getTaxAdvice(payload);
      setState(() {
        _aiAdvice = advice;
        _aiAdvice = _aiAdvice.replaceAll(RegExp(r'[^\x00-\x7F]+'), '');
      });
    } catch (e) {
      print("Error: $e");
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("Tax Optimizer", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTextField("Full Name", nameController),
              _buildTextField("Annual Salary", salaryController,
                  isNumber: true),
              _buildTextField("Monthly Rent", rentController, isNumber: true),
              _buildTextField("Loan Interest Paid", loanController,
                  isNumber: true),
              _buildTextField("Education Loan Interest", eduLoanController,
                  isNumber: true),
              Divider(color: Colors.white54),
              Text("Investments",
                  style: TextStyle(color: Colors.white, fontSize: 18)),
              _buildTextField("PPF", ppfController, isNumber: true),
              _buildTextField("NPS", npsController, isNumber: true),
              _buildTextField("Health Insurance", insuranceController,
                  isNumber: true),
              _buildTextField("ELSS", elssController, isNumber: true),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _isLoading ? null : _submit,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
                child: _isLoading
                    ? Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                                color: Colors.white, strokeWidth: 2),
                          ),
                          SizedBox(width: 12),
                          Text("Generating AI Advice...",
                              style: TextStyle(color: Colors.white))
                        ],
                      )
                    : Text("Get AI Advice",
                        style: TextStyle(color: Colors.white)),
              ),
              SizedBox(height: 30),
              if (_aiAdvice.isNotEmpty)
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.deepPurple.shade900.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.deepPurpleAccent),
                  ),
                  child: MarkdownBody(
                    data: _aiAdvice
                        .replaceAll('Rs.', '\u20B9')
                        .replaceAll('INR', '\u20B9'),
                    styleSheet: MarkdownStyleSheet.fromTheme(Theme.of(context))
                        .copyWith(
                      p: TextStyle(color: Colors.white70, fontSize: 16),
                    ),
                  ),
                  // child: Text(
                  //   _aiAdvice
                  //       .replaceAll('Rs.', '\u20B9')
                  //       .replaceAll('INR', '\u20B9'),
                  //   style: TextStyle(color: Colors.white70, fontSize: 16),
                  // ),

                  // style: TextStyle(color: Colors.white70, fontSize: 16),
                  // ),
                )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller,
      {bool isNumber = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        keyboardType: isNumber ? TextInputType.number : TextInputType.text,
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: Colors.white60),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white24),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.deepPurpleAccent),
            borderRadius: BorderRadius.circular(10),
          ),
          filled: true,
          fillColor: Colors.white10,
        ),
      ),
    );
  }
}
