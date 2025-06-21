class ResetPasswordModel {
String? email;
String? resetCode;
String? newPassword;

ResetPasswordModel({
      this.email, 
      this.resetCode, 
      this.newPassword});

  ResetPasswordModel.fromJson(dynamic json) {
    email = json['email'];
    resetCode = json['resetCode'];
    newPassword = json['newPassword'];
  }

  Map<String, dynamic> toJson() {

    final Map<String, dynamic> data = <String, dynamic>{};
    if (email != null) data['email'] = email;
    if (resetCode != null) data['resetCode'] = resetCode;
    if (newPassword != null) data['newPassword'] = newPassword;
    return data;
  }
}