import 'item.dart';

class Data {
  int? id;
  String? totalPrice;
  List<Item>? items;

  Data({this.id, this.totalPrice, this.items});

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json['id'] as int?,
    totalPrice: json['total_price'] as String?,
    items: (json['items'] as List<dynamic>?)
        ?.map((e) => Item.fromJson(e as Map<String, dynamic>))
        .toList(),
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'total_price': totalPrice,
    'items': items?.map((e) => e.toJson()).toList(),
  };
}
