import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:grad_project/API_integration/models/AddReportModel.dart';

class AddReportService {
  static const String baseUrl = 'http://nabdapi.runasp.net/api/Report';

  Future<AddReportModel> addReport({
    required String reportDetails,
    required int patientId,
    required String uploadDate,
    int? medicalStaffId,
    required String token,
  }) async {
    try {
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(AddReportModel(
          uploadDate: uploadDate,
          reportDetails: reportDetails,
          patientId: patientId,
          medicalStaffId: medicalStaffId,
        ).toJson()),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return AddReportModel.fromJson(jsonDecode(response.body));
      } else {
        throw Exception(
            'Failed to add report: ${response.statusCode} ${response.reasonPhrase}');
      }
    } catch (e) {
      throw Exception('Error adding report: $e');
    }
  }
}