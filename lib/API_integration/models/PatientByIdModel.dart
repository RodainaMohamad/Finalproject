class Report {
  final int? id;
  final String? uploadDate;
  final String? medication;
  final String? diagnosis;

  Report({
    this.id,
    this.uploadDate,
    this.medication,
    this.diagnosis,
  });

  factory Report.fromJson(Map<String, dynamic> json) {
    return Report(
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

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is Report &&
              runtimeType == other.runtimeType &&
              id == other.id &&
              uploadDate == other.uploadDate &&
              diagnosis == other.diagnosis &&
              medication == other.medication;

  @override
  int get hashCode => id.hashCode ^ uploadDate.hashCode ^ diagnosis.hashCode ^ medication.hashCode;
}

class PatientByIdModel {
  final int? id;
  final String? ssn;
  final String? name;
  final String? birthDate;
  final String? gender;
  final String? phoneNumber;
  final List<dynamic>? guardians;
  final String? medicalHistory;
  List<Report>? reports;
  String? profileImage;
  String? status;

  PatientByIdModel({
    this.id,
    this.ssn,
    this.name,
    this.birthDate,
    this.gender,
    this.phoneNumber,
    this.guardians,
    this.medicalHistory,
    this.reports,
    this.profileImage,
    this.status,
  });

  factory PatientByIdModel.fromJson(Map<String, dynamic> json) {
    return PatientByIdModel(
      id: json['id'] as int?,
      ssn: json['ssn'] as String?,
      name: json['name'] as String?,
      birthDate: json['birthDate'] as String?,
      gender: json['gender'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      guardians: json['guardians']?['\$values'] as List<dynamic>?,
      medicalHistory: json['medicalHistory'] as String?,
      reports: json['reports']?['\$values'] != null
          ? (json['reports']['\$values'] as List)
          .map((report) => Report.fromJson(report))
          .toSet()
          .toList()
          : null,
      profileImage: json['profileImage'] as String?,
      status: json['status'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'ssn': ssn,
      'name': name,
      'birthDate': birthDate,
      'gender': gender,
      'phoneNumber': phoneNumber,
      'guardians': guardians != null ? {'\$values': guardians} : null,
      'medicalHistory': medicalHistory,
      'reports': reports != null
          ? {'\$values': reports!.map((r) => r.toJson()).toList()}
          : null,
      'profileImage': profileImage,
      'status': status,
    };
  }
}