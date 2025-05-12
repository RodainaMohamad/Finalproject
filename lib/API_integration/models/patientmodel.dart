import 'package:grad_project/API_integration/models/AddPatientModel.dart';

class Patient {
  final String? ssn;
  final String? name;
  final String lastUpdate;
  final String profileImage;
  final String status;

  Patient({
    required this.ssn,
    required this.name,
    required this.lastUpdate,
    required this.profileImage,
    required this.status,
  });

  factory Patient.fromAddPatientModel(AddPatientModel model, int index) {
    return Patient(
      ssn: model.ssn,
      name: model.name,
      lastUpdate: '${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}',
      profileImage: 'https://via.placeholder.com/40',
      status: _getRandomStatus(index),
    );
  }

  static String _getRandomStatus(int index) {
    final statuses = ['Very Good', 'Good', 'Bad', 'Very Bad'];
    return statuses[index % statuses.length];
  }
}