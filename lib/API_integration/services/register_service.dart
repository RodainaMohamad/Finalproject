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
        url: "http://nabdapi.runasp.net/api/patient/register", // Update if endpoint changes
        body: registerModel.toJson(),
      );

      print('DEBUG: Registration API Response: Status=${response['status']}, Body=$response');

      if (response != null && response['status'] == 200) {
        final registerResponse = RegisterResponseModel.fromJson(response);
        if (registerResponse.id != null) {
          await AuthUtils.savePatientId(registerResponse.id!.toString());
          await AuthUtils.savePatientName(fullName);
          await AuthUtils.saveUserType(userType ?? 'Patient');
          print('DEBUG: Saved patient ID: ${registerResponse.id}, Name: $fullName, Type: ${userType ?? 'Patient'}');
        } else {
          print('ERROR: No ID in registration response: $response');
          throw Exception('Registration response missing ID');
        }
        return registerResponse;
      }
      throw Exception('No registration data returned');
    } catch (e) {
      if (e.toString().contains('Status 405')) {
        print('ERROR: Method Not Allowed (405). Endpoint may not support POST. Response: $e');
        throw Exception('Registration failed: Server does not allow POST requests. Please check API configuration.');
      }
      print('Registration Error: $e');
      throw Exception('Failed to register: $e');
    }
  }
}