class ConfirmEmailRequestModel {
  final int userId;
  final String code;
  final String changedEmail;

  ConfirmEmailRequestModel({
    required this.userId,
    required this.code,
    required this.changedEmail,
  });

  Map<String, String> toQueryParams() {
    return {
      'userId': userId.toString(),
      'code': code,
      'changedEmail': changedEmail,
    };
  }
}