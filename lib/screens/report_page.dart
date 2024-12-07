
import 'package:fiscus/screens/budget_page.dart';
import 'package:fiscus/screens/spending_page.dart';
import 'package:flutter/material.dart';

class ReportPage extends StatelessWidget {
  const ReportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        children: [
          BudgetPage(),
          SpendingReportPage(),
        ],
      )
    );
  }
}