class Datum {
  int? id;
  String? status;
  String? totalPrice;
  String? createdAt;
  String? productImage;

  Datum({
    this.id,
    this.status,
    this.totalPrice,
    this.createdAt,
    this.productImage,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json['id'] as int?,
    status: json['status'] as String?,
    totalPrice: json['total_price'] as String?,
    createdAt: json['created_at'] as String?,
    productImage: json['product_image'] as String?,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'status': status,
    'total_price': totalPrice,
    'created_at': createdAt,
    'product_image': productImage,
  };
}
