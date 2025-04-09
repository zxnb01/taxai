import 'package:flutter/material.dart';

class FAQPage extends StatelessWidget {
  final List<Map<String, String>> faqs = [
    {
      'question': "How is my tax optimization calculated?",
      'answer':
          "We analyze your declared income, deductions, and investment patterns to estimate how much tax you've saved and what more you could do."
    },
    {
      'question': "Can I link my investments?",
      'answer':
          "Yes, you can connect your portfolio manually or via supported brokers to get personalized insights."
    },
    {
      'question': "Is my data secure?",
      'answer':
          "Absolutely. We use end-to-end encryption and never share your data without your consent."
    },
    {
      'question': "What if I miss a tax-saving opportunity?",
      'answer':
          "Our smart notifications help you avoid missing important deadlines and suggest timely moves."
    },
    {
      'question': "Who can see my profile?",
      'answer':
          "Only you. You have complete control over what is visible and can change visibility preferences anytime."
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text("FAQs", style: TextStyle(color: Colors.white)),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(20),
        itemCount: faqs.length,
        itemBuilder: (context, index) {
          return _buildFAQCard(
              faqs[index]['question']!, faqs[index]['answer']!);
        },
      ),
    );
  }

  Widget _buildFAQCard(String question, String answer) {
    return Card(
      color: Color(0xFF1E1E1E),
      margin: EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Theme(
        data: ThemeData().copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          title: Text(question,
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 14)),
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
              child: Text(answer,
                  style: TextStyle(color: Colors.white70, fontSize: 13)),
            )
          ],
          iconColor: Colors.white54,
          collapsedIconColor: Colors.white38,
        ),
      ),
    );
  }
}
