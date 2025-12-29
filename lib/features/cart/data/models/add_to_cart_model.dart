class CartRequestModel {
  final List<CartItemModel> items;

  CartRequestModel({required this.items});

  Map<String, dynamic> toJson() {
    return {"items": items.map((item) => item.toJson()).toList()};
  }
}

class CartItemModel {
  final int productId;
  final int quantity;
  final double? spicy;
  final List<int> toppings;
  final List<int> sideOptions;

  CartItemModel({
    required this.productId,
    required this.quantity,
    this.spicy,
    required this.toppings,
    required this.sideOptions,
  });

  Map<String, dynamic> toJson() {
    return {
      "product_id": productId,
      "quantity": quantity,
      if (spicy != null) "spicy": spicy,
      "toppings": toppings,
      "side_options": sideOptions,
    };
  }
}

class AddToCartResponseModel {
  final int code;
  final String message;

  AddToCartResponseModel({required this.code, required this.message});

  factory AddToCartResponseModel.fromJson(Map<String, dynamic> json) {
    return AddToCartResponseModel(
      code: json['code'] as int,
      message: json['message'] as String,
    );
  }
}
