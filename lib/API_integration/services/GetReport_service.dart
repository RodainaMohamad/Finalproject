// import 'package:grad_project/API_integration/api.dart';
// import 'package:grad_project/API_integration/models/GetReportModel.dart';
// import 'dart:convert';
//
// class GetReportService {
//   final Api _api = Api();
//
//   Future<List<GetReportModel>> getReports(int patientId, {String? token}) async {
//     try {
//       // Assuming _api.get returns the raw JSON string.
//       // If _api.get already decodes JSON, adjust this part.
//       final dynamic responseBody = await _api.get(
//         url: 'http://nabdapi.runasp.net/api/Patient/$patientId/Reports',
//         // headers: {'Authorization': 'Bearer $token'} // Add token if _api.get supports it
//       );
//       print('GET Reports Request: URL=http://nabdapi.runasp.net/api/Patient/$patientId/Reports, Token=$token');
//       print('GET Reports Raw Response Body: $responseBody'); // Print raw body for debugging
//
//       dynamic decodedResponse;
//       // Check if responseBody is a String and needs decoding
//       if (responseBody is String) {
//         decodedResponse = jsonDecode(responseBody);
//       } else if (responseBody is Map<String, dynamic> || responseBody is List<dynamic>) {
//         // If _api.get already returns a decoded Map or List
//         decodedResponse = responseBody;
//       } else {
//         throw Exception('Unexpected response type from _api.get: ${responseBody.runtimeType}');
//       }
//
//       // Check if it has the "$values" key, which indicates the ASP.NET Core JSON serializer's default output for collections
//       if (decodedResponse is Map<String, dynamic> && decodedResponse.containsKey('\$values')) { // Corrected: '$values' is a string literal
//         final List<dynamic> reportsJsonList = decodedResponse['\$values']; // Corrected: '$values' is a string literal
//         print('GET Reports Parsed Reports List: $reportsJsonList'); // Debugging the list
//         return reportsJsonList.map((item) => GetReportModel.fromJson(item)).toList();
//       } else if (decodedResponse is List) { // Fallback if API sometimes returns a direct list
//         return decodedResponse.map((item) => GetReportModel.fromJson(item)).toList();
//       } else {
//         throw Exception('Unexpected data format: Expected a map with "\$values" or a direct list, got ${decodedResponse.runtimeType}');
//       }
//     } catch (e) {
//       print('Error fetching reports for patientId $patientId: $e');
//       throw Exception('Error fetching reports: $e');
//     }
//   }
// }
import 'package:grad_project/API_integration/api.dart';
import 'package:grad_project/API_integration/models/GetReportModel.dart';
import 'package:grad_project/API_integration/utility.dart';

class GetReportService {
  final Api _api = Api();

  Future<List<GetReportModel>> getReports(int patientId) async {
    try {
      final String? token = await AuthUtils.getToken();
      if (token == null) {
        throw Exception('No authentication token found. Please log in.');
      }

      final response = await _api.get(
        url: 'http://nabdapi.runasp.net/api/Patient/$patientId/Reports',
      );
      print('GET Reports Request: URL=http://nabdapi.runasp.net/api/Patient/$patientId/Reports');
      print('GET Reports Response: Body=$response');
      if (response is List) {
        return response.map((item) => GetReportModel.fromJson(item)).toList();
      } else {
        throw Exception('Unexpected data format: Expected a list of reports, got ${response.runtimeType}');
      }
    } catch (e) {
      print('Error fetching reports for patientId $patientId: $e');
      throw Exception('Error fetching reports: $e');
    }
  }
}