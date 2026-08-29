class ApiResponseModel {
  final int statusCode;
  final String message;
  final dynamic body;

  ApiResponseModel({
    required this.statusCode,
    required this.message,
    this.body,
  });

  bool get isSuccess => statusCode >= 200 && statusCode < 300;

  factory ApiResponseModel.fromJson(Map<String, dynamic> json, int statusCode) {
    return ApiResponseModel(
      statusCode: statusCode,
      message: json['message'] ?? '',
      body: json['data'] ?? json,
    );
  }
}
