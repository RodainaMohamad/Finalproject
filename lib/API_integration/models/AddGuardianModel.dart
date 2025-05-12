class AddGuardianModel {
String? name;
String? relationship;
String? phoneNumber;
String? email;
String? patientSSN;

AddGuardianModel({
      this.name, 
      this.relationship, 
      this.phoneNumber,
      this.email,
      this.patientSSN,
  });

  AddGuardianModel.fromJson(dynamic json) {
    name = json['name'];
    relationship = json['relationship'];
    phoneNumber = json['phoneNumber'];
    email = json['email'];
    patientSSN = json['patientSSN'];
  }
Map<String, dynamic> toJson() {
  return {
    'name': name,
    'relationship': relationship,
    'phoneNumber': phoneNumber,
    'email': email,
    'patientSSN': patientSSN ?? '', // Send empty string instead of null
  };
}
}