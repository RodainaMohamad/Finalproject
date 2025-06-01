import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthUtils {
  static const _storage = FlutterSecureStorage();
  static const _keyToken = 'accessToken';
  static const _keyRefreshToken = 'refreshToken';
  static const _keyPatientName = 'patientName';
  static const _keyUserType = 'userType';

  static Future<void> saveToken(String token) async {
    await _storage.write(key: _keyToken, value: token);
    print('DEBUG: Token saved securely');
  }

  static Future<String?> getToken() async {
    return await _storage.read(key: _keyToken);
  }

  static Future<void> saveRefreshToken(String refreshToken) async {
    await _storage.write(key: _keyRefreshToken, value: refreshToken);
    print('DEBUG: Refresh token saved securely');
  }

  static Future<String?> getRefreshToken() async {
    return await _storage.read(key: _keyRefreshToken);
  }

  static Future<void> savePatientName(String name) async {
    await _storage.write(key: _keyPatientName, value: name);
    print('DEBUG: Patient name saved securely: $name');
  }

  static Future<String?> getPatientName() async {
    final name = await _storage.read(key: _keyPatientName);
    print('DEBUG: Patient name retrieved: $name');
    return name;
  }

  static Future<void> saveUserType(String userType) async {
    await _storage.write(key: _keyUserType, value: userType);
    print('DEBUG: User type saved securely: $userType');
  }

  static Future<String?> getUserType() async {
    final userType = await _storage.read(key: _keyUserType);
    print('DEBUG: User type retrieved: $userType');
    return userType;
  }

  static Future<void> clearUserType() async {
    await _storage.delete(key: _keyUserType);
    print('DEBUG: User type cleared from storage');
  }

  static Future<void> clearToken() async {
    await _storage.delete(key: _keyToken);
    await _storage.delete(key: _keyRefreshToken);
    await _storage.delete(key: _keyPatientName);
    await _storage.delete(key: _keyUserType);
  }
}