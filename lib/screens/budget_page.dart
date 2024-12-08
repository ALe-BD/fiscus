import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class BudgetPage extends StatefulWidget {
  @override
  _BudgetPageState createState() => _BudgetPageState();
}

class _BudgetPageState extends State<BudgetPage> {
  // List to store budget items
  List<BudgetItem> budgetItems = [
    BudgetItem(label: 'Taxes', percentage: 65, color: Colors.blue.shade800, amount: 100),
    BudgetItem(label: 'Food', percentage: 20, color: Colors.lightBlue.shade300, amount: 100),
    BudgetItem(label: 'Entertainment', percentage: 15, color: Colors.red, amount: 100),
  ];
  // Method edit
  void _showEditBudgetItemDialog(BuildContext context, int index) {
  final TextEditingController labelController =
      TextEditingController(text: budgetItems[index].label);
  final TextEditingController percentageController =
      TextEditingController(text: budgetItems[index].percentage.toString());

  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text('Edit Budget Item'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: labelController,
              decoration: InputDecoration(labelText: 'Label'),
            ),
            TextField(
              controller: percentageController,
              decoration: InputDecoration(labelText: 'Percentage'),
              keyboardType: TextInputType.number,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              final label = labelController.text;
              final percentage = double.tryParse(percentageController.text) ?? 0;
              if (label.isNotEmpty && percentage > 0) {
                setState(() {
                  budgetItems[index] = BudgetItem(
                    label: label,
                    percentage: percentage,
                    color: budgetItems[index].color,
                    amount: budgetItems[index].amount,
                  );
                });
                checkTotalPercentage();
              }
              Navigator.of(context).pop();
            },
            child: Text('Save'),
          ),
        ],
      );
    },
  );
}  

  // Method to calculate the total percentage
  double getTotalPercentage() {
    return budgetItems.fold(0, (sum, item) => sum + item.percentage);
  }

    // Method to calculate the sections of the pie chart
  List<PieChartSectionData> getPieChartSections() {
    double totalPercentage = getTotalPercentage();

    // If the total is 0, return a faint outline of the pie chart
    if (totalPercentage == 0) {
      return [
        PieChartSectionData(
          color: Colors.grey.shade300,
          value: 1,
          radius: 70,
          showTitle: false,
        ),
      ];
    }

    // Create sections for each budget item
    List<PieChartSectionData> sections = budgetItems.map((item) {
      double adjustedPercentage = (item.percentage / 100) * 100;
      return PieChartSectionData(
        color: item.color,
        value: adjustedPercentage,
        title: '${adjustedPercentage.toStringAsFixed(1)}%',
        radius: 70,
        titleStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      );
    }).toList();

    // Add a greyed-out section for the remaining percentage
    double remainingPercentage = 100 - totalPercentage;
    if (remainingPercentage > 0) {
      sections.add(
        PieChartSectionData(
          color: Colors.grey.shade300,
          value: remainingPercentage,
          title: '${remainingPercentage.toStringAsFixed(1)}%',
          radius: 60,
          titleStyle: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.grey.shade700,
          ),
        ),
      );
    }

    return sections;
  }

  // Method to add a new budget item
  void addBudgetItem(String label, double percentage, Color color) {
    setState(() {
      budgetItems.add(BudgetItem(label: label, percentage: percentage, color: color, amount: 100));
    });
    checkTotalPercentage();
  }

  // Method to remove a budget item
  void removeBudgetItem(int index) {
    setState(() {
      budgetItems.removeAt(index);
    });
    checkTotalPercentage();
  }

  // Warn if total percentage exceeds 100%
  void checkTotalPercentage() {
    double total = getTotalPercentage();
    if (total > 100) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Warning'),
            content: Text('The total budget exceeds 100%. Adjust your values.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text('OK'),
              ),
            ],
          ),
        );
      });
    }
  }

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
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 5.0),
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
                height: 210,
                child: PieChart(
                  PieChartData(
                    sections: getPieChartSections(),
                    centerSpaceRadius: 40,
                  ),
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildCircleWithShadow(Icons.circle, Colors.grey),
                  SizedBox(width: 8),
                  _buildCircleWithShadow(Icons.circle, Colors.grey.shade300),
                  SizedBox(width: 8),
                  _buildCircleWithShadow(Icons.circle, Colors.grey.shade300),
                ],
              ),
              SizedBox(height: 20),
              // Scrollable Budget Items
              Expanded(
                child: ShaderMask(
                  shaderCallback: (Rect bounds) {
                    return LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent, // Top fade
                        Colors.black,       // Fully visible content
                        Colors.black,       // Fully visible content
                        Colors.transparent, // Bottom fade
                      ],
                      stops: [0.0, 0.02, 0.98, 1.0], // Control the fade range
                    ).createShader(bounds);
                  },
                  blendMode: BlendMode.dstIn, // Blend mode for fading
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column(
                        children: budgetItems
                          .asMap()
                          .entries
                          .map(
                            (entry) => Column(
                              children: [
                                BudgetItemCard(
                                  label: entry.value.label,
                                  percentage: '${entry.value.percentage}%',
                                  color: entry.value.color,
                                  amount: entry.value.amount*(entry.value.percentage/100),
                                  onDelete: () => removeBudgetItem(entry.key),
                                  onEdit: () => _showEditBudgetItemDialog(context, entry.key),
                              ),
                              SizedBox(height: 10),
                            ],
                          ),
                        )
                        .toList(),
            ),
          ),
        ),
      ),
    ),
              // Add Budget Item Button
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton(
                  onPressed: () {
                    _showAddBudgetItemDialog(context);
                  },
                  child: Text('Add Budget Item'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Dialog to add a new budget item
  void _showAddBudgetItemDialog(BuildContext context) {
    final TextEditingController labelController = TextEditingController();
    final TextEditingController percentageController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add Budget Item'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: labelController,
                decoration: InputDecoration(labelText: 'Label'),
              ),
              TextField(
                controller: percentageController,
                decoration: InputDecoration(labelText: 'Percentage'),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                final label = labelController.text;
                final percentage = double.tryParse(percentageController.text) ?? 0;
                if (label.isNotEmpty && percentage > 0) {
                  addBudgetItem(label, percentage, Colors.primaries[budgetItems.length % Colors.primaries.length]);
                }
                Navigator.of(context).pop();
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }
}
// Helper to create a circle with shadow
  Widget _buildCircleWithShadow(IconData icon, Color color) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 1,
            spreadRadius: 1,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Icon(icon, size: 12, color: color),
    );
  }

// Model for a budget item
class BudgetItem {
  final String label;
  final double percentage;
  final Color color;
  final double amount;

  BudgetItem({required this.label, required this.percentage, required this.color, required this.amount});
}

// Widget for Budget Item Card
class BudgetItemCard extends StatelessWidget {
  final String label;
  final String percentage;
  final double amount;
  final Color color;
  final VoidCallback? onDelete;
  final VoidCallback? onEdit;

  BudgetItemCard({
    required this.label,
    required this.percentage,
    required this.color,
    this.onDelete,
    this.onEdit,
    required this.amount,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onEdit, // Trigger edit dialog when tapped
      child: Card(
        color: color.withOpacity(0.8),
        child: ListTile(
          title: Text(
            label,
            style: TextStyle(color: Colors.white),
          ),
          subtitle: Text(
            percentage,
            style: TextStyle(color: Colors.white70),
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '\$${amount.toStringAsFixed(2)}', // Format the amount
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18, // Larger font size
                ),
              ),
              SizedBox(width: 8), // Spacing
              IconButton(
                icon: Icon(Icons.delete, color: Colors.white),
                onPressed: onDelete,
              ),
            ],
          ),
        ),
      ),
    );
  }

}
  

