class RegisterModel {
  String? fullName;
  String? email;
  String? gender;
  String? dateOfBirth;
  String? nationalId;
  String? phoneNumber;
  String? userType;
  String? specialty;
  String? password;
  String? confirmPassword;

  RegisterModel({
    this.fullName,
    this.email,
    this.gender,
    this.dateOfBirth,
    this.nationalId,
    this.phoneNumber,
    this.userType,
    this.specialty,
    this.password,
    this.confirmPassword,
  });

  RegisterModel.fromJson(Map<String, dynamic> json) {
    fullName = json['fullName'];
    email = json['email'];
    gender = json['gender'];
    dateOfBirth = json['dateOfBirth'];
    nationalId = json['nationalId'];
    phoneNumber = json['phoneNumber'];
    userType = json['userType'];
    specialty = json['specialty'];
    password = json['password'];
    confirmPassword = json['confirmPassword'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (fullName != null) data['fullName'] = fullName;
    if (email != null) data['email'] = email;
    if (gender != null) data['gender'] = gender;
    if (dateOfBirth != null) data['dateOfBirth'] = dateOfBirth;
    if (nationalId != null) data['nationalId'] = nationalId;
    if (phoneNumber != null) data['phoneNumber'] = phoneNumber;
    if (userType != null) data['userType'] = userType;
    if (specialty != null) data['specialty'] = specialty;
    if (password != null) data['password'] = password;
    if (confirmPassword != null) data['confirmPassword'] = confirmPassword;
    return data;
  }
}