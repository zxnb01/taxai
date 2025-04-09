import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _deadlineNotifications = true;
  bool _tipsNotifications = false;
  String _selectedLanguage = 'English';
  String _selectedCurrency = 'INR';
  bool _soundEffects = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Row(
          children: const [
            Icon(LucideIcons.settings, color: Colors.white70),
            SizedBox(width: 8),
            Text('Settings', style: TextStyle(color: Colors.white)),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Notification Settings
            _buildSection(
              title: 'Notifications',
              icon: LucideIcons.bell,
              color: Colors.blue,
              children: [
                _buildSwitchTile(
                  icon: LucideIcons.calendar,
                  title: 'Tax Deadlines',
                  value: _deadlineNotifications,
                  onChanged: (value) {
                    setState(() => _deadlineNotifications = value);
                  },
                ),
                _buildSwitchTile(
                  icon: LucideIcons.lightbulb,
                  title: 'Tax Tips',
                  value: _tipsNotifications,
                  onChanged: (value) {
                    setState(() => _tipsNotifications = value);
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Appearance Settings
            _buildSection(
              title: 'Appearance',
              icon: LucideIcons.palette,
              color: Colors.purple,
              children: [
                _buildDropdownTile(
                  icon: LucideIcons.globe,
                  title: 'Language',
                  value: _selectedLanguage,
                  items: ['English', 'Hindi', 'Spanish'],
                  onChanged: (value) {
                    setState(() => _selectedLanguage = value!);
                  },
                ),
                _buildDropdownTile(
                  icon: LucideIcons.currency,
                  title: 'Currency',
                  value: _selectedCurrency,
                  items: ['INR', 'USD', 'EUR'],
                  onChanged: (value) {
                    setState(() => _selectedCurrency = value!);
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Account Settings
            _buildSection(
              title: 'Account',
              icon: LucideIcons.user,
              color: Colors.orange,
              children: [
                _buildActionTile(
                  icon: LucideIcons.link,
                  title: 'Linked Accounts',
                  subtitle: 'Manage broker connections',
                  onTap: () {
                    // Navigate to account linking page
                  },
                ),
                _buildActionTile(
                  icon: LucideIcons.cloud,
                  title: 'Backup Data',
                  subtitle: 'Save to cloud',
                  onTap: () {
                    // Trigger backup
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Privacy Settings
            _buildSection(
              title: 'Privacy',
              icon: LucideIcons.lock,
              color: Colors.greenAccent,
              children: [
                _buildActionTile(
                  icon: LucideIcons.eye,
                  title: 'Visibility',
                  subtitle: 'Control who sees your data',
                  onTap: () {
                    // Navigate to visibility settings
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Fun Settings
            _buildSection(
              title: 'Extras',
              icon: LucideIcons.star,
              color: Colors.yellow,
              children: [
                _buildSwitchTile(
                  icon: LucideIcons.music,
                  title: 'Sound Effects',
                  value: _soundEffects,
                  onChanged: (value) {
                    setState(() => _soundEffects = value);
                  },
                ),
                _buildActionTile(
                  icon: LucideIcons.trash,
                  title: 'Reset App',
                  subtitle: 'Clear all data',
                  onTap: () {
                    _showResetDialog(context);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection({
    required String title,
    required IconData icon,
    required Color color,
    required List<Widget> children,
  }) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white10,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 30),
              const SizedBox(width: 12),
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ...children,
        ],
      ),
    );
  }

  Widget _buildSwitchTile({
    required IconData icon,
    required String title,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return ListTile(
      leading: Icon(icon, color: Colors.white70),
      title: Text(title, style: const TextStyle(color: Colors.white)),
      trailing: Switch(
        value: value,
        activeColor: Colors.greenAccent,
        onChanged: onChanged,
      ),
      contentPadding: EdgeInsets.zero,
    );
  }

  Widget _buildDropdownTile({
    required IconData icon,
    required String title,
    required String value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return ListTile(
      leading: Icon(icon, color: Colors.white70),
      title: Text(title, style: const TextStyle(color: Colors.white)),
      trailing: DropdownButton<String>(
        value: value,
        items: items.map((String item) {
          return DropdownMenuItem<String>(
            value: item,
            child: Text(item, style: const TextStyle(color: Colors.black)),
          );
        }).toList(),
        onChanged: onChanged,
        dropdownColor: Colors.white,
        style: const TextStyle(color: Colors.white),
        underline: const SizedBox(),
        icon: const Icon(Icons.arrow_drop_down, color: Colors.white70),
      ),
      contentPadding: EdgeInsets.zero,
    );
  }

  Widget _buildActionTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: Colors.white70),
      title: Text(title, style: const TextStyle(color: Colors.white)),
      subtitle: Text(subtitle, style: const TextStyle(color: Colors.white70)),
      trailing:
          const Icon(Icons.arrow_forward_ios, color: Colors.white38, size: 16),
      onTap: onTap,
      contentPadding: EdgeInsets.zero,
    );
  }

  void _showResetDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.black87,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        title: Row(
          children: const [
            Icon(LucideIcons.alertTriangle, color: Colors.orange),
            SizedBox(width: 12),
            Text('Reset App', style: TextStyle(color: Colors.white)),
          ],
        ),
        content: const Text(
          'Are you sure? This will clear all your data!',
          style: TextStyle(color: Colors.white70),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child:
                const Text('Cancel', style: TextStyle(color: Colors.white70)),
          ),
          TextButton(
            onPressed: () {
              // Reset logic here
              Navigator.pop(context);
            },
            child: const Text('Reset', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
