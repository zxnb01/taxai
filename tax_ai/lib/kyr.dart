import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class KnowYourRightsPage extends StatelessWidget {
  final List<Map<String, String>> rights = [
    {
      'right': "Right to Privacy",
      'description':
          "Your financial data is yours alone. We ensure it stays confidential with top-tier encryption and strict access controls."
    },
    {
      'right': "Right to Transparency",
      'description':
          "You deserve to know how your taxes are calculated and optimized. We provide clear breakdowns and explanations."
    },
    {
      'right': "Right to Control",
      'description':
          "You decide what information to share or link. Adjust your settings anytime to suit your comfort level."
    },
    {
      'right': "Right to Support",
      'description':
          "Access expert help whenever you need it. Our team is here to guide you through tax laws and filings."
    },
    {
      'right': "Right to Fair Treatment",
      'description':
          "No hidden fees or biased advice. Our algorithms prioritize your benefit, not ours."
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Row(
          children: [
            Text(
              "Know Your Rights",
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
            SizedBox(width: 10),
            SvgPicture.asset(
              'assets/shield_doodle.svg', // Open Doodle-inspired shield
              height: 30,
              color: Colors.blueAccent, // Matches rights theme
            ),
          ],
        ),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            SizedBox(height: 20),
            ...rights
                .map((right) => _buildRightCard(
                      right['right']!,
                      right['description']!,
                      context,
                    ))
                .toList(),
          ],
        ),
      ),
    );
  }

  Widget _buildRightCard(
      String right, String description, BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      margin: EdgeInsets.only(bottom: 16),
      child: Card(
        elevation: 4,
        color: Color(0xFF1E1E1E),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Theme(
          data: ThemeData().copyWith(dividerColor: Colors.transparent),
          child: ExpansionTile(
            tilePadding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            title: Row(
              children: [
                Icon(Icons.shield, size: 20, color: Colors.blueAccent),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    right,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  description,
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                    height: 1.5,
                  ),
                ),
              ),
            ],
            iconColor: Colors.blueAccent,
            collapsedIconColor: Colors.white38,
            backgroundColor: Colors.transparent,
            expandedAlignment: Alignment.centerLeft,
          ),
        ),
      ),
    );
  }
}
