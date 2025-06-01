import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:grad_project/API_integration/utility.dart';

class LoginService {
  final String loginUrl = "http://nabdapi.runasp.net/login";

  Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    try {
      // Clear previous userType to avoid stale data
      await AuthUtils.clearUserType();

      final loginResponse = await http.post(
        Uri.parse(loginUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': email,
          'password': password,
          'twoFactorCode': '',
          'twoFactorRecoveryCode': '',
        }),
      );

      print("Login API Response: Status=${loginResponse
          .statusCode}, Body=${loginResponse.body}");

      if (loginResponse.statusCode == 200) {
        if (loginResponse.body.isEmpty) {
          throw Exception('Login API returned an empty response body.');
        }

        final dynamic decodedData = jsonDecode(loginResponse.body);

        if (decodedData is Map) {
          final Map<String, dynamic> data = Map<String, dynamic>.from(
              decodedData);

          final String? accessToken = data['accessToken'] as String?;
          final String? refreshToken = data['refreshToken'] as String?;
          final String? tokenType = data['tokenType'] as String?;

          if (accessToken == null || accessToken.isEmpty) {
            throw Exception('Login API response missing or empty accessToken.');
          }

          // Save tokens
          await AuthUtils.saveToken(accessToken);
          if (refreshToken != null) {
            await AuthUtils.saveRefreshToken(refreshToken);
          }
          await AuthUtils.savePatientName(email.split('@')[0]);

          // Infer userType based on email
          String userType = email.toLowerCase().contains('doc')
              ? 'Doctor'
              : 'Patient';
          await AuthUtils.saveUserType(userType);
          print('DEBUG: Inferred and saved userType: $userType');

          return {
            'accessToken': accessToken,
            'refreshToken': refreshToken,
            'tokenType': tokenType,
            'userType': userType,
          };
        } else {
          throw Exception(
              'Login API returned unexpected data format: ${decodedData
                  .runtimeType}. Expected Map.');
        }
      } else {
        String errorMessage = 'Failed to login: ${loginResponse.statusCode}';
        try {
          final errorBody = jsonDecode(loginResponse.body);
          if (errorBody is Map && errorBody.containsKey('message')) {
            errorMessage += ' - ${errorBody['message']}';
          } else if (errorBody is String && errorBody.isNotEmpty) {
            errorMessage += ' - $errorBody';
          }
        } catch (e) {
          print('Warning: Could not parse error response body: ${loginResponse
              .body}');
        }
        throw Exception(errorMessage);
      }
    } catch (e) {
      print('LoginService caught unexpected error: $e');
      throw Exception('Login API call failed: $e');
    }
  }
}