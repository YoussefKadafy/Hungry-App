import 'data.dart';

class CartModel {
  int? code;
  String? message;
  Data? data;

  CartModel({this.code, this.message, this.data});

  factory CartModel.fromJson(Map<String, dynamic> json) => CartModel(
    code: json['code'] as int?,
    message: json['message'] as String?,
    data: json['data'] == null
        ? null
        : Data.fromJson(json['data'] as Map<String, dynamic>),
  );

  Map<String, dynamic> toJson() => {
    'code': code,
    'message': message,
    'data': data?.toJson(),
  };
}
