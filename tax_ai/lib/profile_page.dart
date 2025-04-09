// import 'package:flutter/material.dart';
// import 'package:lucide_icons/lucide_icons.dart';
// import 'package:percent_indicator/percent_indicator.dart';

import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  final double userScore = 65; // Out of 100
  final double averageScore = 72;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.white),
        title: Text("Your Profile", style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildUserInfo(),
            SizedBox(height: 20),
            _buildPersonaCard(),
            SizedBox(height: 20),
            _buildHealthIndicator(context),
            SizedBox(height: 20),
            _buildInvestmentsCard(),
            SizedBox(height: 5),
            _buildTaxSummaryCard(),
            SizedBox(height: 5),
            _buildTipsCard(),
          ],
        ),
      ),
    );
  }

  Widget _buildInvestmentsCard() {
    return Card(
      color: Color(0xFF1E1E1E),
      margin: EdgeInsets.symmetric(vertical: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Your Investments",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold)),
            SizedBox(height: 12),
            _buildSummaryRow("Equity Mutual Funds", "₹1.2L"),
            _buildSummaryRow("Fixed Deposits", "₹60K"),
            _buildSummaryRow("ELSS", "₹35K"),
            _buildSummaryRow("Other Assets", "₹15K"),
          ],
        ),
      ),
    );
  }

  Widget _buildUserInfo() {
    return Row(
      children: [
        CircleAvatar(
          radius: 30,
          backgroundColor: Colors.deepPurple,
          child: Text("NS", style: TextStyle(color: Colors.white)),
        ),
        SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Neha Sharma",
                style: TextStyle(color: Colors.white, fontSize: 18)),
            Text("neha@gmail.com",
                style: TextStyle(color: Colors.white60, fontSize: 14)),
          ],
        ),
      ],
    );
  }

  Widget _buildPersonaCard() {
    return Card(
      color: Colors.deepPurple.shade800.withOpacity(0.4), // Muted purple
      margin: EdgeInsets.symmetric(vertical: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.deepPurpleAccent.withOpacity(0.5)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Financial Persona",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold)),
            SizedBox(height: 12),
            Text(
              "🧠 Smart Saver\nYou're risk-averse but make the most of your tax deductions and savings instruments. You prefer secure investments over volatile returns.",
              style:
                  TextStyle(color: Colors.white70, fontSize: 14, height: 1.4),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHealthIndicator(BuildContext context) {
    double fullWidth = MediaQuery.of(context).size.width - 32;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Financial Health",
            style: TextStyle(color: Colors.white70, fontSize: 16)),
        SizedBox(height: 8),
        Text(
          "Your score is based on savings, diversification, and risk profile.",
          style: TextStyle(color: Colors.white38, fontSize: 13),
        ),
        SizedBox(height: 12),
        Stack(
          children: [
            Container(
              height: 12,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: LinearGradient(
                  colors: [Colors.red, Colors.yellow, Colors.green],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
              ),
            ),
            Positioned(
              left: (userScore / 100) * fullWidth - 6,
              child: Column(
                children: [
                  Icon(Icons.circle, size: 12, color: Colors.white),
                  SizedBox(height: 2),
                  Text("You",
                      style: TextStyle(
                          fontSize: 10,
                          color: Colors.white70,
                          fontWeight: FontWeight.w500)),
                ],
              ),
            ),

            // Average score indicator
            Positioned(
              left: (averageScore / 100) * fullWidth - 6,
              top: 18,
              child: Column(
                children: [
                  Icon(Icons.arrow_drop_down, color: Colors.white70, size: 20),
                  Text("Avg",
                      style: TextStyle(
                          fontSize: 10,
                          color: Colors.white54,
                          fontWeight: FontWeight.w400)),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Needs work", style: TextStyle(color: Colors.redAccent)),
            Text("Excellent", style: TextStyle(color: Colors.greenAccent)),
          ],
        ),
      ],
    );
  }

  Widget _buildTaxSummaryCard() {
    double optimizedAmount = 45000;
    double potentialAmount = 25000;

    return Card(
      color: Color(0xFF1E1E1E),
      margin: EdgeInsets.symmetric(vertical: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Tax Summary",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold)),
            SizedBox(height: 12),
            Row(
              children: [
                Icon(Icons.check_circle_outline, color: Colors.greenAccent),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    "You've optimized ₹${optimizedAmount.toStringAsFixed(0)} of your taxes this year.",
                    style: TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Icon(Icons.warning_amber_rounded, color: Colors.orangeAccent),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    "Potential to optimize ₹${potentialAmount.toStringAsFixed(0)} more based on current profile.",
                    style: TextStyle(color: Colors.white60, fontSize: 14),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(color: Colors.white60)),
          Text(value, style: TextStyle(color: Colors.white)),
        ],
      ),
    );
  }

  Widget _buildTipsCard() {
    List<String> tips = [
      "Use Section 80C deductions wisely.",
      "Invest in ELSS for dual benefits.",
      "Track work-from-home expense claims.",
      "Claim HRA even if staying with parents.",
    ];

    return Card(
      color: Color(0xFF1C1C1C),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: EdgeInsets.only(top: 20, bottom: 40),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Tips to Save More",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold)),
            SizedBox(height: 12),
            ...tips.map((tip) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.lightbulb_outline,
                          size: 16, color: Colors.yellowAccent),
                      SizedBox(width: 8),
                      Expanded(
                        child: Text(tip,
                            style:
                                TextStyle(color: Colors.white70, fontSize: 13)),
                      ),
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
