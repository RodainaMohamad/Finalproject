import 'AddPatientModel.dart';

class Patient {
  final int? id;
  final String? name;
  final String? ssn;
  final String? profileImage;
  final String? status;
  final String? reportId;
  final String? reportDetails;
  final DateTime? reportDate;

  Patient({
    this.id,
    this.name,
    this.ssn,
    this.profileImage,
    this.status,
    this.reportId,
    this.reportDetails,
    this.reportDate,
  });

  factory Patient.fromAddPatientModel(dynamic model, int index) {
    if (model is AddPatientModel) {
      return Patient(
        id: model.id ?? index + 1,
        name: model.name,
        ssn: model.ssn,
        profileImage: model.profileImage ?? '',
        status: model.status,
        reportId: model.reportId?.toString(), // Convert int? to String?
      );
    } else if (model is Map<String, dynamic>) {
      return Patient(
        id: model['id'] != null ? int.tryParse(model['id'].toString()) : index + 1,
        name: model['name']?.toString(),
        ssn: model['ssn']?.toString(),
        profileImage: model['profileImage']?.toString() ?? '',
        status: model['status']?.toString(),
        reportId: model['reportId']?.toString(), // Ensure String? type
      );
    } else {
      throw Exception('Unsupported model type: ${model.runtimeType}');
    }
  }
}