import '../global/Model/api_response_model.dart';
import '../Utils/ToastMessage/toast_message.dart';

class ApiCheck {
  static bool checkApi(ApiResponseModel response) {
    if (response.isSuccess) {
      return true;
    } else {
      if (response.statusCode == 401) {
        ToastMessage.showError('Session expired. Please log in again.');
      } else {
        ToastMessage.showError(
          response.message.isNotEmpty
              ? response.message
              : 'Something went wrong (${response.statusCode})',
        );
      }
      return false;
    }
  }
}
