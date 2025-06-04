import 'package:http/http.dart' as http;
import 'dart:convert';

class Api {
  Future<Map<String, dynamic>?> post({
    required String url,
    required Map<String, dynamic> body,
    String? token,
  }) async {
    try {
      final headers = {
        'Content-Type': 'application/json',
        if (token != null) 'Authorization': 'Bearer $token',
      };
      final response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: jsonEncode(body),
      );
      print('API Response: Status=${response.statusCode}, Headers=${response.headers}, Body=${response.body}');
      if (response.statusCode >= 200 && response.statusCode < 300) {
        return response.body.isNotEmpty ? jsonDecode(response.body) as Map<String, dynamic> : {};
      } else {
        throw Exception('Failed to post data: Status ${response.statusCode}, Body: ${response.body}');
      }
    } catch (e) {
      print('Error in POST request: $e');
      throw Exception('Failed to connect: $e');
    }
  }

  Future<dynamic> get({
    required String url,
    String? token,
  }) async {
    try {
      final headers = {
        'Accept': '*/*',
        if (token != null) 'Authorization': 'Bearer $token',
      };
      final response = await http.get(
        Uri.parse(url),
        headers: headers,
      );
      print('API Response: Status=${response.statusCode}, Body=${response.body}');
      if (response.statusCode >= 200 && response.statusCode < 300) {
        if (response.body.isNotEmpty) {
          return jsonDecode(response.body);
        } else {
          return null;
        }
      } else {
        throw Exception('Failed to get data: Status ${response.statusCode}, Body: ${response.body}');
      }
    } catch (e) {
      print('Error in GET request: $e');
      throw Exception('Failed to connect: $e');
    }
  }

  Future<Map<String, dynamic>?> put({
    required String url,
    required Map<String, dynamic> body,
    String? token,
  }) async {
    try {
      final headers = {
        'Content-Type': 'application/json',
        'Accept': '*/*',
        if (token != null) 'Authorization': 'Bearer $token',
      };
      final response = await http.put(
        Uri.parse(url),
        headers: headers,
        body: jsonEncode(body),
      );
      print('API Response: Status=${response.statusCode}, Headers=${response.headers}, Body=${response.body}');
      if (response.statusCode >= 200 && response.statusCode < 300) {
        return response.body.isNotEmpty ? jsonDecode(response.body) as Map<String, dynamic> : {};
      } else {
        throw Exception('Failed to put data: Status ${response.statusCode}, Body: ${response.body}');
      }
    } catch (e) {
      print('Error in PUT request: $e');
      throw Exception('Failed to connect: $e');
    }
  }

  Future<Map<String, dynamic>?> delete({
    required String url,
    String? token,
  }) async {
    try {
      final headers = {
        'Accept': '*/*',
        if (token != null) 'Authorization': 'Bearer $token',
      };
      final response = await http.delete(
        Uri.parse(url),
        headers: headers,
      );
      print('API Response: Status=${response.statusCode}, Headers=${response.headers}, Body=${response.body}');
      if (response.statusCode >= 200 && response.statusCode < 300) {
        return response.body.isNotEmpty ? jsonDecode(response.body) as Map<String, dynamic> : {};
      } else {
        throw Exception('Failed to delete data: Status ${response.statusCode}, Body: ${response.body}');
      }
    } catch (e) {
      print('Error in DELETE request: $e');
      throw Exception('Failed to connect: $e');
    }
  }
}