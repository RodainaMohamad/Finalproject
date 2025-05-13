class AddPatientModel {
  int? id;
  String? ssn;
  String? name;
  String? birthDate;
  String? gender;
  String? phoneNumber;
  String? email;
  String? profileImage; // Added for consistency with Patient
  String? status; // Added for consistency with Patient
  int? reportId; // Added for consistency with Patient

  AddPatientModel({
    this.id,
    this.ssn,
    this.name,
    this.birthDate,
    this.gender,
    this.phoneNumber,
    this.email,
    this.profileImage,
    this.status,
    this.reportId,
  });

  AddPatientModel.fromJson(Map<String, dynamic> json) {
    id = json['id'] != null ? int.tryParse(json['id'].toString()) : null;
    ssn = json['ssn']?.toString();
    name = json['name']?.toString();
    birthDate = json['birthDate']?.toString();
    gender = json['gender']?.toString();
    phoneNumber = json['phoneNumber']?.toString();
    email = json['email']?.toString();
    profileImage = json['profileImage']?.toString();
    status = json['status']?.toString();
    reportId = json['reportId'] != null ? int.tryParse(json['reportId'].toString()) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = <String, dynamic>{};
    if (id != null) map['id'] = id;
    if (name != null) map['name'] = name;
    if (ssn != null) map['ssn'] = ssn;
    if (birthDate != null) map['birthDate'] = birthDate;
    if (gender != null) map['gender'] = gender;
    if (phoneNumber != null) map['phoneNumber'] = phoneNumber;
    if (email != null) map['email'] = email;
    if (profileImage != null) map['profileImage'] = profileImage;
    if (status != null) map['status'] = status;
    if (reportId != null) map['reportId'] = reportId;
    return map;
  }
}