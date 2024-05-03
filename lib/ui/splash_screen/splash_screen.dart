import 'package:emergancy_call/ui/on_boarding_page/onboarding_page.dart';
import 'package:emergancy_call/utils/cache_picture.dart';
import 'package:emergancy_call/utils/colors.dart';
import 'package:emergancy_call/utils/icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 1500), () async {
      if (mounted) {
        await _onSplashCompleted();
      }
    });
    super.initState();
  }

  @override
  void didChangeDependencies() {
    precacheSvgPicture(kAmankLogoIcons);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [kPrimaryColor, kLightOrangeColor])),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                kAmankLogoIcons,
                color: kWhiteColor,
                height: 350,
              ),
              const Text(
                "Amank",
                style: TextStyle(
                    color: kWhiteColor,
                    fontSize: 44,
                    fontWeight: FontWeight.w700),
              )
            ],
          ),
        ),
      ),
    );
  }

  _onSplashCompleted() {
    // /Check Login Status
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (c) => const OnBoardingPage()),
        (route) => false);
  }
}
