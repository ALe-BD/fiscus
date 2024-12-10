import 'package:flutter/material.dart';

class AccountCard extends StatelessWidget {
  final String title;
  final double amount;
  final VoidCallback? onAddMoney;

  AccountCard({
    required this.title,
    required this.amount,
    this.onAddMoney,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      color: Colors.white.withOpacity(0.9), // Slightly transparent
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(fontSize: 18, color: Colors.grey.shade700),
                  ),
                  SizedBox(height: 8),
                  Text(
                    '\$${amount.toStringAsFixed(2)}',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    overflow: TextOverflow.ellipsis, // Prevent overflow issues
                  ),
                ],
              ),
            ),
          ),
          if (onAddMoney != null) // Only show button if onAddMoney is provided
            IconButton(
              icon: Icon(
                Icons.add,
                color: Colors.black, // Color of the icon
              ),
              onPressed: onAddMoney, // Callback when pressed
            )
          else
            IconButton(
              icon: Icon(
                Icons.add,
                color: Colors.grey, // Grey out the icon
              ),
              onPressed: null, // Disable the button
            ),
        ],
      ),
    );
  }
}