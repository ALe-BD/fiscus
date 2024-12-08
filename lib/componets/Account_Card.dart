import 'package:flutter/material.dart';

class AccountCard extends StatelessWidget {
  final String title;
  final double amount;
  final VoidCallback? onAddMoney; // Nullable callback

  AccountCard({
    required this.title,
    required this.amount,
    this.onAddMoney, // Optional parameter
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      color: Colors.white.withOpacity(0.9), // Slightly transparent
      child: Stack(
        children: [
          Padding(
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
                  '\$${amount.toStringAsFixed(2)}',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          // Positioned "Add" button at the top right
          if (onAddMoney != null) // Only show button if onAddMoney is provided
            Positioned(
              top: 8.0,
              right: 8.0,
              child: IconButton(
                icon: Icon(
                  Icons.add,
                  color: Colors.black, // Color of the icon
                ),
                onPressed: onAddMoney, // Callback when pressed
              ),
            ),
          if (onAddMoney == null) // Grey out button if onAddMoney is null
            Positioned(
              top: 8.0,
              right: 8.0,
              child: IconButton(
                icon: Icon(
                  Icons.add,
                  color: Colors.grey, // Grey out the icon
                ),
                onPressed: null, // Disable the button
              ),
            ),
        ],
      ),
    );
  }
}
