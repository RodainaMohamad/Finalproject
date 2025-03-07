import 'dart:convert';
import 'package:http/http.dart' as http;

class Api{
  Future<dynamic>get({required String url})async{
    http.Response response = await http.get(Uri.parse(url));

    if(response.statusCode==200){
      return jsonDecode(response.body);
    }
    else{
      throw Exception(
        'there is a problem with status code ${response.statusCode} with body ${response.body}'
      );
    }
  }

  Future<Map<String, dynamic>> post({
    required String url,
    required Map<String, dynamic> body,
  }) async {
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(body),
      );
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to load data: ${response.statusCode} with body ${response.body}');
      }
    } catch (e) {
      throw Exception('Failed to connect: $e');
    }
  }
}