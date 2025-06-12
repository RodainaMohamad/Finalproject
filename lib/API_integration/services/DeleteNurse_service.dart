import 'package:http/http.dart' as http;

class DeleteNurseService {
  final String baseUrl = 'http://nabdapi.runasp.net/api/Nurses';

  Future<bool> deleteNurse(int nurseId) async {
    final url = Uri.parse('$baseUrl/$nurseId');
    final response = await http.delete(url, headers: {'accept': '*/*'});

    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('Failed to delete nurse with ID $nurseId');
    }
  }
}