
import 'package:fiscus/screens/report_page.dart';
import 'package:fiscus/screens/stock_page.dart';
import 'package:flutter/material.dart';
import 'home_page.dart';
import 'camera_page.dart';
import 'setting_page.dart';
import 'stocks_page.dart';
import 'budget_page.dart';
import 'spending_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  // List of pages to navigate to
  final List<Widget> _pages = [
    HomePage(), // Home page
    ReportPage(), // Reports page
    CameraPage(), // Camera page
    StockPage(), // Stocks page
    SettingsPage(), // Settings page
  ];

  // Function to handle navigation item selection
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Accounts',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: 'Reports',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.camera_alt),
            label: 'Camera',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.attach_money),
            label: 'Stocks',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        selectedItemColor: Colors.blue, // Selected icon color
        unselectedItemColor: Colors.grey, // Unselected icon color
      ),
    );
  }
}