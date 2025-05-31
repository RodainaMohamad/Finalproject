import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_project/cubits/auth_states.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthState());

  void updateAuthData(Map<String, dynamic> authData) {
    emit(state.copyWith(
      accessToken: authData['accessToken'],
      refreshToken: authData['refreshToken'],
    ));
  }

  void logout() {
    emit(AuthState()); // reset to default state
  }
}