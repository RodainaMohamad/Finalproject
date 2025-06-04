import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/PatientByIdModel.dart';

class PatientIdDetailsService {
  final String _baseUrl = 'http://nabdapi.runasp.net/api/Patient';

  Future<PatientByIdModel> getPatientById(int id) async {
    final url = Uri.parse('$_baseUrl/$id/details');
    final headers = {'accept': '*/*'};

    try {
      final response = await http.get(url, headers: headers);
      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        print('Patient $id API response: ${jsonResponse['reports']?['\$values'] ?? 'No reports'}');
        return PatientByIdModel.fromJson(jsonResponse);
      } else {
        throw Exception('Failed to load patient details: ${response.statusCode} ${response.reasonPhrase}');
      }
    } catch (e) {
      throw Exception('Error fetching patient details: $e');
    }
  }
}