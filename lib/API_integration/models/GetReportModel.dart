class GetReportModel {
  final int id;
  final String uploadDate;
  final String reportDetails;

  GetReportModel({
    required this.id,
    required this.uploadDate,
    required this.reportDetails,
  });

  factory GetReportModel.fromJson(Map<String, dynamic> json) {
    return GetReportModel(
      id: json['id'],
      uploadDate: json['uploadDate'],
      reportDetails: json['reportDetails'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
    'id': id,
    'uploadDate': uploadDate,
    'reportDetails': reportDetails,
  };
  }
}