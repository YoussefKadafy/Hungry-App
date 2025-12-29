class LoginEntity {
  String email;
  String password;

  LoginEntity({required this.email, required this.password});

  Map<String, String> toJson() => {'email': email, 'password': password};
}
