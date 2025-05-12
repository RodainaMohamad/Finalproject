import 'dart:convert';
import 'package:grad_project/API_integration/api.dart';
import 'package:grad_project/API_integration/models/AddStaffModel.dart';

class AddNurseService {
  final Api _api = Api();

  Future<AddStaffModel> addNurse({
    required String name,
    required String ssn,
    required String role,
    required String ward,
    required String token,
  }) async {
    try {
      final nurseModel = AddStaffModel(
        name: name,
        ssn: ssn,
        role: role,
        ward: ward,
      );
      print('Request Body: ${jsonEncode(nurseModel.toJson())}');
      final response = await _api.post(
        url: "http://nabdapi.runasp.net/api/Nurses",
        body: nurseModel.toJson(),
        token: token,
      );
      return AddStaffModel.fromJson(response);
    } catch (e) {
      String errorMessage = "Failed to add nurse: $e";
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