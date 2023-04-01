class ResultErrorModel {
  final String? errorCode;
  final String? message;
  final List<String>? params;

  ResultErrorModel({
    this.errorCode,
    this.message,
    this.params,
  });

  factory ResultErrorModel.fromJson(Map<String, dynamic> json) {
    return ResultErrorModel(
      errorCode: json['errorCode'] as String?,
      message: json['message'] as String?,
      params: json['params'] as List<String>?,
    );
  }
}
