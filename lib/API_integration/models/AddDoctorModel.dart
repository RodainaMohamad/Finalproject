class AddDoctorModel {
String? name;
String? ssn;
String? role;
String? specialization;

AddDoctorModel({
      this.name, 
      this.ssn, 
      this.role, 
      this.specialization
});

  AddDoctorModel.fromJson(dynamic json) {
    name = json['name'];
    ssn = json['ssn'];
    role = json['role'];
    specialization = json['specialization'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> addDocInfo = <String, dynamic>{};
    if(name!=null)addDocInfo['name']=name;
    if(ssn!=null)addDocInfo['ssn']=ssn;
    if(role!=null)addDocInfo['role']=role;
    if(specialization!=null)addDocInfo['specialization']=specialization;
    return addDocInfo;
  }
}