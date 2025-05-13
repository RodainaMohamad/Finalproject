import 'AddPatientModel.dart';

class Patient {
  final int? id;
  final String? name;
  final String? ssn;
  final String? profileImage;
  final String? status;
  final int? reportId;

  Patient({
    this.id,
    this.name,
    this.ssn,
    this.profileImage,
    this.status,
    this.reportId,
  });

  factory Patient.fromAddPatientModel(dynamic model, int index) {
    if (model is AddPatientModel) {
      // Handle AddPatientModel by accessing properties directly
      return Patient(
        id: model.id ?? index + 1,
        name: model.name,
        ssn: model.ssn,
        profileImage: model.profileImage ?? '',
        status: model.status,
        reportId: model.reportId,
      );
    } else if (model is Map<String, dynamic>) {
      // Handle Map<String, dynamic> (e.g., from API response)
      return Patient(
        id: model['id'] != null ? int.tryParse(model['id'].toString()) : index + 1,
        name: model['name']?.toString(),
        ssn: model['ssn']?.toString(),
        profileImage: model['profileImage']?.toString() ?? '',
        status: model['status']?.toString(),
        reportId: model['reportId'] != null
            ? int.tryParse(model['reportId'].toString())
            : null,
      );
    } else {
      throw Exception('Unsupported model type: ${model.runtimeType}');
    }
  }
}