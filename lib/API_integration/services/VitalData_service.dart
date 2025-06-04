import 'dart:convert';
import 'package:http/http.dart' as http;

class VitalService {
  static const String baseUrl = 'https://d9b1-2a09-bac5-d57c-leb-00-31-102.ngrok-free.app';

  Future<List<String>> fetchHealthTips() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/api/current'));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final tips = List<String>.from(data['tips'] ?? []);
        print('Health Tips Fetched: $tips');
        return tips;
      } else if (response.statusCode == 404) {
        print('No health tips available yet: ${response.body}');
        return ['No health tips available yet.'];
      } else {
        print('Server error: ${response.statusCode} - ${response.body}');
        return ['Error fetching health tips.'];
      }
    } catch (e) {
      print('Error fetching health tips: $e');
      return ['Error fetching health tips: $e'];
    }
  }
}