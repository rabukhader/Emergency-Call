import 'package:dots_indicator/dots_indicator.dart';
import 'package:emergancy_call/ui/home/home_page.dart';
import 'package:emergancy_call/ui/login-signup/login_signup.dart';
import 'package:emergancy_call/ui/on_boarding_page/onboarding_view.dart';
import 'package:emergancy_call/utils/buttons.dart';
import 'package:emergancy_call/utils/colors.dart';
import 'package:emergancy_call/utils/icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OnBoardingPage extends StatefulWidget {
  final Uri? deeplinkUri;

  const OnBoardingPage({
    super.key,
    this.deeplinkUri,
  });

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  double currentPage = 0.0;
  final PageController _pageController = PageController();

  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    _pageController.addListener(() {
      setState(() {
        currentPage = _pageController.page ?? 0.0;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          systemOverlayStyle: SystemUiOverlayStyle.dark,
          toolbarHeight: 0,
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Stack(
            children: [
              Positioned(
                bottom: 0,
                top: 0,
                right: 0,
                left: 0,
                child: PageView(
                  controller: _pageController,
                  children: _onBoardingScreens(context),
                ),
              ),
              Positioned(
                bottom: (MediaQuery.of(context).size.height - 36) * (0.2),
                left: 0,
                right: 0,
                child: _buildDotsIndicator(),
              ),
              Positioned(
                bottom: 16,
                right: 0,
                left: 0,
                child: _buildLoginButtons(context),
              ),
            ],
          ),
        ));
  }

  DotsIndicator _buildDotsIndicator() {
    return DotsIndicator(
      dotsCount: 3,
      position: currentPage.toInt(),
      decorator: DotsDecorator(
        size: const Size(10.0, 4.0),
        activeSize: const Size(24.0, 4.0),
        color: AppColors.lightGray,
        activeColor: kPrimaryColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3.0)),
        activeShape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
      ),
    );
  }

  List<Widget> _onBoardingScreens(BuildContext context) {
    return [
      const OnBoardingView(
        title: "Safety at Your Fingertips",
        message: "Instantly Connect to Emergency Services",
        imagePath: kOnBoardingIcon1,
      ),
      const OnBoardingView(
        title: "Empowering Safety",
        message: "Help Just a Tap Away",
        imagePath: kOnBoardingIcon2,
      ),
      const OnBoardingView(
        title: "Prompt Assistant",
        message: "Your Lifeline in Critical Moments",
        imagePath: kOnBoardingIcon3,
      ),
    ];
  }

  _buildLoginButtons(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 26.0),
      child: Row(
        children: [
          Expanded(
            child: QSecondaryButton(
              onPressed: _goToLogin,
              width: 1,
              label: "Login",
            ),
          ),
          const SizedBox(width: 11),
          Expanded(
            child: QPrimaryButton(
              label: "Sign Up for free",
              onPressed: _goToSignUp,
            ),
          ),
        ],
      ),
    );
  }

  _goToSignUp() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => const HomePage()));
  }

  _goToLogin() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginSignUpPage(isLogIn: true,)));
  }
}
