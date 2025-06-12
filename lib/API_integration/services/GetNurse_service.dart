import 'dart:convert';
import 'package:grad_project/API_integration/models/GetNurseNodel.dart';
import 'package:http/http.dart' as http;

class NurseService {
  final String baseUrl = 'http://nabdapi.runasp.net/api';

  Future<List<Nurse>> fetchNurses() async {
    final response = await http.get(
      Uri.parse('$baseUrl/Nurses'),
      headers: {'accept': 'text/plain'},
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final NurseResponse nurseResponse = NurseResponse.fromJson(data);
      return nurseResponse.nurses;
    } else {
      throw Exception('Failed to load nurses');
    }
  }
  Future<Nurse> fetchNurseById(int id) async {
    final response = await http.get(Uri.parse('$baseUrl/Nurses/$id'));

    if (response.statusCode == 200) {
      return Nurse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Nurse with ID $id not found');
    }
  }
}