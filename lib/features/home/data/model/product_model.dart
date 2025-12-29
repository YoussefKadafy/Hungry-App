class ProductModel {
  final int id;
  final String name;
  final String description;
  final String imageUrl;
  final String rating;
  final String price;
  ProductModel({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.rating,
    required this.price,
  });
  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      imageUrl: json['image'],
      rating: json['rating'].toString(),
      price: json['price'].toString(),
    );
  }
}
