// In services/patient_details_service.dart
import 'package:grad_project/API_integration/api.dart';
import 'package:grad_project/API_integration/models/PatientDetailsModel.dart';
import 'package:grad_project/API_integration/utility.dart';


class PatientDetailsService {
  final Api _api = Api();

  Future<PatientDetailsModel> getPatientDetails(int patientId) async {
    try {
      final token = await AuthUtils.getToken();
      final response = await _api.get(
        url: "http://nabdapi.runasp.net/api/Patient/$patientId/Reports",

      );

      print('Patient Reports Response: $response');

      if (response != null) {
        return PatientDetailsModel.fromJson(response);
      } else {
        throw Exception('No reports returned');
      }
    } catch (e) {
      print('Error fetching patient reports: $e');
      throw Exception('Failed to fetch patient reports: $e');
    }
  }
}