import 'package:hungry/features/cart/data/models/cart_model/side_option.dart';
import 'package:hungry/features/cart/data/models/cart_model/topping.dart';

class Item {
  int? itemId;
  int? productId;
  String? name;
  String? image;
  int? quantity;
  String? price;
  double? spicy;
  List<Topping>? toppings;
  List<SideOption>? sideOptions;

  Item({
    this.itemId,
    this.productId,
    this.name,
    this.image,
    this.quantity,
    this.price,
    this.spicy,
    this.toppings,
    this.sideOptions,
  });

  factory Item.fromJson(Map<String, dynamic> json) => Item(
    itemId: json['item_id'],
    productId: json['product_id'],
    name: json['name'],
    image: json['image'],
    quantity: json['quantity'],
    price: json['price']?.toString(),
    spicy: double.tryParse(json['spicy'].toString()),
    toppings: (json['toppings'] as List<dynamic>?)
        ?.map((e) => Topping.fromJson(e))
        .toList(),
    sideOptions: (json['side_options'] as List<dynamic>?)
        ?.map((e) => SideOption.fromJson(e))
        .toList(),
  );
  Map<String, dynamic> toJson() => {
    'item_id': itemId,
    'product_id': productId,
    'name': name,
    'image': image,
    'quantity': quantity,
    'price': price,
    'spicy': spicy,
    'toppings': toppings?.map((e) => e.toJson()).toList(),
    'side_options': sideOptions?.map((e) => e.toJson()).toList(),
  };
}
