import 'dart:convert';
import 'package:grad_project/API_integration/api.dart';
import 'package:grad_project/API_integration/models/LoginModel.dart';

class LoginService {
  Future<LoginModel> login({
    required String email,
    required String password,
  }) async {
    try {
      final loginModel = LoginModel(
        email: email,
        password: password,
      );
      print('Request Body: ${jsonEncode(loginModel.toJson())}');
      final response = await Api().post(
        url: "http://nabdapi.runasp.net/login",
        body: loginModel.toJson(),
      );
      return LoginModel.fromJson(response);
    } catch (e) {
      throw Exception("Failed to register: $e");
    }
  }
}