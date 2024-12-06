// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class SpendingReportPage extends StatelessWidget {
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
                      'Spending Report',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Spacer(),
                    Icon(Icons.notifications, color: Colors.white),
                    SizedBox(width: 16),
                    Icon(Icons.more_vert, color: Colors.white),
                  ],
                ),
              ),
              SizedBox(height: 30),
              // Bar Chart Container
              Center(
                child: Container(
                  height: 350,
                  width: 350,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.8),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  padding: EdgeInsets.all(16),
                  child: BarChart(
                    BarChartData(
                      maxY: 400,
                      gridData: FlGridData(
                        show: true,
                        drawVerticalLine: false,
                        drawHorizontalLine: true,
                      ),
                      borderData: FlBorderData(show: false),
                      titlesData: FlTitlesData(
                        leftTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            interval: 100,
                            reservedSize: 40,
                            getTitlesWidget: (value, meta) {
                              return Text(
                                '\$${value.toInt()}',
                                style: TextStyle(color: Colors.black),
                              );
                            },
                          ),
                        ),
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            getTitlesWidget: (value, meta) {
                              const days = [
                                'M',
                                'T',
                                'W',
                                'Th',
                                'F',
                                'Sa',
                                'Su'
                              ];
                              return Text(
                                days[value.toInt() % days.length],
                                style: TextStyle(color: Colors.black),
                              );
                            },
                          ),
                        ),
                      ),
                      barGroups: [
                        BarChartGroupData(
                          x: 0,
                          barRods: [
                            BarChartRodData(toY: 250, color: Colors.lightBlue)
                          ],
                        ),
                        BarChartGroupData(
                          x: 1,
                          barRods: [
                            BarChartRodData(toY: 200, color: Colors.lightBlue)
                          ],
                        ),
                        BarChartGroupData(
                          x: 2,
                          barRods: [
                            BarChartRodData(toY: 280, color: Colors.lightBlue)
                          ],
                        ),
                        BarChartGroupData(
                          x: 3,
                          barRods: [
                            BarChartRodData(toY: 220, color: Colors.lightBlue)
                          ],
                        ),
                        BarChartGroupData(
                          x: 4,
                          barRods: [
                            BarChartRodData(toY: 300, color: Colors.lightBlue)
                          ],
                        ),
                        BarChartGroupData(
                          x: 5,
                          barRods: [
                            BarChartRodData(toY: 180, color: Colors.lightBlue)
                          ],
                        ),
                        BarChartGroupData(
                          x: 6,
                          barRods: [
                            BarChartRodData(toY: 350, color: Colors.lightBlue)
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildCircleWithShadow(Icons.circle, Colors.grey.shade300),
                  SizedBox(width: 8),
                  _buildCircleWithShadow(Icons.circle, Colors.grey),
                  SizedBox(width: 8),
                  _buildCircleWithShadow(Icons.circle, Colors.grey.shade300),
                ],
              ),
              SizedBox(height: 20),
              // Scrollable Content
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300.withOpacity(0.8),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        children: [
                          SizedBox(height: 20),
                          Text(
                            'Additional content goes here',
                            style: TextStyle(fontSize: 16),
                          ),
                          SizedBox(height: 300), // Example content height
                        ],
                      ),
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
  // Helper to create a circle with shadow
  Widget _buildCircleWithShadow(IconData icon, Color color) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 6,
            spreadRadius: 2,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Icon(icon, size: 12, color: color),
    );
  }
}

