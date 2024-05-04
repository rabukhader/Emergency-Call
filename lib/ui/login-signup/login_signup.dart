// ignore_for_file: use_build_context_synchronously

import 'package:emergancy_call/services/auth_store.dart';
import 'package:emergancy_call/ui/home/home_page.dart';
import 'package:emergancy_call/ui/login-signup/login_signup_provider.dart';
import 'package:emergancy_call/utils/buttons.dart';
import 'package:emergancy_call/utils/colors.dart';
import 'package:emergancy_call/utils/icons.dart';
import 'package:emergancy_call/utils/toaster.dart';
import 'package:emergancy_call/utils/validators.dart';
import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

class LoginSignUpPage extends StatefulWidget {
  final bool isLogIn;
  const LoginSignUpPage({super.key, required this.isLogIn});

  @override
  State<LoginSignUpPage> createState() => _LoginSignUpPageState();
}

class _LoginSignUpPageState extends State<LoginSignUpPage> {
  bool isLogIn = false;
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _confirmPassword = TextEditingController();
  final TextEditingController _phone = TextEditingController();
  final GlobalKey<FormState> _formState = GlobalKey<FormState>();

  @override
  void initState() {
    isLogIn = widget.isLogIn;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => AuthProvider(authStore: GetIt.I<AuthStore>()),
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
                                              'assets/images/light-1.png'))),
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
                                    enabled: _validateInput(),
                                    label: isLogIn ? "Login" : "Sign Up",
                                    onPressed: isLogIn
                                        ? () async {
                                            String result =
                                                await authProvider.login(
                                                    _email.text,
                                                    _password.text);
                                            if (result == "pass") {
                                              manageNavigation();
                                            } else {
                                              ErrorUtils.showGeneralError(
                                                  context, result);
                                            }
                                          }
                                        : () async {
                                            String result =
                                                await authProvider.signUp(
                                                    _email.text,
                                                    _password.text,
                                                    int.parse(_phone.text));
                                            if (result == "pass") {
                                              manageNavigation();
                                            } else {
                                              ErrorUtils.showGeneralError(
                                                  context, result);
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
      key: _formState,
      child: Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              onChanged: (value) {
                setState(() {
                  _formState.currentState!.validate();
                  _validateInput();
                });
              },
              controller: _email,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return null;
                }
                if (!Validator.emailFieldValidation(value)) {
                  return "Please enter a valid email";
                }
                return null;
              },
              decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: "Email",
                  hintStyle: TextStyle(color: kPrimaryDarkerColor)),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              onChanged: (value) {
                setState(() {
                  _validateInput();
                });
              },
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
    return Form(
      key: _formState,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              onChanged: (value) {
                setState(() {
                  _formState.currentState!.validate();
                  _validateInput();
                });
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return null;
                }
                if (!Validator.emailFieldValidation(value)) {
                  return "Please enter a valid email";
                }
                return null;
              },
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
              onChanged: (value) {
                setState(() {
                  _formState.currentState!.validate();
                  _validateInput();
                });
              },
              keyboardType: TextInputType.number,
              controller: _phone,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return null;
                }
                if (!Validator.phoneNumerValidation(value)) {
                  return "Please enter a valid Phone Number";
                }
                return null;
              },
              decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: "Phone Number",
                  hintStyle: TextStyle(color: kPrimaryDarkerColor)),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              onChanged: (value) {
                setState(() {
                  _formState.currentState!.validate();
                  _validateInput();
                });
              },
              controller: _password,
              obscureText: true,
              decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: "Password",
                  hintStyle: TextStyle(color: kPrimaryDarkerColor)),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              onChanged: (value) {
                setState(() {
                  _formState.currentState!.validate();
                  _validateInput();
                });
              },
              controller: _confirmPassword,
              obscureText: true,
              decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: "Confirm Password",
                  hintStyle: TextStyle(color: kPrimaryDarkerColor)),
            ),
          )
        ],
      ),
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

  _validateInput() {
    if (widget.isLogIn) {
      if (_email.text.isNotEmpty && _password.text.isNotEmpty) {
        return true;
      } else {
        return false;
      }
    } else {
      if (_email.text.isNotEmpty &&
          _password.text.isNotEmpty &&
          _confirmPassword.text.isNotEmpty &&
          _phone.text.isNotEmpty) {
        if (_password.text == _confirmPassword.text) {
          return true;
        } else {
          return false;
        }
      } else {
        return false;
      }
    }
  }
}
