import 'package:flutter/material.dart';
import 'package:grad_project/API_integration/utility.dart';
import 'package:grad_project/core/widgets/addreport.dart';

Future<void> navigateToAddReport(BuildContext context) async {
  final savedPatientId = await AuthUtils.getPatientId();

  if (savedPatientId != null) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddReport(patientId: int.parse(savedPatientId)),
      ),
    );
  } else {
    // Handle missing patient ID (show error, logout, etc.)
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Patient ID not found. Please log in again.')),
    );
  }
}
