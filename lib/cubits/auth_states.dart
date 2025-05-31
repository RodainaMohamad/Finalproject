class AuthState {
  final String? accessToken;
  final String? refreshToken;
  final String userType;
  final int userId;
  final String userName;

  bool get isLoggedIn => accessToken != null;

  AuthState({
    this.accessToken,
    this.refreshToken,
    this.userType = 'Unknown',
    this.userId = 0,
    this.userName = 'Guest',
  });

  AuthState copyWith({
    String? accessToken,
    String? refreshToken,
    String? userType,
    int? userId,
    String? userName,
  }) {
    return AuthState(
      accessToken: accessToken ?? this.accessToken,
      refreshToken: refreshToken ?? this.refreshToken,
      userType: userType ?? this.userType,
      userId: userId ?? this.userId,
      userName: userName ?? this.userName,
    );
  }
}