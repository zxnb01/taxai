import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'dart:async';
import 'package:fl_chart/fl_chart.dart';
import 'package:tax_ai/chatbot.dart';
import 'package:tax_ai/faqs_page.dart';
import 'package:tax_ai/kyr.dart';
import 'package:tax_ai/optimize_questionnaire.dart';
import 'package:tax_ai/profile_page.dart';
import 'package:tax_ai/settings.dart';
import 'package:tax_ai/support.dart';
import 'package:tax_ai/tandc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Timer _timer;
  Duration _countdown =
      DateTime(DateTime.now().year, 7, 31).difference(DateTime.now());

  @override
  void initState() {
    super.initState();
    _startCountdown();
  }

  void _startCountdown() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _countdown = _countdown - const Duration(seconds: 1);
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final days = duration.inDays;
    final hours = twoDigits(duration.inHours.remainder(24));
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return "$days days $hours:$minutes:$seconds";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      drawer: Drawer(
        backgroundColor: Colors.white,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.black87),
              child: Text(
                'Menu',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            ListTile(
              leading: Icon(Icons.help_outline),
              title: Text('FAQs'),
              onTap: () {
                Navigator.pop(context); // close the drawer
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FAQPage()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SettingsPage()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.security),
              title: Text('Know Your Rights'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => KnowYourRightsPage()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.folder),
              title: Text('Document Vault'),
              onTap: () {
                // Navigator.pop(context);
                // Navigator.push(
                // context,
                // MaterialPageRoute(builder: (context) => DocumentVaultPage()),
                // );
              },
            ),
            ListTile(
              leading: Icon(Icons.description),
              title: Text('Terms and Conditions'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TermsPage()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.contact_support),
              title: Text('Support'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SupportPage()),
                );
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu, color: Colors.white),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfilePage()),
                );
              },
              child: Icon(LucideIcons.user, color: Colors.white),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Enhanced Tax Status Widget
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Colors.white10,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text(
                              "Your Tax Status:",
                              style: TextStyle(
                                  color: Colors.white70, fontSize: 18),
                            ),
                            Text(
                              "Filed",
                              style: TextStyle(
                                  color: Colors.greenAccent,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        const Text(
                          "Amount Saved: ₹12,500",
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            const Icon(LucideIcons.clock4,
                                color: Colors.white70, size: 18),
                            const SizedBox(width: 8),
                            Text(
                              "Next ITR Deadline: ${DateTime.now().year}-07-31",
                              style: const TextStyle(color: Colors.white60),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "Countdown: ${_formatDuration(_countdown)}",
                          style: const TextStyle(
                              color: Colors.white, fontSize: 14),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Financial Portfolio Graph + Tax Info
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Circular Financial Portfolio
                      Expanded(
                        child: Container(
                          height: 200,
                          padding: const EdgeInsets.all(10),
                          decoration: const BoxDecoration(
                            color: Colors.transparent,
                            shape: BoxShape.circle,
                          ),
                          child: PieChart(
                            PieChartData(
                              sectionsSpace: 2,
                              centerSpaceRadius: 50,
                              sections: [
                                PieChartSectionData(
                                  value: 40,
                                  color: Colors.blue,
                                  radius: 30,
                                  title: 'Income',
                                  titleStyle: TextStyle(
                                      color: Colors.white, fontSize: 12),
                                ),
                                PieChartSectionData(
                                  value: 25,
                                  color: Colors.green,
                                  radius: 30,
                                  title: 'Capital',
                                  titleStyle: TextStyle(
                                      color: Colors.white, fontSize: 12),
                                ),
                                PieChartSectionData(
                                  value: 20,
                                  color: Colors.orange,
                                  radius: 30,
                                  title: 'Invest',
                                  titleStyle: TextStyle(
                                      color: Colors.white, fontSize: 12),
                                ),
                                PieChartSectionData(
                                  value: 15,
                                  color: Colors.purple,
                                  radius: 30,
                                  title: 'Others',
                                  titleStyle: TextStyle(
                                      color: Colors.white, fontSize: 12),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 20),
                      // Tax Info Explanation
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text("Tax Rates:",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16)),
                            SizedBox(height: 10),
                            Text(
                                "• Income: 10%\n• Capital Gains: 15%\n• Investments: 8%\n• Others: 5%",
                                style: TextStyle(color: Colors.white70)),
                          ],
                        ),
                      )
                    ],
                  ),

                  const SizedBox(height: 30),

                  // Feature Grid Buttons
                  GridView.count(
                    crossAxisCount: 2,
                    shrinkWrap: true,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      FeatureButton(
                        icon: LucideIcons.bookOpenCheck,
                        label: "Automated Tax File",
                        onPressed: () {},
                      ),
                      FeatureButton(
                        icon: LucideIcons.percent,
                        label: "Optimise Your Taxes",
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => TaxQuestionnairePage()),
                          );
                        },
                      ),
                      FeatureButton(
                        icon: LucideIcons.gift,
                        label: "Rewards",
                        onPressed: () {},
                      ),
                      FeatureButton(
                        icon: LucideIcons.sheet,
                        label: "Form Templates",
                        onPressed: () {},
                      ),
                    ],
                  )
                ],
              ),
            ),

            // Chatbot Floating Element
            Positioned(
              bottom: 20,
              right: 20,
              child: FloatingActionButton(
                shape: const CircleBorder(),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ChatbotPage()));
                },
                backgroundColor: Colors.white,
                child: const Icon(LucideIcons.bot, color: Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FeatureButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onPressed;

  const FeatureButton({
    super.key,
    required this.icon,
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white10,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        padding: const EdgeInsets.all(20),
      ),
      onPressed: onPressed,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: Colors.white, size: 28),
          const SizedBox(height: 10),
          Text(label,
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 14),
              textAlign: TextAlign.center),
        ],
      ),
    );
  }
}
