import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class ReceiptsCard extends StatefulWidget {
  final String title;
  final VoidCallback? onTap;

  const ReceiptsCard({
    required this.title,
    this.onTap,
  });

  @override
  _ReceiptsCardState createState() => _ReceiptsCardState();
}

class _ReceiptsCardState extends State<ReceiptsCard> {
  List<String> _savedReceipts = [];

  @override
  void initState() {
    super.initState();
    _loadReceipts();
  }

  // Load receipts from SharedPreferences
  Future<void> _loadReceipts() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> savedReceipts = prefs.getStringList('receipts') ?? [];

    setState(() {
      _savedReceipts = savedReceipts;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      color: Colors.white.withOpacity(0.9), // Slightly transparent
      child: InkWell(
        onTap: widget.onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.title,
                      style:
                          TextStyle(fontSize: 18, color: Colors.grey.shade700),
                    ),
                    SizedBox(height: 8),
                  ],
                ),
              ),
              Icon(
                Icons.receipt_long,
                color: Colors.black, // Icon color
              ),
            ],
          ),
        ),
      ),
    );
  }
}
