import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthUtils {
  static const _storage = FlutterSecureStorage();
  static const String _tokenKey = 'auth_token';
  static const String _refreshTokenKey = 'refresh_token';
  static const String _patientNameKey = 'patient_name';
  static const String _userTypeKey = 'user_type';

  static Future<void> saveToken(String token) async {
    await _storage.write(key: _tokenKey, value: token);
    print('DEBUG: Token saved securely');
  }

  static Future<void> saveRefreshToken(String refreshToken) async {
    await _storage.write(key: _refreshTokenKey, value: refreshToken);
    print('DEBUG: Refresh token saved securely');
  }

  static Future<void> savePatientName(String name) async {
    await _storage.write(key: _patientNameKey, value: name);
    print('DEBUG: Patient name saved securely: $name');
  }

  static Future<void> saveUserType(String type) async {
    await _storage.write(key: _userTypeKey, value: type);
    print('DEBUG: User type saved securely: $type');
  }

  static Future<String?> getToken() async {
    final token = await _storage.read(key: _tokenKey);
    print('DEBUG: Token retrieved: ${token != null ? 'exists' : 'null'}');
    return token;
  }

  static Future<String?> getRefreshToken() async {
    final token = await _storage.read(key: _refreshTokenKey);
    print('DEBUG: Refresh token retrieved: ${token != null ? 'exists' : 'null'}');
    return token;
  }

  static Future<String?> getPatientName() async {
    final name = await _storage.read(key: _patientNameKey);
    print('DEBUG: Patient name retrieved: $name');
    return name;
  }

  static Future<String?> getUserType() async {
    final type = await _storage.read(key: _userTypeKey);
    print('DEBUG: User type retrieved: $type');
    return type;
  }

  static Future<void> clearToken() async {
    await _storage.delete(key: _tokenKey);
    await _storage.delete(key: _refreshTokenKey);
    await _storage.delete(key: _patientNameKey);
    await _storage.delete(key: _userTypeKey);
    print('DEBUG: Tokens, name, and user type cleared securely');
  }
}