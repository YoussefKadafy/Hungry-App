class Topping {
  int? id;
  String? name;
  String? image;

  Topping({this.id, this.name, this.image});

  factory Topping.fromJson(Map<String, dynamic> json) => Topping(
    id: json['id'] as int?,
    name: json['name'] as String?,
    image: json['image'] as String?,
  );

  Map<String, dynamic> toJson() => {'id': id, 'name': name, 'image': image};
}
