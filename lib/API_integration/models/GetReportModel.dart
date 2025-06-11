class GetReportModel {
  final int? id;
  final String? uploadDate;
  final String? diagnosis;
  final String? medication;

  GetReportModel({
    this.id,
    this.uploadDate,
    this.diagnosis,
    this.medication,
  });

  factory GetReportModel.fromJson(Map<String, dynamic> json) {
    return GetReportModel(
      id: json['id'] as int?,
      uploadDate: json['uploadDate'] as String?,
      diagnosis: json['diagnosis'] as String?,
      medication: json['medication'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'uploadDate': uploadDate,
      'diagnosis': diagnosis,
      'medication': medication,
    };
  }
}