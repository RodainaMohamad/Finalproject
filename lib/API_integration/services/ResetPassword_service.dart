import 'package:grad_project/API_integration/api.dart';
import 'package:grad_project/API_integration/models/ResetPasswordModel.dart';

class ResetPasswordService {
  final Api _api = Api();

  final String _resetPasswordUrl = 'http://nabdapi.runasp.net/resetPassword';
  final String _forgotPasswordUrl = 'http://nabdapi.runasp.net/forgotPassword';
  final String _resendConfirmationEmailUrl = 'http://nabdapi.runasp.net/resendConfirmationEmail';

  Future<bool> resetPassword(ResetPasswordModel model) async {
    try {
      final body = model.toJson()..removeWhere((key, value) => value == null);
      final response = await _api.post(
        url: _resetPasswordUrl,
        body: body,
      );
      print('Reset password response: Status=${response != null ? "Success" : "Null"}, Body=$response');
      if (response != null) {
        return true;
      } else {
        print('Reset password failed: No response body');
        return false;
      }
    } catch (e) {
      print('Exception in resetPassword: $e');
      rethrow; // Rethrow to capture detailed error in calling code
    }
  }

  Future<bool> forgotPassword(String email) async {
    try {
      final response = await _api.post(
        url: _forgotPasswordUrl,
        body: {'email': email},
      );
      print('Forgot password response: Status=${response != null ? "Success" : "Null"}, Body=$response');
      if (response != null) {
        return true;
      } else {
        print('Forgot password failed: No response body');
        return false;
      }
    } catch (e) {
      print('Exception in forgotPassword: $e');
      rethrow;
    }
  }

  Future<bool> resendConfirmationEmail(String email) async {
    try {
      final response = await _api.post(
        url: _resendConfirmationEmailUrl,
        body: {'email': email},
      );
      print('Resend confirmation email response: Status=${response != null ? "Success" : "Null"}, Body=$response');
      if (response != null) {
        return true;
      } else {
        print('Resend confirmation failed: No response body');
        return false;
      }
    } catch (e) {
      print('Exception in resendConfirmationEmail: $e');
      rethrow;
    }
  }
}