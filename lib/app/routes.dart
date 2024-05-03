
import 'package:emergancy_call/ui/on_boarding_page/onboarding_page.dart';
import 'package:emergancy_call/ui/splash_screen/splash_screen.dart';

class Routes {
  static final routes = {
    "/" : (context) => const SplashScreen(),
    "on_boarding": (context) => const OnBoardingPage(),
  };
}