class UserModel {
  final String email;
  final String name;
  final String? token;
  final String? image;
  final String? visa;
  final String? address;
  final String? phone;

  UserModel({
    required this.email,
    required this.name,
    this.token,
    this.image,
    this.visa,
    this.address,
    this.phone,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      email: json['email'],
      name: json['name'],
      token: json['token'],
      image: json['image'],
      visa: json['Visa'],
      address: json['address'],
      phone: json['phone'],
    );
  }
}
