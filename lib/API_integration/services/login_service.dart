import 'package:grad_project/API_integration/api.dart';

class LoginService {
  final Api _api = Api();

  Future<Map<String, String>> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _api.post(
        url: "http://nabdapi.runasp.net/login",
        body: {
          'email': email,
          'password': password,
          'twoFactorCode': '',
          'twoFactorRecoveryCode': '',
        },
      );
      final accessToken = response['accessToken'] as String?;
      final refreshToken = response['refreshToken'] as String?;

      if (accessToken == null || refreshToken == null) {
        throw Exception('Missing access token or refresh token in response');
      }
      return {
        'accessToken': accessToken,
        'refreshToken': refreshToken,
      };
    } catch (e) {
      throw Exception('Login failed: ${e.toString()}');
    }
  }
}