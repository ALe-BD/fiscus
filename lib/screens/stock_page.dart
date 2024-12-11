import 'package:flutter/material.dart';
import '../services/stock_service.dart';

class StockPage extends StatefulWidget {
  const StockPage({super.key});

  @override
  State<StockPage> createState() => _StockPageState();
}

class _StockPageState extends State<StockPage> {
  final _searchController = TextEditingController();
  final _stockService = StockService();
  String? stockSymbol;
  double? stockPrice;
  bool _isLoading = false;
  String? _error;

  Future<void> _searchStock() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final quote = await _stockService.getStockQuote(_searchController.text);
      setState(() {
        stockSymbol = quote['01. symbol'];
        stockPrice = double.parse(quote['05. price']);
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stock Search'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Enter stock symbol',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: _searchStock,
                ),
              ),
            ),
            const SizedBox(height: 20),
            if (_isLoading)
              const CircularProgressIndicator()
            else if (_error != null)
              Text(
                _error!,
                style: const TextStyle(color: Colors.red),
              )
            else if (stockSymbol != null)
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Text(
                        'Stock: $stockSymbol',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Price: \$${stockPrice?.toStringAsFixed(2) ?? "N/A"}',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}