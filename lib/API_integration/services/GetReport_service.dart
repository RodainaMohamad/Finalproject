import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:grad_project/API_integration/models/GetReportModel.dart';
import 'package:grad_project/API_integration/utility.dart';

class GetReportService {
  Future<List<GetReportModel>> getReports(int patientId) async {
    try {
      final token = await AuthUtils.getToken();
      if (token == null) {
        throw Exception('No authentication token found. Please log in.');
      }

      final response = await http.get(
        Uri.parse('http://nabdapi.runasp.net/api/Patient/$patientId/Reports'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      print('GET Reports Request: URL=http://nabdapi.runasp.net/api/Patient/$patientId/Reports');
      print('GET Reports Response: Status=${response.statusCode}, Body=${response.body}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data is Map<String, dynamic> && data.containsKey('\$values')) {
          final List<dynamic> reportsJsonList = data['\$values'];
          return reportsJsonList.map((item) => GetReportModel.fromJson(item)).toList();
        } else {
          throw Exception('Unexpected data format: Expected a map with "\$values"');
        }
      } else if (response.statusCode == 401) {
        throw Exception('Unauthorized: Invalid or expired token.');
      } else if (response.statusCode == 404) {
        throw Exception('No reports found for patient ID: $patientId');
      } else {
        throw Exception('Failed to fetch reports: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      print('Error fetching reports for patientId $patientId: $e');
      throw Exception('Error fetching reports: $e');
    }
  }
}