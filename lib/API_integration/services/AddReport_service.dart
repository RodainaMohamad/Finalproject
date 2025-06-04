import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/AddReportModel.dart';

class AddReportService {
  Future<AddReportModel> addReport({
    required String reportDetails,
    required String uploadDate,
    required int patientId,
    int? medicalStaffId,
  }) async {
    final url = Uri.parse('http://nabdapi.runasp.net/api/Report');
    final headers = {
      'accept': '*/*',
      'Content-Type': 'application/json',
    };
    final body = jsonEncode({
      'uploadDate': uploadDate,
      'reportDetails': reportDetails,
      'patientId': patientId,
      if (medicalStaffId != null) 'medicalStaffId': medicalStaffId,
    });

    try {
      final response = await http.post(url, headers: headers, body: body);
      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        return AddReportModel.fromJson(jsonResponse);
      } else {
        throw Exception('Failed to add report: ${response.statusCode} ${response.reasonPhrase}');
      }
    } catch (e) {
      throw Exception('Error adding report: $e');
    }
  }
}