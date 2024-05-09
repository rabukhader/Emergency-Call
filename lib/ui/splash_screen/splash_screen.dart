import 'package:emergancy_call/model/user.dart';
import 'package:emergancy_call/services/auth_store.dart';
import 'package:emergancy_call/ui/home/home_page.dart';
import 'package:emergancy_call/ui/on_boarding_page/onboarding_page.dart';
import 'package:emergancy_call/utils/cache_picture.dart';
import 'package:emergancy_call/utils/colors.dart';
import 'package:emergancy_call/utils/icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_it/get_it.dart';

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

  _onSplashCompleted() async {
    User? user = await GetIt.I<AuthStore>().getUser();
    print(user);
    if (user != null) {
          manageNavigation(user.email);
    } else {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (c) => const OnBoardingPage()),
          (route) => false);
    }
  }

  void manageNavigation(String email) {
    if (email.contains("police")) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (context) => const HomePage(type: "POLICE")),
          (route) => false);
    } else if (email.contains("ambulance")) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (context) => const HomePage(
                    type: "ambulance",
                  )),
          (route) => false);
    } else if (email.contains("civil")) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (context) => const HomePage(type: "civil")),
          (route) => false);
    } else {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (context) => const HomePage(type: "default")),
          (route) => false);
    }
  }
}
