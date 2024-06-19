import 'package:emergancy_call/utils/icons.dart';
import 'package:flutter/material.dart';

class WeatherStatus extends StatelessWidget {
  final String weatherStatus;
  const WeatherStatus({super.key, required this.weatherStatus});

  @override
  Widget build(BuildContext context) {
    switch (weatherStatus) {
      case "Snowy":
        return Image.asset(kSnowy);
      case "Cloudy":
        return Image.asset(kCloudy);
      case "Rainy":
        return Image.asset(kRainy);
      case "Sunny":
        return Image.asset(kSunny);
      default:
        return Text(weatherStatus);
    }
  }
}
