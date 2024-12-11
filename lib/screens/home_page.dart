import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fiscus/componets/Account_Card.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fiscus/componets/receipts_page.dart';
import 'package:fiscus/componets/receipts_card.dart';
import 'dart:convert';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _userName = 'Loading...';
  List<Map<String, dynamic>> _receipts = [];
  @override
  void initState() {
    super.initState();
    _getUserName();
  }

  // Load the receipts from SharedPreferences
  Future<void> _loadReceipts() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> savedReceipts = prefs.getStringList('receipts') ?? [];

    // Convert the list of string receipts back into List<Map<String, dynamic>>
    setState(() {
      _receipts = savedReceipts
          .map((receipt) => json.decode(receipt) as Map<String, dynamic>)
          .toList();
    });
  }

  Future<void> _getUserName() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      setState(() {
        _userName = prefs.getString('first_name') ?? 'User';
      });
    } catch (e) {
      print('Error fetching user name: $e');
    }
  }

  // Navigate to ReceiptsPage and pass a callback to reload receipts
  void _viewReceipts() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ReceiptsPage(
          onReceiptChanged:
              _loadReceipts, // Pass the callback to reload receipts
        ),
      ),
    );
  }

  // Initialize account balances
  double debitBalance = 14000.0;
  double creditBalance = 0.0;
  double savingsBalance = 0.0;
  double walletBalance = 0.0;
  double balance = 14000.0;

  void totalBalanceCal(BuildContext context) {
    balance = debitBalance + walletBalance;
  }

  // Function to update account balances
  void _showAddMoneyDialog(BuildContext context) {
    final TextEditingController amountController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add Money to Wallet'),
          content: TextField(
            controller: amountController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(hintText: 'Enter amount'),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(), // Close dialog
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                final enteredAmount = double.tryParse(amountController.text);
                if (enteredAmount != null) {
                  setState(() {
                    walletBalance +=
                        enteredAmount; // Update balance using setState
                  });
                  totalBalanceCal(context);
                }
                Navigator.of(context).pop(); // Close dialog
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("lib/assets/Login-Setup.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Column(
            children: [
              SizedBox(height: 50),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 24,
                      backgroundColor: Colors.grey,
                    ),
                    SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Welcome,',
                          style: TextStyle(fontSize: 30, color: Colors.white),
                        ),
                        Text(
                          _userName,
                          style: TextStyle(fontSize: 30, color: Colors.white),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        // Shadow text
                        Text(
                          'Total Balance: \$${balance.toStringAsFixed(2)}',
                          style: TextStyle(
                            fontSize: 23.2,

                            color:
                                Colors.black.withOpacity(0.5), // Shadow color
                          ),
                        ),
                        // Foreground text
                        Text(
                          'Total Balance: \$${balance.toStringAsFixed(2)}',
                          style: TextStyle(
                            fontSize: 23,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Wells Fargo:',
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ],
                ),
              ),
              // Scrollable Area with Edge Fading
              Expanded(
                child: ShaderMask(
                  shaderCallback: (Rect bounds) {
                    return LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent, // Top fade
                        Colors.black, // Fully visible content
                        Colors.black, // Fully visible content
                        Colors.transparent, // Bottom fade
                      ],
                      stops: [0.0, 0.01, 0.99, 1.0], // Control the fade range
                    ).createShader(bounds);
                  },
                  blendMode: BlendMode.dstIn, // Blend mode for fading
                  child: SingleChildScrollView(
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            AccountCard(
                              title: 'Debit',
                              amount: debitBalance,
                            ),
                            AccountCard(
                              title: 'Credit',
                              amount: creditBalance,
                            ),
                            AccountCard(
                              title: 'Savings',
                              amount: savingsBalance,
                            ),
                            ReceiptsCard(
                              title: 'Receipts',
                              onTap: _viewReceipts, // Navigate to ReceiptsPage
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.circle, size: 20, color: Colors.grey),
                    SizedBox(width: 8),
                    Icon(Icons.circle, size: 16, color: Colors.grey.shade300),
                    SizedBox(width: 8),
                    Icon(Icons.circle, size: 16, color: Colors.grey.shade300),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
