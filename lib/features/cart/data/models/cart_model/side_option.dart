class SideOption {
  int? id;
  String? name;
  String? image;

  SideOption({this.id, this.name, this.image});

  factory SideOption.fromJson(Map<String, dynamic> json) => SideOption(
    id: json['id'] as int?,
    name: json['name'] as String?,
    image: json['image'] as String?,
  );

  Map<String, dynamic> toJson() => {'id': id, 'name': name, 'image': image};
}
