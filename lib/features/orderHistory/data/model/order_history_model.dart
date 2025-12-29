import 'datum.dart';

class OrderHistoryModel {
  int? code;
  String? message;
  List<Datum>? data;

  OrderHistoryModel({this.code, this.message, this.data});

  factory OrderHistoryModel.fromJson(Map<String, dynamic> json) {
    return OrderHistoryModel(
      code: json['code'] as int?,
      message: json['message'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => Datum.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
    'code': code,
    'message': message,
    'data': data?.map((e) => e.toJson()).toList(),
  };
}
