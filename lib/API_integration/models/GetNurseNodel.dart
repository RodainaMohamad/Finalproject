class Nurse {
  final int id;
  final String name;
  final String ssn;
  final String role;
  final String ward;

  Nurse({
    required this.id,
    required this.name,
    required this.ssn,
    required this.role,
    required this.ward,
  });

  factory Nurse.fromJson(Map<String, dynamic> json) {
    return Nurse(
      id: json['id'],
      name: json['name'],
      ssn: json['ssn'],
      role: json['role'],
      ward: json['ward'],
    );
  }
}

class NurseResponse {
  final List<Nurse> nurses;

  NurseResponse({required this.nurses});

  factory NurseResponse.fromJson(Map<String, dynamic> json) {
    final List<dynamic> values = json['\$values'] ?? [];
    return NurseResponse(
      nurses: values.map((e) => Nurse.fromJson(e)).toList(),
    );
  }
}
