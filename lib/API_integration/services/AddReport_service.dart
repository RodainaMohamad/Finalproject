// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:grad_project/API_integration/models/AddReportModel.dart';
//
// class AddReportService {
//   static const String baseUrl = 'http://nabdapi.runasp.net/api/Report';
//
//   Future<AddReportModel> addReport({
//     required String reportDetails,
//     required int patientId,
//     required String uploadDate,
//     int? medicalStaffId,
//     required String token,
//   }) async {
//     try {
//       final reportModel = AddReportModel(
//         uploadDate: uploadDate,
//         reportDetails: reportDetails,
//         patientId: patientId,
//         medicalStaffId: medicalStaffId,
//       );
//       print('POST Report Request: URL=$baseUrl, patientId=$patientId, Body=${jsonEncode(reportModel.toJson())}');
//       final response = await http.post(
//         Uri.parse(baseUrl),
//         headers: {
//           'Content-Type': 'application/json',
//           'Authorization': 'Bearer $token',
//         },
//         body: jsonEncode(reportModel.toJson()),
//       );
//       print('POST Report Response: Status=${response.statusCode}, Body=${response.body}');
//
//       if (response.statusCode == 200 || response.statusCode == 201) {
//         return AddReportModel.fromJson(jsonDecode(response.body));
//       } else {
//         throw Exception('Failed to add report: ${response.statusCode} ${response.reasonPhrase}');
//       }
//     } catch (e) {
//       print('Error adding report for patientId $patientId: $e');
//       throw Exception('Error adding report: $e');
//     }
//   }
// }
import 'dart:convert';
import 'package:grad_project/API_integration/utility.dart';
import 'package:http/http.dart' as http;
import 'package:grad_project/API_integration/models/AddReportModel.dart';

class AddReportService {
  static const String baseUrl = 'http://nabdapi.runasp.net/api/Report';

  Future<AddReportModel> addReport({
    required String reportDetails,
    required int patientId,
    required String uploadDate,
    int? medicalStaffId,
  }) async {
    try {
      final String? token = await AuthUtils.getToken();
      if (token == null) {
        throw Exception('No authentication token found. Please log in.');
      }

      final reportModel = AddReportModel(
        uploadDate: uploadDate,
        reportDetails: reportDetails,
        patientId: patientId,
        medicalStaffId: medicalStaffId,
      );
      print('POST Report Request: URL=$baseUrl, patientId=$patientId, Body=${jsonEncode(reportModel.toJson())}');
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(reportModel.toJson()),
      );
      print('POST Report Response: Status=${response.statusCode}, Body=${response.body}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        return AddReportModel.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to add report: ${response.statusCode} ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Error adding report for patientId $patientId: $e');
      throw Exception('Error adding report: $e');
    }
  }
}