import 'package:flutter/material.dart';

class AccountCard extends StatelessWidget {
  final String title;
  final String amount;

  AccountCard({required this.title, required this.amount});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      color: Colors.white
          .withOpacity(0.9), // Slightly transparent to blend with background
      child: Padding(
        padding: const EdgeInsets.only(
            left: 20, right: 250, bottom: 16.0, top: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 18, color: Colors.grey.shade700),
            ),
            SizedBox(height: 8),
            Text(
              amount,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
