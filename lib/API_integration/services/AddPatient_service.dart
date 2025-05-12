// import 'dart:convert';
// import 'package:grad_project/API_integration/api.dart';
// import 'package:grad_project/API_integration/models/AddPatientModel.dart';
//
// class AddPatientService {
//   final Api _api = Api();
//
//   Future<AddPatientModel> addPatient({
//     required String name,
//     required String ssn,
//     required String birthDate,
//     required String gender,
//     required String phoneNumber,
//     required String email,
//     required String token,
//   }) async {
//     try {
//       final patientModel = AddPatientModel(
//         name: name,
//         ssn: ssn,
//         birthDate: birthDate,
//         gender: gender,
//         phoneNumber: phoneNumber,
//         email: email,
//       );
//       print('Request Body: ${jsonEncode(patientModel.toJson())}');
//       final response = await _api.post(
//         url: "http://nabdapi.runasp.net/api/Patient",
//         body: patientModel.toJson(),
//         token: token,
//       );
//       return AddPatientModel.fromJson(response);
//     } catch (e) {
//       String errorMessage = "Failed to add patient: $e";
//       String rawError = e.toString();
//       print('Raw API Error Response: $rawError');
//       try {
//         final bodyMatch = RegExp(r'with body (.*)$').firstMatch(rawError);
//         if (bodyMatch != null) {
//           String body = bodyMatch.group(1)!;
//           print('Extracted API Error Body: $body');
//           if (rawError.contains('401')) {
//             errorMessage = "Unauthorized: Please check your authentication credentials.";
//           } else if (body.trim().isEmpty) {
//             errorMessage = "Server error: No response body returned";
//           } else {
//             try {
//               final jsonResponse = jsonDecode(body);
//               if (jsonResponse is Map) {
//                 errorMessage = jsonResponse['message'] ?? errorMessage;
//               }
//             } catch (jsonError) {
//               print('Error parsing body as JSON: $jsonError');
//               errorMessage = body;
//             }
//           }
//         } else {
//           print('No body found in error message');
//         }
//       } catch (parseError) {
//         print('Error parsing exception message: $parseError');
//       }
//       throw Exception(errorMessage);
//     }
//   }
// }

import 'dart:convert';
import 'package:grad_project/API_integration/api.dart';
import 'package:grad_project/API_integration/models/AddPatientModel.dart';
class AddPatientService {
  final Api _api = Api();

  Future<AddPatientModel> addPatient({
    required String name,
    required String ssn,
    required String birthDate,
    required String gender,
    required String phoneNumber,
    required String email,
    required String token,
  }) async {
    try {
      final patientModel = AddPatientModel(
        name: name,
        ssn: ssn,
        birthDate: birthDate,
        gender: gender,
        phoneNumber: phoneNumber,
        email: email,
      );
      print('Request Body: ${jsonEncode(patientModel.toJson())}');
      final response = await _api.post(
        url: "http://nabdapi.runasp.net/api/Patient",
        body: patientModel.toJson(),
        token: token,
      );
      return AddPatientModel.fromJson(response);
    } catch (e) {
      String errorMessage = "Failed to add patient: $e";
      String rawError = e.toString();
      print('Raw API Error Response: $rawError');
      try {
        final bodyMatch = RegExp(r'with body (.*)$').firstMatch(rawError);
        if (bodyMatch != null) {
          String body = bodyMatch.group(1)!;
          print('Extracted API Error Body: $body');
          if (rawError.contains('401')) {
            errorMessage =
            "Unauthorized: Please check your authentication credentials.";
          } else if (body.trim().isEmpty) {
            errorMessage = "Server error: No response body returned";
          } else {
            try {
              final jsonResponse = jsonDecode(body);
              if (jsonResponse is Map) {
                errorMessage = jsonResponse['message'] ?? errorMessage;
              }
            } catch (jsonError) {
              print('Error parsing body as JSON: $jsonError');
              errorMessage = body;
            }
          }
        } else {
          print('No body found in error message');
        }
      } catch (parseError) {
        print('Error parsing exception message: $parseError');
      }
      throw Exception(errorMessage);
    }
  }

  Future<List<AddPatientModel>> getPatientsByName(String name,
      {String? token}) async {
    try {
      // If name is empty, fetch all patients
      final url = name.isEmpty
          ? "http://nabdapi.runasp.net/api/Patient"
          : "http://nabdapi.runasp.net/api/Patient/ByName/$name";
      final response = await _api.get(
        url: url,
      );

      if (response is List) {
        return response.map((json) => AddPatientModel.fromJson(json)).toList();
      } else if (response is Map<String, dynamic>) {
        return [AddPatientModel.fromJson(response)];
      } else {
        throw Exception('Unexpected response format: $response');
      }
    } catch (e) {
      print('Error in getPatientsByName: $e');
      throw Exception('Failed to fetch patients: $e');
    }
  }
}
// class AddPatientService {
//   final Api _api = Api();
//
//   Future<AddPatientModel> addPatient({
//     required String name,
//     required String ssn,
//     required String birthDate,
//     required String gender,
//     required String phoneNumber,
//     required String email,
//     required String token,
//   }) async {
//     try {
//       final patientModel = AddPatientModel(
//         name: name,
//         ssn: ssn,
//         birthDate: birthDate,
//         gender: gender,
//         phoneNumber: phoneNumber,
//         email: email,
//       );
//       print('Request Body: ${jsonEncode(patientModel.toJson())}');
//       final response = await _api.post(
//         url: "http://nabdapi.runasp.net/api/Patient",
//         body: patientModel.toJson(),
//         token: token,
//       );
//       return AddPatientModel.fromJson(response);
//     } catch (e) {
//       String errorMessage = "Failed to add patient: $e";
//       String rawError = e.toString();
//       print('Raw API Error Response: $rawError');
//       try {
//         final bodyMatch = RegExp(r'with body (.*)$').firstMatch(rawError);
//         if (bodyMatch != null) {
//           String body = bodyMatch.group(1)!;
//           print('Extracted API Error Body: $body');
//           if (rawError.contains('401')) {
//             errorMessage = "Unauthorized: Please check your authentication credentials.";
//           } else if (body.trim().isEmpty) {
//             errorMessage = "Server error: No response body returned";
//           } else {
//             try {
//               final jsonResponse = jsonDecode(body);
//               if (jsonResponse is Map) {
//                 errorMessage = jsonResponse['message'] ?? errorMessage;
//               }
//             } catch (jsonError) {
//               print('Error parsing body as JSON: $jsonError');
//               errorMessage = body;
//             }
//           }
//         } else {
//           print('No body found in error message');
//         }
//       } catch (parseError) {
//         print('Error parsing exception message: $parseError');
//       }
//       throw Exception(errorMessage);
//     }
//   }
//   Future<List<AddPatientModel>> getPatientsByName(String name, {String? token}) async {
//     try {
//       final response = await _api.get(
//         url: "http://nabdapi.runasp.net/api/Patient/ByName/$name",
//       );
//
//       if (response is List) {
//         // If response is a list of patients
//         return response.map((json) => AddPatientModel.fromJson(json)).toList();
//       } else if (response is Map<String, dynamic>) {
//         // If response is a single patient
//         return [AddPatientModel.fromJson(response)];
//       } else {
//         throw Exception('Unexpected response format: $response');
//       }
//     } catch (e) {
//       print('Error in getPatientsByName: $e');
//       throw Exception('Failed to fetch patients: $e');
//     }
//   }
//   // Updated method to fetch patients by name
//   Future<List<AddPatientModel>> getPatientsByID(String name, {String? token}) async {
//     try {
//       final response = await _api.get(
//         url: "http://nabdapi.runasp.net/api/Patient/ById/$id",
//       );
//       if (response is List) {
//         return response.map((json) => AddPatientModel.fromJson(json)).toList();
//       } else if (response is Map<String, dynamic>) {
//         return [AddPatientModel.fromJson(response)]; // Wrap single patient in a list
//       } else {
//         throw Exception('Unexpected response format');
//       }
//     } catch (e) {
//       throw Exception('Failed to fetch patients: $e');
//     }
//   }
// }