import 'dart:convert';
import 'package:http/http.dart' as http;

class Api {
  Future<dynamic> get({required String url}) async {
    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {'accept': '*/*'},
      );
      print('API Response: Status=${response.statusCode}, Headers=${response.headers}, Body=${response.body}');

      if (response.statusCode >= 200 && response.statusCode < 300) {
        if (response.headers['content-type']?.contains('application/json') == true) {
          return response.body.isNotEmpty ? jsonDecode(response.body) : null;
        }
        return response.body.isNotEmpty ? response.body : null;
      } else {
        throw Exception('Failed to fetch data: Status ${response.statusCode}, Body: ${response.body}');
      }
    } catch (e) {
      print('Error in GET request: $e');
      throw Exception('Failed to connect: $e');
    }
  }

  Future<dynamic> post({
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
      print('API Response: Status=${response.statusCode}, Headers=${response.headers}, Body=${response.body}');

      if (response.statusCode >= 200 && response.statusCode < 300) {
        if (response.headers['content-type']?.contains('application/json') == true) {
          return response.body.isNotEmpty ? jsonDecode(response.body) : null;
        }
        return response.body.isNotEmpty ? response.body : null;
      } else {
        throw Exception('Failed to post data: Status ${response.statusCode}, Body: ${response.body}');
      }
    } catch (e) {
      print('Error in POST request: $e');
      throw Exception('Failed to connect: $e');
    }
  }

  Future<dynamic> put({
    required String url,
    required Map<String, dynamic> body,
    String? token,
  }) async {
    try {
      final response = await http.put(
        Uri.parse(url),
        headers: {
          'accept': '*/*',
          'Content-Type': 'application/json',
          if (token != null) 'Authorization': 'Bearer $token',
        },
        body: jsonEncode(body),
      );
      print('API Response: Status=${response.statusCode}, Headers=${response.headers}, Body=${response.body}');

      if (response.statusCode >= 200 && response.statusCode < 300) {
        if (response.headers['content-type']?.contains('application/json') == true) {
          return response.body.isNotEmpty ? jsonDecode(response.body) : null;
        }
        return response.body.isNotEmpty ? response.body : null;
      } else {
        throw Exception('Failed to update data: Status ${response.statusCode}, Body: ${response.body}');
      }
    } catch (e) {
      print('Error in PUT request: $e');
      throw Exception('Failed to connect: $e');
    }
  }

  Future<dynamic> delete({
    required String url,
    Map<String, dynamic>? body,
    String? token,
  }) async {
    try {
      final response = await http.delete(
        Uri.parse(url),
        headers: {
          'accept': '*/*',
          'Content-Type': 'application/json',
          if (token != null) 'Authorization': 'Bearer $token',
        },
        body: body != null ? jsonEncode(body) : null,
      );
      print('API Response: Status=${response.statusCode}, Headers=${response.headers}, Body=${response.body}');

      if (response.statusCode >= 200 && response.statusCode < 300) {
        // Return null for DELETE to indicate success (since body is text/plain)
        return null;
      } else {
        throw Exception('Failed to delete data: Status ${response.statusCode}, Body: ${response.body}');
      }
    } catch (e) {
      print('Error in DELETE request: $e');
      throw Exception('Failed to connect: $e');
    }
  }
}