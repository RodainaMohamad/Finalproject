class AddReportModel {
  final int? id;
  final String? uploadDate;
  final String? diagnosis;
  final String? medication;
  final int? patientId;
  final int? medicalStaffId;

  AddReportModel({
    this.id,
    this.uploadDate,
    this.diagnosis,
    this.medication,
    this.patientId,
    this.medicalStaffId,
  });

  factory AddReportModel.fromJson(Map<String, dynamic> json) {
    return AddReportModel(
      id: json['id'] as int?,
      uploadDate: json['uploadDate'] as String?,
      diagnosis: json['diagnosis'] as String?,
      medication: json['medication'] as String?,
      patientId: json['patientId'] as int?,
      medicalStaffId: json['medicalStaffId'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = <String, dynamic>{};
    if (id != null) map['id'] = id;
    if (uploadDate != null) map['uploadDate'] = uploadDate;
    if (diagnosis != null) map['diagnosis'] = diagnosis;
    if (medication != null) map['medication'] = medication;
    if (patientId != null) map['patientId'] = patientId;
    if (medicalStaffId != null) map['medicalStaffId'] = medicalStaffId;
    return map;
  }
}