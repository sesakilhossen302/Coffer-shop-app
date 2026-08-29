import '../../global/Model/api_response_model.dart';
import '../../Utils/StaticString/static_string.dart';

class GeneralError {
  static String parseError(ApiResponseModel response) {
    if (response.message.isNotEmpty) {
      return response.message;
    }
    switch (response.statusCode) {
      case 400:
        return 'Bad Request';
      case 401:
        return 'Unauthorized access';
      case 403:
        return 'Forbidden';
      case 404:
        return 'Resource not found';
      case 500:
        return 'Internal Server Error';
      default:
        return StaticString.somethingWentWrong;
    }
  }
}
