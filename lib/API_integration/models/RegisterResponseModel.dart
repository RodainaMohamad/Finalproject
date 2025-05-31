class RegisterResponseModel {
  final int? id;
  final String? message;

  RegisterResponseModel({this.id, this.message});

  factory RegisterResponseModel.fromJson(Map<String, dynamic> json) {
    return RegisterResponseModel(
      id: json['id'] as int?,
      message: json['message'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'message': message,
    };
  }
}