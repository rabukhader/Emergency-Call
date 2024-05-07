import 'package:emergancy_call/model/emergency.dart';
import 'package:emergancy_call/utils/buttons.dart';
import 'package:emergancy_call/utils/icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class EmergencyPage extends StatelessWidget {
  final Function(EmergencyType) onCall;
  const EmergencyPage({super.key, required this.onCall});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SvgPicture.asset(
          kDashboard,
          height: 200,
        ),
        Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: const Text(
              "Welcome to Amank - your safety companion. With just a tap, Amank locates and connects you to the nearest emergency services - ambulance, police, and civil defense. Stay empowered in emergencies, report incidents effortlessly, and ensure your safety on the go. Your peace of mind is our priority.",
              style: TextStyle(fontSize: 16),
            )),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            QPrimaryButton.icon(
              label: "Call Police",
              icon: const Icon(Icons.phone),
              onPressed: () async {
                await onCall.call(EmergencyType.police);
              },
            ),
            QPrimaryButton.icon(
              label: "Call Ambulance",
              icon: const Icon(Icons.phone),
              onPressed: () async {
                await onCall.call(EmergencyType.ambulance);
              },
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            QPrimaryButton.icon(
              label: "Call More",
              icon: const Icon(Icons.phone),
              onPressed: () {},
            ),
            QPrimaryButton.icon(
              label: "Call Civil Defense",
              icon: const Icon(Icons.phone),
              onPressed: () async {
                await onCall.call(EmergencyType.civil);
              },
            ),
          ],
        ),
        const SizedBox(
          height: 15,
        )
      ],
    );
  }
}
