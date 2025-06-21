import 'package:grad_project/API_integration/api.dart';
import 'package:grad_project/API_integration/models/ConfirmEmailModel.dart';

class ConfirmEmailService {
  final Api _api = Api();
  final String _baseUrl = 'http://nabdapi.runasp.net/confirmEmail';

  Future<bool> confirmEmail(ConfirmEmailRequestModel model) async {
    try {
      final uri = Uri.parse(_baseUrl).replace(queryParameters: model.toQueryParams());

      final response = await _api.get(url: uri.toString());

      if (response != null) {
        print('Email confirmation successful: $response');
        return true;
      } else {
        print('Email confirmation failed: No response.');
        return false;
      }
    } catch (e) {
      print('Exception in confirmEmail: $e');
      return false;
    }
  }
}