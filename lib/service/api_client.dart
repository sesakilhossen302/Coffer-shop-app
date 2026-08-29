import 'dart:convert';
import 'package:http/http.dart' as http;
import '../global/Model/api_response_model.dart';
import '../helper/shared_prefe/shared_preferences_helper.dart';

class ApiClient {
  final SharedPreferencesHelper sharedPreferencesHelper;
  static const int timeoutInSeconds = 30;

  ApiClient({required this.sharedPreferencesHelper});

  Future<Map<String, String>> _getHeaders() async {
    String? token = await sharedPreferencesHelper.getToken();
    return {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      if (token != null && token.isNotEmpty) 'Authorization': 'Bearer $token',
    };
  }

  Future<ApiResponseModel> get(String uri) async {
    try {
      final headers = await _getHeaders();
      final response = await http
          .get(Uri.parse(uri), headers: headers)
          .timeout(const Duration(seconds: timeoutInSeconds));
      return _handleResponse(response);
    } catch (e) {
      return ApiResponseModel(
        statusCode: 500,
        message: 'Network Error: ${e.toString()}',
      );
    }
  }

  Future<ApiResponseModel> post(String uri, dynamic body) async {
    try {
      final headers = await _getHeaders();
      final response = await http
          .post(Uri.parse(uri), headers: headers, body: jsonEncode(body))
          .timeout(const Duration(seconds: timeoutInSeconds));
      return _handleResponse(response);
    } catch (e) {
      return ApiResponseModel(
        statusCode: 500,
        message: 'Network Error: ${e.toString()}',
      );
    }
  }

  Future<ApiResponseModel> put(String uri, dynamic body) async {
    try {
      final headers = await _getHeaders();
      final response = await http
          .put(Uri.parse(uri), headers: headers, body: jsonEncode(body))
          .timeout(const Duration(seconds: timeoutInSeconds));
      return _handleResponse(response);
    } catch (e) {
      return ApiResponseModel(
        statusCode: 500,
        message: 'Network Error: ${e.toString()}',
      );
    }
  }

  Future<ApiResponseModel> delete(String uri) async {
    try {
      final headers = await _getHeaders();
      final response = await http
          .delete(Uri.parse(uri), headers: headers)
          .timeout(const Duration(seconds: timeoutInSeconds));
      return _handleResponse(response);
    } catch (e) {
      return ApiResponseModel(
        statusCode: 500,
        message: 'Network Error: ${e.toString()}',
      );
    }
  }

  ApiResponseModel _handleResponse(http.Response response) {
    dynamic jsonResponse;
    try {
      jsonResponse = jsonDecode(response.body);
    } catch (_) {
      jsonResponse = {'message': response.body};
    }

    if (jsonResponse is Map<String, dynamic>) {
      return ApiResponseModel.fromJson(jsonResponse, response.statusCode);
    } else {
      return ApiResponseModel(
        statusCode: response.statusCode,
        message: 'Response format error',
        body: jsonResponse,
      );
    }
  }
}
