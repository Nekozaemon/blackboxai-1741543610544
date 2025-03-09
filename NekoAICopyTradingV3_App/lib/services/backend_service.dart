import 'dart:convert';
import 'package:http/http.dart' as http;

class BackendService {
  final String baseUrl = 'http://127.0.0.1:5000';

  Future<List<dynamic>> fetchTradingSignals() async {
    final response = await http.get(Uri.parse('$baseUrl/signals'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load trading signals');
    }
  }

  Future<List<dynamic>> fetchActiveTrades() async {
    final response = await http.get(Uri.parse('$baseUrl/trades'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load active trades');
    }
  }

  Future<void> updateTrade(int id, double tp, double sl) async {
    final response = await http.post(
      Uri.parse('$baseUrl/trades/update'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode({
        'id': id,
        'tp': tp,
        'sl': sl,
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update trade');
    }
  }
}
