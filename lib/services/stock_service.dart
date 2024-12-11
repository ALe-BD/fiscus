
import 'dart:convert';
import 'package:http/http.dart' as http;

class StockService {
  static const String apiKey = 'YOUR_ALPHA_VANTAGE_API_KEY'; // Replace with your API key
  static const String baseUrl = 'https://www.alphavantage.co/query';

  Future<Map<String, dynamic>> getStockQuote(String symbol) async {
    final response = await http.get(
      Uri.parse('$baseUrl?function=GLOBAL_QUOTE&symbol=$symbol&apikey=$apiKey'),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data.containsKey('Global Quote')) {
        return data['Global Quote'];
      } else {
        throw Exception('No stock data found');
      }
    } else {
      throw Exception('Failed to load stock data');
    }
  }
}