import 'dart:convert';
import 'package:http/http.dart' as http;

class VitalService {
  static const String baseUrl = 'http://192.168.0.179:5000';

  Future<List<String>> fetchHealthTips() async {
    try {
      final response = await http
          .get(Uri.parse('$baseUrl/get_recommendation'))
          .timeout(const Duration(seconds: 120));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data.containsKey('tips')) {
          final tips = List<String>.from(data['tips'] ?? []);
          print('Health Tips Fetched: $tips');
          return tips;
        } else if (data.containsKey('error')) {
          print('No health tips available: ${data['error']}');
          return ['No health tips available yet.'];
        } else {
          print('Unexpected response format: ${response.body}');
          return ['Error: Unexpected response format.'];
        }
      } else {
        print('Server error: ${response.statusCode} - ${response.body}');
        return ['Error fetching health tips: Server error ${response.statusCode}.'];
      }
    } catch (e) {
      print('Error fetching health tips: $e');
      return ['Error fetching health tips: $e'];
    }
  }
}