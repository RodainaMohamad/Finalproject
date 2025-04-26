class LoginModel{
String? email;
String? password;
String? twoFactorCode;
String? twoFactorRecoveryCode;

LoginModel({
      this.email, 
      this.password, 
      this.twoFactorCode,
      this.twoFactorRecoveryCode
  });

LoginModel.fromJson(dynamic json) {
    email = json['email'];
    password = json['password'];
    twoFactorCode = json['twoFactorCode'];
    twoFactorRecoveryCode = json['twoFactorRecoveryCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> info = <String, dynamic>{};
    if (email != null) info['email'] = email;
    if (password != null) info['password'] = password;
    if (twoFactorCode != null) info['twoFactorCode'] = twoFactorCode;
    if (twoFactorRecoveryCode != null) info['twoFactorRecoveryCode'] = twoFactorRecoveryCode;
    return info;
  }
}