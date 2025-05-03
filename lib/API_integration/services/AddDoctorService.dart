import 'dart:convert';
import 'package:grad_project/API_integration/api.dart';
import 'package:grad_project/API_integration/models/AddDoctorModel.dart';

class DoctorService {
  final Api _api = Api();

  Future<AddDoctorModel> addDoctor({
    required String name,
    required String ssn,
    required String role,
    required String specialization,
    required String token,
  }) async {
    try {
      final doctorModel = AddDoctorModel(
        name: name,
        ssn: ssn,
        role: role,
        specialization: specialization,
      );
      print('Request Body: ${jsonEncode(doctorModel.toJson())}');
      final response = await _api.post(
        url: "http://nabdapi.runasp.net/api/Doctors",
        body: doctorModel.toJson(),
        token: token,
      );
      return AddDoctorModel.fromJson(response);
    } catch (e) {
      String errorMessage = "Failed to add doctor: $e";
      String rawError = e.toString();
      print('Raw API Error Response: $rawError');

      try {
        final bodyMatch = RegExp(r'with body (.*)$').firstMatch(rawError);
        if (bodyMatch != null) {
          String body = bodyMatch.group(1)!;
          print('Extracted API Error Body: $body');
          if (rawError.contains('401')) {
            errorMessage = "Unauthorized: Please check your authentication credentials.";
          } else if (body.trim().isEmpty) {
            errorMessage = "Server error: No response body returned";
          } else {
            try {
              final jsonResponse = jsonDecode(body);
              if (jsonResponse is Map) {
                errorMessage = jsonResponse['message'] ?? errorMessage;
              }
            } catch (jsonError) {
              print('Error parsing body as JSON: $jsonError');
              errorMessage = body;
            }
          }
        } else {
          print('No body found in error message');
        }
      } catch (parseError) {
        print('Error parsing exception message: $parseError');
      }

      throw Exception(errorMessage);
    }
  }
}