import 'dart:convert';
import 'package:grad_project/API_integration/api.dart';
import 'package:grad_project/API_integration/models/PatientByIdModel.dart';


class PatientByIdService {
  final Api _api = Api();

  Future<PatientByIdModel> getPatientById(int id, {String? token}) async {
    try {
      final response = await _api.get(
        url: "http://nabdapi.runasp.net/api/Patient/ById/$id",
      );

      if (response is Map<String, dynamic>) {
        return PatientByIdModel.fromJson(response);
      } else {
        throw Exception('Unexpected response format: $response');
      }
    } catch (e) {
      String errorMessage = "Failed to fetch patient by ID: $e";
      String rawError = e.toString();
      print('Raw API Error Response: $rawError');

      try {
        final bodyMatch = RegExp(r'with body (.*)$').firstMatch(rawError);
        if (bodyMatch != null) {
          String body = bodyMatch.group(1)!;
          print('Extracted API Error Body: $body');
          if (rawError.contains('404')) {
            errorMessage = "Patient not found with ID: $id";
          } else if (rawError.contains('401')) {
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