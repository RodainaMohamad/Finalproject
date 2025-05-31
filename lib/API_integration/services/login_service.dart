import 'dart:convert';
import 'package:http/http.dart' as http;

class LoginService {
  final String apiUrl = "http://nabdapi.runasp.net/login";

  Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': email,
          'password': password,
          'twoFactorCode': '',
          'twoFactorRecoveryCode': ''
        }),
      );

      print(
          "API Response: Status=${response.statusCode}, Body=${response.body}");

      if (response.statusCode == 200) {
        if (response.body.isEmpty) {
          throw Exception('Login API returned an empty response body.');
        }

        final dynamic decodedData = jsonDecode(response.body);

        if (decodedData is Map) {
          final Map<String, dynamic> data = Map<String, dynamic>.from(
              decodedData);

          final String? accessToken = data['accessToken'] as String?;
          final String? refreshToken = data['refreshToken'] as String?;
          final String? tokenType = data['tokenType'] as String?;

          if (accessToken == null || accessToken.isEmpty) {
            throw Exception('Login API response missing or empty accessToken.');
          }

          return {
            'accessToken': accessToken,
            'refreshToken': refreshToken,
            'tokenType': tokenType,
          };
        } else {
          throw Exception(
              'Login API returned unexpected data format: ${decodedData
                  .runtimeType}. Expected Map.');
        }
      } else {
        String errorMessage = 'Failed to login: ${response.statusCode}';
        try {
          final errorBody = jsonDecode(response.body);
          if (errorBody is Map && errorBody.containsKey('message')) {
            errorMessage += ' - ${errorBody['message']}';
          } else if (errorBody is String && errorBody.isNotEmpty) {
            errorMessage += ' - $errorBody';
          }
        } catch (e) {
          print(
              'Warning: Could not parse error response body: ${response.body}');
        }
        throw Exception(errorMessage);
      }
    } catch (e) {
      print('LoginService caught unexpected error: $e');
      throw Exception('Login API call failed: $e');
    }
  }
}