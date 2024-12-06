import 'package:flutter/material.dart';

class BudgetItemCard extends StatelessWidget {
  final String label;
  final String percentage;
  final Color color;

  BudgetItemCard(
      {required this.label, required this.percentage, required this.color});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: color.withOpacity(0.9),
      margin: EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        title: Text(
          percentage,
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
        subtitle: Text(
          label,
          style: TextStyle(color: Colors.white, fontSize: 14),
        ),
        trailing: Icon(Icons.more_vert, color: Colors.white),
      ),
    );
  }
}
