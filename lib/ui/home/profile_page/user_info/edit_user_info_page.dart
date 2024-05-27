import 'package:emergancy_call/model/user.dart';
import 'package:emergancy_call/services/auth_store.dart';
import 'package:emergancy_call/ui/home/profile_page/user_info/user_info_provider.dart';
import 'package:emergancy_call/ui/login-signup/login_signup.dart';
import 'package:emergancy_call/utils/buttons.dart';
import 'package:emergancy_call/utils/colors.dart';
import 'package:emergancy_call/utils/date_picker.dart';
import 'package:emergancy_call/utils/formatter.dart';
import 'package:emergancy_call/utils/validators.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

class UserInfoPage extends StatefulWidget {
  final User? user;
  const UserInfoPage({super.key, this.user});

  @override
  State<UserInfoPage> createState() => _UserInfoPageState();
}

class _UserInfoPageState extends State<UserInfoPage> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _phone = TextEditingController();
  final TextEditingController _fullName = TextEditingController();
  final TextEditingController _weight = TextEditingController();
  final TextEditingController _height = TextEditingController();
  final TextEditingController _nationalId = TextEditingController();
  final TextEditingController _medicalHistory = TextEditingController();
  Gender _selectedGender = Gender.male;
  final GlobalKey<FormState> _formState = GlobalKey<FormState>();
  String _selectedBloodType = "A+";
  DateTime? _selectedDate = DateTime.now();
  final List<String> _choices = [
    "A-",
    "A+",
    "B+",
    "B-",
    "O+",
    "O-",
    "AB+",
    "AB-"
  ];

  @override
  void initState() {
    _email.text = widget.user?.email ?? '';
    _phone.text = "0${widget.user?.userNumber ?? ''}";
    _fullName.text = widget.user?.fullname ?? '';
    _weight.text = (widget.user?.weight ?? '').toString();
    _height.text = (widget.user?.height ?? '').toString();
    _nationalId.text = widget.user?.nationalId ?? '';
    _medicalHistory.text = widget.user?.medicalHistory ?? '';
    _selectedGender =
        widget.user?.gender == "male" ? Gender.male : Gender.female;
    _selectedBloodType = widget.user?.bloodType ?? "A+";
    _selectedDate = widget.user?.dateOfBirth;
    _validateInput();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => UserInfoProvider(authStore: GetIt.I<AuthStore>()),
        builder: (context, snapshot) {
          UserInfoProvider provider = context.watch();
          return Scaffold(
            appBar: AppBar(
              backgroundColor: kPrimaryColor,
              title: const Text("Information"),
              automaticallyImplyLeading: false,
              centerTitle: true,
              actions: [
                QPrimaryButton(
                    isLoading: provider.isUpdating,
                    loaderColor: kWhiteColor,
                    enabled: _validateInput(),
                    onPressed: () async {
                      await provider.updateInfo({
                        'number': int.tryParse(_phone.text),
                        'gender':
                            _selectedGender == Gender.male ? "male" : "female",
                        'fullname': _fullName.text,
                        'bloodType': _selectedBloodType,
                        'nationalId': _nationalId.text,
                        'height': _height.text,
                        'weight': _weight.text,
                        'medicalHistory': _medicalHistory.text,
                        'dateOfBirth': Formatter.formatDateTimeToString(
                            _selectedDate ?? DateTime.now()),
                      });
                      Navigator.pop(context);
                    },
                    label: "Save")
              ],
              leading: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Icon(Icons.cancel)),
            ),
            body: SingleChildScrollView(
              child: Form(
                key: _formState,
                child: Column(
                  children: [
                    Column(
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
                              return null;
                            },
                            controller: _fullName,
                            decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: "Full name",
                                hintStyle:
                                    TextStyle(color: kPrimaryDarkerColor)),
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
                                hintStyle:
                                    TextStyle(color: kPrimaryDarkerColor)),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.45,
                                child: TextFormField(
                                  onChanged: (value) {
                                    setState(() {
                                      _formState.currentState!.validate();
                                      _validateInput();
                                    });
                                  },
                                  keyboardType: TextInputType.number,
                                  controller: _weight,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return null;
                                    }

                                    return null;
                                  },
                                  decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Weight",
                                      hintStyle: TextStyle(
                                          color: kPrimaryDarkerColor)),
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.45,
                                child: TextFormField(
                                  onChanged: (value) {
                                    setState(() {
                                      _formState.currentState!.validate();
                                      _validateInput();
                                    });
                                  },
                                  keyboardType: TextInputType.number,
                                  controller: _height,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return null;
                                    }

                                    return null;
                                  },
                                  decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Height",
                                      hintStyle: TextStyle(
                                          color: kPrimaryDarkerColor)),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(left: 8.0),
                                child: Text("Date Of Birth"),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.7,
                                child: GestureDetector(
                                  onTap: () async {
                                    _selectedDate = await showDate(context);
                                    setState(() {});
                                  },
                                  child: DatePicker(
                                    date: _selectedDate ?? DateTime.now(),
                                  ),
                                ),
                              ),
                            ],
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
                                hintStyle:
                                    TextStyle(color: kPrimaryDarkerColor)),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(left: 8.0),
                                child: Text("Blood type"),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.6,
                                child: DropdownButtonFormField<String>(
                                  value: _selectedBloodType,
                                  onChanged: (value) {
                                    _selectedBloodType = value ?? "A+";
                                  },
                                  items: _choices
                                      .map<DropdownMenuItem<String>>(
                                        (String value) =>
                                            DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value),
                                        ),
                                      )
                                      .toList(),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              maxLines: 6,
                              onChanged: (value) {
                                setState(() {
                                  _formState.currentState!.validate();
                                  _validateInput();
                                });
                              },
                              controller: _medicalHistory,
                              decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Medical History",
                                  hintStyle:
                                      TextStyle(color: kPrimaryDarkerColor)),
                            )),
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
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }

  _validateInput() {
    if (_email.text.isNotEmpty && _phone.text.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  Future<DateTime?> showDate(BuildContext context) async {
    final DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2101),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData(
            colorScheme: const ColorScheme.light(
              primary: kBlackedColor,
            ),
            textTheme: const TextTheme(
              bodyMedium: TextStyle(color: kPrimaryDarkerColor), // Number color
            ),
          ),
          child: DatePickerTheme(
            data: const DatePickerThemeData(
              backgroundColor: kPrimaryColor,
            ),
            child: child!,
          ),
        );
      },
    );
    return selectedDate;
  }
}
