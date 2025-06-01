import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:grad_project/API_integration/utility.dart';

class PatientByNameService {
  Future<int> getPatientIdByName(String name) async {
    try {
      final token = await AuthUtils.getToken();
      if (token == null) {
        throw Exception('No authentication token found. Please log in.');
      }

      final response = await http.get(
        Uri.parse('http://nabdapi.runasp.net/api/Patient/ByName/$name'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      print('GET Patient By Name Response: Status=${response.statusCode}, Body=${response.body}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['id'] != null) {
          final patientId = data['id'] as int;
          await AuthUtils.savePatientId(patientId);
          return patientId;
        }
        throw Exception('Patient ID not found in response');
      }
      throw Exception('Failed to fetch patient ID: ${response.statusCode} - ${response.body}');
    } catch (e) {
      print('Error fetching patient ID for name $name: $e');
      throw Exception('Error fetching patient ID: $e');
    }
  }
}