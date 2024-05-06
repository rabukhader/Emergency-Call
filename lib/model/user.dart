class User {
  User(
      {required this.id,
      required this.email,
      required this.password,
      this.userNumber,
      this.gender, });

  final String id;
  final String email;
  final String password;
  final int? userNumber;
  final String? gender;

  factory User.fromJson(Map<String, dynamic> json) => User(
      id: json['id'],
      email: json['email'],
      password: json['password'],
      userNumber: json['userNumber'],
      gender: json['gender']);

  Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "password": password,
        "userNumber": userNumber,
        "gender" : gender
      };
}
