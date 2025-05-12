class AddPatientModel {
  String? ssn;
  String? name;
  String? birthDate;
  String? gender;
  String? phoneNumber;
  String? email;

  AddPatientModel({
      this.ssn, 
      this.name, 
      this.birthDate, 
      this.gender, 
      this.phoneNumber, 
      this.email,});

  AddPatientModel.fromJson(dynamic json) {
    ssn = json['ssn'];
    name = json['name'];
    birthDate = json['birthDate'];
    gender = json['gender'];
    phoneNumber = json['phoneNumber'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = <String, dynamic>{};
    if(name!=null)map['name']=name;
    if(ssn!=null)map['ssn']=ssn;
    if(birthDate!=null)map['birthDate']=birthDate;
    if(gender!=null)map['gender']=gender;
    if(phoneNumber!=null)map['phoneNumber']=phoneNumber;
    if(email!=null)map['email']=email;
    return map;
  }
}