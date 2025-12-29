class ToppingsModel {
  final String title;
  final String image;
  final int id;

  ToppingsModel({required this.title, required this.image, required this.id});

  factory ToppingsModel.fromJson(Map<String, dynamic> json) {
    return ToppingsModel(
      title: json['name'],
      image: json['image'],
      id: json['id'],
    );
  }
}
