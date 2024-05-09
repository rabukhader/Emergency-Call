class Car {
  final int? carNumber;
  final String? carName;
  final String? carYearModel;
  final bool? isGuranteed;

  Car(
      {required this.carNumber,
      required this.isGuranteed,
      required this.carName,
      required this.carYearModel});

  Map<String, dynamic> toJson() {
    return {
      'carNumber': carNumber,
      'carName': carName,
      'carYearModel': carYearModel,
      'isGuranteed': isGuranteed
    };
  }

  factory Car.fromJson(Map<String, dynamic> json) {
    return Car(
        carNumber: json['carNumber'],
        carName: json['carName'],
        isGuranteed: json['isGuranteed'],
        carYearModel: (json['carYearModel']).toString());
  }
}
