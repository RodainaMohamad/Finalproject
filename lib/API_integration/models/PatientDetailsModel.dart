class PatientDetailsModel {
  List<Report>? reports;

  PatientDetailsModel({this.reports});

  factory PatientDetailsModel.fromJson(Map<String, dynamic> json) {
    const String valuesKey = r'$values';
    return PatientDetailsModel(
      reports: json[valuesKey] != null
          ? (json[valuesKey] as List)
          .map((e) => Report.fromJson(e))
          .toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    const String valuesKey = r'$values';
    return {
      valuesKey: reports?.map((e) => e.toJson()).toList(),
    };
  }
}

class Report {
  int? id;
  String? uploadDate;
  String? reportDetails;

  Report({this.id, this.uploadDate, this.reportDetails});

  factory Report.fromJson(Map<String, dynamic> json) {
    return Report(
      id: json['id'],
      uploadDate: json['uploadDate'],
      reportDetails: json['reportDetails'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (id != null) data['id'] = id;
    if (uploadDate != null) data['uploadDate'] = uploadDate;
    if (reportDetails != null) data['reportDetails'] = reportDetails;
    return data;
  }
}