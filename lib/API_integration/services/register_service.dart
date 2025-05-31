import 'package:grad_project/API_integration/api.dart';
import 'dart:convert';
import 'package:grad_project/API_integration/models/RegisterResponseModel.dart';
import 'package:grad_project/API_integration/models/registerModel.dart';
import 'package:grad_project/API_integration/utility.dart';

class RegisterService {
  Future<RegisterResponseModel> register({
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
        specialty: specialty,
        password: password,
        confirmPassword: confirmPassword,
      );
      print('Request Body: ${jsonEncode(registerModel.toJson())}');
      final response = await Api().post(
        url: "http://nabdapi.runasp.net/register-user",
        body: registerModel.toJson(),
      );

      if (response != null) {
        final registerResponse = RegisterResponseModel.fromJson(response);
        if (registerResponse.id != null) {
          await AuthUtils.savePatientId(registerResponse.id!.toString());
          await AuthUtils.savePatientName(fullName);
          await AuthUtils.saveUserType(userType ?? 'Patient');
          print('DEBUG: Saved patient ID: ${registerResponse.id}, Name: $fullName, Type: ${userType ?? 'Patient'}');
        } else {
          print('WARNING: No ID in registration response');
        }
        return registerResponse;
      }
      throw Exception('No registration data returned');
    } catch (e) {
      print('Registration Error: $e');
      throw Exception('Failed to register: $e');
    }
  }
}