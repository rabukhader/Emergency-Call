class User {
  User({
    required this.id,
    required this.email,
    required this.password
  });

  final String id;
  final String email;
  final String password;

  factory User.fromJson(Map<String,dynamic> json) => User(
    id: json['id'],
    email: json['email'],
    password: json['password']
  );

  Map<String, dynamic> toJson() => {
    "id" : id,
    "email" :email,
    "password" : password
  };
}