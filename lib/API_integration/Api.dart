import 'dart:convert';
import 'package:http/http.dart' as http;

class Api {
  Future<dynamic> get({required String url}) async {
    final response = await http.get(
      Uri.parse(url),
      headers: {'accept': '*/*'},
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception(
        'Failed to load data: ${response.statusCode} with body ${response.body}',
      );
    }
  }

  Future<Map<String, dynamic>> post({
    required String url,
    required Map<String, dynamic> body,
    String? token,
  }) async {
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'accept': '*/*',
          'Content-Type': 'application/json',
          if (token != null) 'Authorization': 'Bearer $token',
        },
        body: jsonEncode(body),
      );
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception(
          'Failed to load data: ${response.statusCode} with body ${response.body}',
        );
      }
    } catch (e) {
      throw Exception('Failed to connect: $e');
    }
  }
}