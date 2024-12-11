import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class ReceiptsPage extends StatefulWidget {
  final Function? onReceiptChanged; // Callback to notify HomePage

  const ReceiptsPage({this.onReceiptChanged});

  @override
  _ReceiptsPageState createState() => _ReceiptsPageState();
}

class _ReceiptsPageState extends State<ReceiptsPage> {
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

  // Delete receipt from SharedPreferences and update the UI
  Future<void> _deleteReceipt(int index) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> savedReceipts = prefs.getStringList('receipts') ?? [];

    // Remove the receipt from the list
    savedReceipts.removeAt(index);

    // Save the updated list back to SharedPreferences
    await prefs.setStringList('receipts', savedReceipts);

    // Reload the receipts after deletion
    setState(() {
      _savedReceipts = savedReceipts; // Update the local list immediately
    });

    // Notify the HomePage to reload receipts
    if (widget.onReceiptChanged != null) {
      widget.onReceiptChanged!();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Receipts')),
      body: Column(
        children: [
          // Display the number of receipts scanned at the top
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              '${_savedReceipts.length} receipts scanned', // Display count
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          // Display the list of receipts
          Expanded(
            child: ListView.builder(
              itemCount: _savedReceipts.length,
              itemBuilder: (context, index) {
                final receipt = json.decode(_savedReceipts[index]);
                return ListTile(
                  title: Text(receipt['business_name'] ?? 'Unknown Business'),
                  subtitle: Text('${receipt['total']} | ${receipt['date']}'),
                  trailing: IconButton(
                    icon: Icon(Icons.delete, color: Colors.red),
                    onPressed: () =>
                        _deleteReceipt(index), // Call the delete function
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
