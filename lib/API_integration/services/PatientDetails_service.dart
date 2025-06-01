import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:grad_project/API_integration/models/PatientDetailsModel.dart';
import 'package:grad_project/API_integration/utility.dart';

class PatientDetailsService {
  final String baseUrl = "http://nabdapi.runasp.net/api/patient/details";

  Future<PatientDetailsModel> getPatientDetails() async {
    try {
      final token = await AuthUtils.getToken();
      if (token == null) {
        throw Exception('No access token found. Please log in.');
      }

      final response = await http.get(
        Uri.parse(baseUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      print('Patient Details API Response: Status=${response.statusCode}, Body=${response.body}');

      if (response.statusCode == 200) {
        if (response.body.isEmpty) {
          throw Exception('Empty response body.');
        }
        final data = jsonDecode(response.body);
        return PatientDetailsModel.fromJson(data);
      } else if (response.statusCode == 401) {
        throw Exception('Unauthorized: Invalid or expired token.');
      } else if (response.statusCode == 404) {
        throw Exception('No patient details found.');
      } else {
        throw Exception('Failed to fetch patient details: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      print('PatientDetailsService Error: $e');
      throw Exception('Error fetching patient details: $e');
    }
  }
}