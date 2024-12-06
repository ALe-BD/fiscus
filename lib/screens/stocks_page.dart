// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:fiscus/componets/Stock_Item.dart';
import 'package:flutter/material.dart';

class StocksPage extends StatelessWidget {
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
                      'Stocks',
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
              // Stocks List Container
              Center(
                child: Container(
                  width: 350,
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.8),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      StockItem(
                        name: "Dow Jones",
                        symbol: "Dow Jones Industrial Average",
                        price: "40,696.21",
                        change: "+1.91%",
                        isPositive: true,
                      ),
                      StockItem(
                        name: "S&P 500",
                        symbol: "Standard & Poor's 500",
                        price: "5,480.03",
                        change: "+1.50%",
                        isPositive: true,
                      ),
                      StockItem(
                        name: "^FTSE",
                        symbol: "FTSE 100",
                        price: "8,285.71",
                        change: "+1.21%",
                        isPositive: true,
                      ),
                      StockItem(
                        name: "GE",
                        symbol: "GE Aerospace",
                        price: "171.01",
                        change: "+3.85%",
                        isPositive: true,
                      ),
                      StockItem(
                        name: "AAPL",
                        symbol: "Apple Inc.",
                        price: "219.37",
                        change: "+0.86%",
                        isPositive: true,
                      ),
                      StockItem(
                        name: "NKE",
                        symbol: "NIKE, Inc.",
                        price: "72.44",
                        change: "+1.45%",
                        isPositive: true,
                      ),
                    ],
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
