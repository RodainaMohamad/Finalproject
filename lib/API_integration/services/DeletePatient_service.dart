import 'package:grad_project/API_integration/Api.dart';

class DeletePatientService {
  final Api _api = Api();

  Future<void> deletePatient(int patientId, {String? token}) async {
    try {
      print('Attempting to delete patient with ID: $patientId');
      final url = 'http://nabdapi.runasp.net/api/Patient/$patientId';
      final response = await _api.delete(url: url, token: token);
      print('Delete Patient API Response: Response=$response');

      // If response is null, deletion was successful
      if (response == null) {
        return;
      } else {
        throw Exception('Unexpected response: $response');
      }
    } catch (e) {
      print('Error deleting patient: $e');
      throw Exception('Failed to delete patient: $e');
    }
  }
}