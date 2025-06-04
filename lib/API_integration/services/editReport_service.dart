import 'dart:convert';
import 'package:grad_project/API_integration/models/editReportModel.dart';
import 'package:http/http.dart' as http;

class EditReportService {
  final String _baseUrl = 'http://nabdapi.runasp.net/api/Report/Update';

  Future<EditReportModel> updateReport({
    required String reportId,
    required String reportDetails,
    required String uploadDate,
    String? medicalStaffId,
  }) async {
    final url = Uri.parse('$_baseUrl/$reportId');
    final headers = {
      'accept': '*/*',
      'Content-Type': 'application/json',
    };
    final body = jsonEncode({
      'uploadDate': uploadDate,
      'reportDetails': reportDetails,
    });

    try {
      final response = await http.put(url, headers: headers, body: body);

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        return EditReportModel.fromJson(jsonResponse);
      } else {
        throw Exception('Failed to update report: ${response.statusCode} ${response.reasonPhrase}');
      }
    } catch (e) {
      throw Exception('Error updating report: $e');
    }
  }
}