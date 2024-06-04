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
  final TextEditingController _nationalId = TextEditingController();
  final TextEditingController _fullName = TextEditingController();
  Gender _selectedGender = Gender.male;
  final GlobalKey<FormState> _formState = GlobalKey<FormState>();

  _toggle() {
    setState(() {
      _email.clear();
      _password.clear();
      _confirmPassword.clear();
      _phone.clear();
      _nationalId.clear();
      _fullName.clear();
      isLogIn = !isLogIn;
    });
  }

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
                                          image: AssetImage(kClock))),
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
                                          image: AssetImage(kClock2))),
                                )),
                          ),
                          Positioned(
                            right: 40,
                            top: 40,
                            width: 80,
                            height: 150,
                            child: FadeInUp(
                                duration: const Duration(milliseconds: 1300),
                                child: Container(
                                  decoration: const BoxDecoration(
                                      image: DecorationImage(
                                          image: AssetImage(kClock2))),
                                )),
                          ),
                          Positioned(
                            child: FadeInUp(
                                duration: const Duration(milliseconds: 1600),
                                child: Container(
                                  margin:
                                      EdgeInsets.only(top: isLogIn ? 50 : 20),
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
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
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
                                                    int.parse(_phone.text),_nationalId.text , _fullName.text,
                                                    getGender());
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
                            height: 10,
                          ),
                          FadeInUp(
                              duration: const Duration(milliseconds: 2000),
                              child: TextButton(
                                onPressed: () {
                                 _toggle();
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
                if (!Validator.isFullNameValid(value)) {
                  return "Please Enter a Valid Full Name";
                }
                return null;
              },
              controller: _fullName,
              decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: "Full Name",
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
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return null;
                }
                if (!Validator.emailFieldValidation(value)) {
                  return "Please Enter a Valid Email";
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
              controller: _nationalId,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return null;
                }
                if (!Validator.nationalIdValidation(value)) {
                  return "Please enter a valid National ID";
                }
                return null;
              },
              decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: "National ID",
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
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return null;
                }
                if (!Validator.validatePassword(value)) {
                  return "Valid password must contains at least one uppercase letter, one smallcase letter, one number & one special character";
                }
                return null;
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
          ),
          Container(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Radio<Gender>(
                  activeColor: kPrimaryColor,
                  value: Gender.male,
                  groupValue: _selectedGender,
                  onChanged: (value) {
                    setState(() {
                      _selectedGender = value ?? Gender.male;
                    });
                  },
                ),
                const Text("Male"),
                const SizedBox(width: 20),
                Radio<Gender>(
                  activeColor: kPrimaryColor,
                  value: Gender.female,
                  groupValue: _selectedGender,
                  onChanged: (value) {
                    setState(() {
                      _selectedGender = value ?? Gender.male;
                    });
                  },
                ),
                const Text('Female'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void manageNavigation() {
    if (_email.text.contains("police")) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (context) => const HomePage(type: "POLICE")),
          (route) => false);
    } else if (_email.text.contains("ambulance")) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (context) => const HomePage(
                    type: "AMBULANCE",
                  )),
          (route) => false);
    } else if (_email.text.contains("civil")) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (context) => const HomePage(type: "CIVIL")),
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
          _phone.text.isNotEmpty &&
          _fullName.text.isNotEmpty &&
          _nationalId.text.isNotEmpty) {
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

  String getGender() {
    switch (_selectedGender) {
      case Gender.male:
        return "male";
      case Gender.female:
        return "female";
      default:
        return "";
    }
  }
}

enum Gender {
  male,
  female,
}
