class AddGuardianModel {
String? name;
String? relationship;
String? phoneNumber;
String? email;
//int? ssn;

AddGuardianModel({
      this.name, 
      this.relationship, 
      this.phoneNumber,
      this.email,
      //this.ssn,
  });

  AddGuardianModel.fromJson(dynamic json) {
    name = json['name'];
    relationship = json['relationship'];
    phoneNumber = json['phoneNumber'];
    email = json['email'];
    //ssn = json['ssn'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = <String, dynamic>{};
    if(name!=null)map['name']=name;
    if(relationship!=null)map['relationship']=relationship;
    if(phoneNumber!=null)map['phoneNumber']=phoneNumber;
    if(email!=null)map['email']=email;
   // if(ssn!=null)map['ssn']=ssn;
    return map;
  }
}