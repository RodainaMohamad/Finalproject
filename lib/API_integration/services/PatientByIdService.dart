import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:grad_project/API_integration/models/PatientByIdModel.dart';
import 'package:grad_project/API_integration/utility.dart';

class PatientByIdService {
  Future<PatientByIdModel> getPatientById(int id) async {
    try {
      final token = await AuthUtils.getToken();
      if (token == null) {
        throw Exception('No authentication token found. Please log in.');
      }

      final response = await http.get(
        Uri.parse('http://nabdapi.runasp.net/api/Patient/ById/$id'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      print('GET Patient By ID Response: Status=${response.statusCode}, Body=${response.body}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final patient = PatientByIdModel.fromJson(data);
        await AuthUtils.savePatientId(patient.id!);
        return patient;
      } else if (response.statusCode == 401) {
        throw Exception('Unauthorized: Invalid or expired token.');
      } else if (response.statusCode == 404) {
        throw Exception('Patient not found with ID: $id');
      } else {
        throw Exception('Failed to fetch patient details: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      print('Error fetching patient by ID $id: $e');
      throw Exception('Error fetching patient details: $e');
    }
  }
}