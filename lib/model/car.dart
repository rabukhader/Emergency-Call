class Car {
  int? carNumber;
  String? carName;
  String? carYearModel;
  bool? isGuranteed;
  String? insuranceCompany;

  Car(
      {required this.carNumber,
      required this.isGuranteed,
      required this.insuranceCompany,
      required this.carName,
      required this.carYearModel});

  Map<String, dynamic> toJson() {
    return {
      'carNumber': carNumber,
      'carName': carName,
      'carYearModel': carYearModel,
      'isGuranteed': isGuranteed,
      'insuranceCompany': insuranceCompany
    };
  }

  factory Car.fromJson(Map<String, dynamic> json) {
    return Car(
        carNumber: json['carNumber'],
        insuranceCompany: json['insuranceCompany'],
        carName: json['carName'],
        isGuranteed: json['isGuranteed'],
        carYearModel: (json['carYearModel']).toString());
  }
}
