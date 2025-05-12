class AddStaffModel {
  String? name;
  String? ssn;
  String? role;
  String? ward;

  AddStaffModel({
      this.name, 
      this.ssn, 
      this.role, 
      this.ward,
  });

  AddStaffModel.fromJson(dynamic json) {
    name = json['name'];
    ssn = json['ssn'];
    role = json['role'];
    ward = json['ward'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = <String, dynamic>{};
    if(name!=null)map['name']=name;
    if(ssn!=null)map['ssn']=ssn;
    if(role!=null)map['role']=role;
    if(ward!=null)map['ward']=ward;
    return map;
  }
}