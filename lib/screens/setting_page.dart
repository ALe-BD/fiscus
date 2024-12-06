// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:fiscus/componets/setting_tiles.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
        backgroundColor: Colors.blueGrey,
      ),
      body: ListView(
        children: [
          // Account Settings Section
          SettingsSection(
            title: "Account",
            tiles: [
              SettingsTile(
                icon: Icons.person,
                title: "Profile",
                subtitle: "Edit your profile details",
                onTap: () {
                  // Handle profile tap
                },
              ),
              SettingsTile(
                icon: Icons.lock,
                title: "Password",
                subtitle: "Change your password",
                onTap: () {
                  // Handle password tap
                },
              ),
              SettingsTile(
                icon: Icons.security,
                title: "Privacy",
                subtitle: "Manage your privacy settings",
                onTap: () {
                  // Handle privacy tap
                },
              ),
            ],
          ),
          // Notifications Section
          SettingsSection(
            title: "Notifications",
            tiles: [
              SettingsTile(
                icon: Icons.notifications,
                title: "Push Notifications",
                trailing: Switch(value: true, onChanged: (val) {}),
              ),
              SettingsTile(
                icon: Icons.email,
                title: "Email Notifications",
                trailing: Switch(value: false, onChanged: (val) {}),
              ),
              SettingsTile(
                icon: Icons.sms,
                title: "SMS Notifications",
                trailing: Switch(value: false, onChanged: (val) {}),
              ),
            ],
          ),
          // General Settings Section
          SettingsSection(
            title: "General",
            tiles: [
              SettingsTile(
                icon: Icons.language,
                title: "Language",
                subtitle: "English",
                onTap: () {
                  // Handle language tap
                },
              ),
              SettingsTile(
                icon: Icons.palette,
                title: "Theme",
                subtitle: "Light",
                onTap: () {
                  // Handle theme tap
                },
              ),
            ],
          ),
          // About Section
          SettingsSection(
            title: "About",
            tiles: [
              SettingsTile(
                icon: Icons.info,
                title: "About Us",
                onTap: () {
                  // Handle About Us tap
                },
              ),
              SettingsTile(
                icon: Icons.help,
                title: "Help",
                onTap: () {
                  // Handle Help tap
                },
              ),
              SettingsTile(
                icon: Icons.logout,
                title: "Logout",
                titleColor: Colors.red,
                onTap: () {
                  // Handle logout
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class SettingsSection extends StatelessWidget {
  final String title;
  final List<Widget> tiles;

  SettingsSection({required this.title, required this.tiles});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade700,
            ),
          ),
          SizedBox(height: 8),
          Column(children: tiles),
          Divider(thickness: 1),
        ],
      ),
    );
  }
}
