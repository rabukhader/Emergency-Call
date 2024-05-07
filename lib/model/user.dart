class User {
  User(
      {required this.id,
      required this.email,
      required this.password,
      this.userNumber,
      this.gender,
      this.bloodType,
      this.nationalId,
      this.height,
      this.weight,
      this.dateOfBirth,
      this.fullname,
      this.medicalHistory});

  final String id;
  String email;
  String password;
  int? userNumber;
  String? gender;
  String? fullname;
  String? bloodType;
  String? nationalId;
  int? height;
  int? weight;
  DateTime? dateOfBirth;
  String? medicalHistory;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json['id'],
        email: json['email'],
        password: json['password'],
        userNumber: json['userNumber'],
        gender: json['gender'],
        fullname: json['fullname'],
        bloodType: json['bloodType'],
        nationalId: json['nationalId'],
        height: json['height'],
        weight: json['weight'],
        medicalHistory: json['medicalHistory'],
        dateOfBirth: json['dateOfBirth'] != null
            ? DateTime.parse(json['dateOfBirth'])
            : null,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'email': email,
        'password': password,
        'userNumber': userNumber,
        'gender': gender,
        'fullname': fullname,
        'bloodType': bloodType,
        'nationalId': nationalId,
        'height': height,
        'weight': weight,
        'medicalHistory': medicalHistory,
        'dateOfBirth': dateOfBirth?.toIso8601String(),
      };
}
