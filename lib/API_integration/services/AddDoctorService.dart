import 'dart:convert';
import 'package:grad_project/API_integration/api.dart';
import 'package:grad_project/API_integration/models/AddDoctorModel.dart';

class DoctorService {
  Future<AddDoctorModel> addDoctor({
    String? name,
    String? ssn,
    String? role,
    String? specialization,
  }) async {
    try {
      final doctorModel = AddDoctorModel(
        name: name,
        ssn: ssn,
        role: role,
        specialization: specialization,
      );
      print('Request Body: ${jsonEncode(doctorModel.toJson())}');
      final response = await Api().post(
        url: "http://nabdapi.runasp.net/api/Doctors",
        body: doctorModel.toJson(),
      );
      return AddDoctorModel.fromJson(response);
    } catch (e) {
      // Handle error from Api().post
      String errorMessage = "Failed to add doctor: $e";
      String rawError = e.toString();
      print('Raw API Error Response: $rawError');

      // Parse the exception message to extract the body
      try {
        // Expect message like "Failed to load data: 400 with body {...}"
        final bodyMatch = RegExp(r'with body (.*)$').firstMatch(rawError);
        if (bodyMatch != null) {
          String body = bodyMatch.group(1)!;
          print('Extracted API Error Body: $body');
          try {
            final jsonResponse = jsonDecode(body);
            if (jsonResponse is Map) {
              errorMessage = jsonResponse['message'] ?? errorMessage;
            }
          } catch (jsonError) {
            print('Error parsing body as JSON: $jsonError');
            errorMessage = body; // Use raw body if not JSON
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