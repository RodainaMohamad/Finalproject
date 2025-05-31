import 'package:grad_project/API_integration/api.dart';
import 'package:grad_project/API_integration/models/registerModel.dart';
import 'dart:convert';

class RegisterService {
  Future<RegisterModel> register({
    required String fullName,
    required String email,
    required String gender,
    required String dateOfBirth,
    required String nationalId,
    required String phoneNumber,
    String? userType,
    String? specialty,
    required String password,
    required String confirmPassword,
  }) async {
    try {
      final registerModel = RegisterModel(
        fullName: fullName,
        email: email,
        gender: gender,
        dateOfBirth: dateOfBirth,
        nationalId: nationalId,
        phoneNumber: phoneNumber,
        userType: userType ?? 'Patient',
        specialty: specialty ,
        password: password,
        confirmPassword: confirmPassword,
      );
      print('Request Body: ${jsonEncode(registerModel.toJson())}');
      final response = await Api().post(
        url: "http://nabdapi.runasp.net/register-user",
        body: registerModel.toJson(),
      );

      return RegisterModel.fromJson(response);
    } catch (e) {
      throw Exception("Failed to register: $e");
    }
  }
}