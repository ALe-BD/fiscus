// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:fiscus/componets/BudgetItemCard.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class BudgetPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("lib/assets/Login-Setup.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Overlay Content
          Column(
            children: [
              SizedBox(height: 50), // Adjust for spacing
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
                    Text(
                      'Budget Report',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Spacer(),
                    Icon(Icons.notifications, color: Colors.black),
                    SizedBox(width: 16),
                    Icon(Icons.more_vert, color: Colors.black),
                  ],
                ),
              ),
              SizedBox(height: 30),
              // Circular Progress (Budget Pie Chart)
              SizedBox(
                height: 200,
                child: PieChart(
                  PieChartData(
                    sections: [
                      PieChartSectionData(
                        color: Colors.blue.shade800,
                        value: 65,
                        title: '65%',
                        radius: 50,
                        titleStyle: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      PieChartSectionData(
                        color: Colors.lightBlue.shade300,
                        value: 20,
                        title: '20%',
                        radius: 50,
                        titleStyle: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      PieChartSectionData(
                        color: Colors.lightBlueAccent,
                        value: 2.5,
                        title: '2.5%',
                        radius: 50,
                        titleStyle: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.circle, size: 8, color: Colors.grey),
                  SizedBox(width: 8),
                  Icon(Icons.circle, size: 8, color: Colors.grey.shade300),
                  SizedBox(width: 8),
                  Icon(Icons.circle, size: 8, color: Colors.grey.shade300),
                ],
              ),
              SizedBox(height: 20),
              // Scrollable Budget Items
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      children: [
                        BudgetItemCard(
                          label: 'Taxes',
                          percentage: '65%',
                          color: Colors.blue.shade800,
                        ),
                        SizedBox(height: 10),
                        BudgetItemCard(
                          label: 'Food',
                          percentage: '20%',
                          color: Colors.lightBlue.shade300,
                        ),
                        SizedBox(height: 10),
                        BudgetItemCard(
                          label: 'Entertainment',
                          percentage: '2.5%',
                          color: Colors.lightBlueAccent,
                        ),
                        // Add more BudgetItemCards here as needed
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
