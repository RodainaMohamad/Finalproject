import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/GetReportModel.dart';
import '../utility.dart';

class GetReportService {
  Future<List<GetReportModel>> getReports(int patientId) async {
    try {
      final token = await AuthUtils.getToken();
      if (token == null) {
        throw Exception('No authentication token found. Please log in.');
      }

      final response = await http.get(
        Uri.parse('http://nabdapi.runasp.net/api/Report/patient/$patientId'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      // Log response
      print('GET Reports Response: Status=${response.statusCode}, Headers=${response.headers}, Body=${response.body.length > 100 ? response.body.substring(0, 100) : response.body}');

      final contentType = response.headers['content-type']?.toLowerCase() ?? '';
      if (response.statusCode == 200) {
        if (contentType.contains('application/json')) {
          final data = jsonDecode(response.body);
          final reports = (data['\$values'] as List)
              .map((report) => GetReportModel.fromJson(report))
              .toList();
          return reports;
        } else {
          throw Exception('Unexpected content-type: $contentType. Expected JSON.');
        }
      } else if (response.statusCode == 401) {
        throw Exception('Authentication failed: Invalid or expired token.');
      } else if (response.statusCode == 404) {
        return [];
      } else {
        throw Exception('Failed to fetch reports: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      print('Error fetching reports for patientId $patientId: $e');
      rethrow;
    }
  }
}