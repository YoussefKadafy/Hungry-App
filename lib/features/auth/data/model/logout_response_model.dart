class LogoutResponseModel {
  int? code;
  String? message;
  dynamic data;

  LogoutResponseModel({this.code, this.message, this.data});

  factory LogoutResponseModel.fromJson(Map<String, dynamic> json) {
    return LogoutResponseModel(
      code: json['code'] as int?,
      message: json['message'] as String?,
      data: json['data'] as dynamic,
    );
  }

  Map<String, dynamic> toJson() => {
    'code': code,
    'message': message,
    'data': data,
  };
}
