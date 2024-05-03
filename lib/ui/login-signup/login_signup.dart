// ignore_for_file: use_build_context_synchronously

import 'package:emergancy_call/ui/home/home_page.dart';
import 'package:emergancy_call/ui/login-signup/login_signup_provider.dart';
import 'package:emergancy_call/utils/buttons.dart';
import 'package:emergancy_call/utils/colors.dart';
import 'package:emergancy_call/utils/icons.dart';
import 'package:emergancy_call/utils/toaster.dart';
import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class LoginSignUpPage extends StatefulWidget {
  final bool isLogIn;
  const LoginSignUpPage({super.key, required this.isLogIn});

  @override
  State<LoginSignUpPage> createState() => _LoginSignUpPageState();
}

class _LoginSignUpPageState extends State<LoginSignUpPage> {
  bool isLogIn = false;
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();

  @override
  void initState() {
    isLogIn = widget.isLogIn;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => AuthProvider(),
        builder: (context, snapshot) {
          AuthProvider authProvider = context.watch();
          return Scaffold(
              backgroundColor: Colors.white,
              body: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Container(
                      height: 300,
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                              colorFilter: ColorFilter.mode(
                                  kPrimaryColor, BlendMode.srcIn),
                              image: AssetImage('assets/images/background.png'),
                              fit: BoxFit.fill)),
                      child: Stack(
                        children: <Widget>[
                          Positioned(
                            left: 30,
                            width: 80,
                            height: 200,
                            child: FadeInUp(
                                duration: const Duration(seconds: 1),
                                child: Container(
                                  decoration: const BoxDecoration(
                                      image: DecorationImage(
                                          image: AssetImage(
                                              'assets/images/light-2.png'))),
                                )),
                          ),
                          Positioned(
                            left: 140,
                            width: 80,
                            height: 150,
                            child: FadeInUp(
                                duration: const Duration(milliseconds: 1200),
                                child: Container(
                                  decoration: const BoxDecoration(
                                      image: DecorationImage(
                                          image: AssetImage(
                                              'assets/images/light-2.png'))),
                                )),
                          ),
                          Positioned(
                            right: 40,
                            top: 40,
                            width: 80,
                            height: 150,
                            child: FadeInUp(
                                duration: const Duration(milliseconds: 1300),
                                child: SvgPicture.asset(kClock)),
                          ),
                          Positioned(
                            child: FadeInUp(
                                duration: const Duration(milliseconds: 1600),
                                child: Container(
                                  margin: const EdgeInsets.only(top: 50),
                                  child: Center(
                                    child: Text(
                                      isLogIn ? "Login" : "Sign Up",
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 40,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                )),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(25.0),
                      child: Column(
                        children: <Widget>[
                          FadeInUp(
                              duration: const Duration(milliseconds: 1800),
                              child: Container(
                                  padding: const EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                      boxShadow: [
                                        BoxShadow(
                                            color:
                                                kPrimaryColor.withOpacity(0.6),
                                            blurRadius: 20.0,
                                            offset: const Offset(0, 10))
                                      ]),
                                  child:
                                      isLogIn ? _loginForm() : _signUpForm())),
                          const SizedBox(
                            height: 30,
                          ),
                          FadeInUp(
                              duration: const Duration(milliseconds: 1900),
                              child: Row(
                                children: [
                                  Expanded(
                                      child: QPrimaryButton(
                                    isLoading: authProvider.isLoggingIn,
                                    label: isLogIn ? "Login" : "Sign Up",
                                    onPressed: isLogIn
                                        ? () async {
                                            bool result =
                                                await authProvider.login(
                                                    _email.text,
                                                    _password.text);

                                            if (result) {
                                              manageNavigation();
                                            } else {
                                              ErrorUtils.showGeneralError(
                                                  context,
                                                  "Invalid Credintials");
                                            }
                                          }
                                        : () async {
                                            bool result =
                                                await authProvider.signUp();
                                            if (result) {
                                            manageNavigation();
                                            } else {
                                              ErrorUtils.showGeneralError(
                                                  context,
                                                  "Invalid Credintials");
                                            }
                                          },
                                  )),
                                ],
                              )),
                          const SizedBox(
                            height: 70,
                          ),
                          FadeInUp(
                              duration: const Duration(milliseconds: 2000),
                              child: TextButton(
                                onPressed: () {
                                  setState(() {
                                    isLogIn = !isLogIn;
                                  });
                                },
                                child: Text(
                                  isLogIn
                                      ? "Create new account ? Go to sign up"
                                      : "Already have account ? Go to log In",
                                  style: const TextStyle(color: kPrimaryColor),
                                ),
                              )),
                          FadeInUp(
                              duration: const Duration(milliseconds: 2100),
                              child: TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text(
                                  "Back",
                                  style: TextStyle(color: kPrimaryColor),
                                ),
                              )),
                        ],
                      ),
                    )
                  ],
                ),
              ));
        });
  }

  _loginForm() {
    return Form(
      child: Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: _email,
              decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: "Email",
                  hintStyle: TextStyle(color: kPrimaryDarkerColor)),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: _password,
              obscureText: true,
              decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: "Password",
                  hintStyle: TextStyle(color: kPrimaryDarkerColor)),
            ),
          )
        ],
      ),
    );
  }

  _signUpForm() {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(8.0),
          child: const TextField(
            decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "Email",
                hintStyle: TextStyle(color: kPrimaryDarkerColor)),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(8.0),
          child: const TextField(
            decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "Phone number",
                hintStyle: TextStyle(color: kPrimaryDarkerColor)),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(8.0),
          child: const TextField(
            obscureText: true,
            decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "Password",
                hintStyle: TextStyle(color: kPrimaryDarkerColor)),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(8.0),
          child: const TextField(
            obscureText: true,
            decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "Confirm Password",
                hintStyle: TextStyle(color: kPrimaryDarkerColor)),
          ),
        )
      ],
    );
  }

  void manageNavigation() {
    if (_email.text.contains("police")) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (context) => const HomePage(type: "police")),
          (route) => false);
    } else if (_email.text.contains("ambulance")) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (context) => const HomePage(
                    type: "ambulance",
                  )),
          (route) => false);
    } else if (_email.text.contains("civil")) {
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
