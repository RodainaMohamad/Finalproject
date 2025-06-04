class EditReportModel {
  final String uploadDate;
  final String reportDetails;

  EditReportModel({
    required this.uploadDate,
    required this.reportDetails,
  });

  factory EditReportModel.fromJson(Map<String, dynamic> json) {
    return EditReportModel(
      uploadDate: json['uploadDate'] as String,
      reportDetails: json['reportDetails'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uploadDate': uploadDate,
      'reportDetails': reportDetails,
    };
  }
}