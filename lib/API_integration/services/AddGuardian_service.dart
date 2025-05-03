import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:grad_project/API_integration/api.dart';
import 'package:grad_project/API_integration/models/AddGuardianModel.dart';

class AddGuardianService {
  final _storage = FlutterSecureStorage();

  Future<AddGuardianModel> addGuardian({
    required String name,
    required String relationship,
    required String phoneNumber,
    required String email,
    //required int? ssn,
    required String token,
  }) async {
    try {
      // Validate inputs first
      if (!_isValidEmail(email)) {
        throw Exception("Invalid email format");
      }

      if (!_isValidPhone(phoneNumber)) {
        throw Exception("Phone number must be 10+ digits");
      }

      // Create the request body
      final addGuardian = AddGuardianModel(
        name: name,
        relationship: relationship,
        phoneNumber: phoneNumber,
        email: email,
        //ssn:ssn,
      );

      print('Request Body: ${jsonEncode(addGuardian.toJson())}');

      final response = await Api().post(
        url: "http://nabdapi.runasp.net/api/Guardians",
        body: addGuardian.toJson(),
        token: token, // Use the passed token
      );

      return AddGuardianModel.fromJson(response);
    } catch (e) {
      String errorMessage = "Failed to add guardian: ${e.toString()}";
      print('Error: $errorMessage');

      // Handle API error responses
      try {
        final errorStr = e.toString();
        final bodyMatch = RegExp(r'with body (.*)$').firstMatch(errorStr);
        if (bodyMatch != null) {
          errorMessage = bodyMatch.group(1)!;
          try {
            final jsonResponse = jsonDecode(errorMessage);
            if (jsonResponse is Map) {
              errorMessage = jsonResponse['message'] ?? errorMessage;
            }
          } catch (_) {}
        }
      } catch (_) {}

      throw Exception(errorMessage);
    }
  }

  bool _isValidEmail(String email) {
    return RegExp(r'^[a-zA-Z0-9]+([._-][a-zA-Z0-9]+)*@[a-zA-Z0-9]+([.-][a-zA-Z0-9]+)*\.[a-zA-Z]{2,}$').hasMatch(email);
  }

  bool _isValidPhone(String phone) {
    return RegExp(r'^[0-9]{10,}$').hasMatch(phone);
  }
}