// ignore_for_file: use_build_context_synchronously

import 'package:emergancy_call/model/car.dart';
import 'package:emergancy_call/services/auth_store.dart';
import 'package:emergancy_call/ui/home/profile_page/car_info/car_info_provider.dart';
import 'package:emergancy_call/utils/buttons.dart';
import 'package:emergancy_call/utils/colors.dart';
import 'package:emergancy_call/utils/validators.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

class CarInfoPage extends StatefulWidget {
  final Car? userCar;
  const CarInfoPage({super.key, this.userCar});

  @override
  State<CarInfoPage> createState() => _ContainernfoPageState();
}

class _ContainernfoPageState extends State<CarInfoPage> {
  final TextEditingController _carNumber = TextEditingController();
  final TextEditingController _carYearModel = TextEditingController();
  final TextEditingController _carName = TextEditingController();
  final GlobalKey<FormState> _formState = GlobalKey<FormState>();
  bool? _isGuranteed;

  @override
  void initState() {
    _carName.text = widget.userCar?.carName ?? "";
    _carYearModel.text = widget.userCar?.carYearModel ?? "";
    _carNumber.text = (widget.userCar?.carNumber ?? "").toString();
    _isGuranteed = widget.userCar?.isGuranteed ?? false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => CarInfoProvider(authStore: GetIt.I<AuthStore>()),
        builder: (context, snapshot) {
          CarInfoProvider provider = context.watch();
          return Scaffold(
              appBar: AppBar(
                backgroundColor: kPrimaryColor,
                title: const Text("Car Information"),
                automaticallyImplyLeading: false,
                centerTitle: true,
                actions: [
                  QPrimaryButton(
                      isLoading: provider.isUpdating,
                      loaderColor: kWhiteColor,
                      enabled: _validateInput(),
                      onPressed: () async {
                        await provider.updateInfo({
                          'carNumber': int.tryParse(_carNumber.text),
                          'carYearModel': int.tryParse(_carYearModel.text),
                          'carName': _carName.text,
                          'isGuranteed': _isGuranteed
                        });
                        Navigator.pop(context);
                      },
                      label: "Save"),
                ],
                leading: GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(Icons.cancel)),
              ),
              body: SingleChildScrollView(
                child: Form(
                    key: _formState,
                    child: Column(children: [
                      Column(children: [
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
                            controller: _carName,
                            decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: "Car Type Name",
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
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return null;
                              }
                              return null;
                            },
                            keyboardType: TextInputType.number,
                            controller: _carNumber,
                            decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: "Car Type Name",
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
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return null;
                              }
                              if (Validator.isNumericWithLength(value, 4)) {
                                return null;
                              }
                              return null;
                            },
                            keyboardType: TextInputType.number,
                            controller: _carYearModel,
                            decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: "Car Year Model",
                                hintStyle:
                                    TextStyle(color: kPrimaryDarkerColor)),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Radio<bool>(
                                activeColor: kPrimaryColor,
                                value: true,
                                groupValue: _isGuranteed,
                                onChanged: (value) {
                                  setState(() {
                                    _isGuranteed = value ?? false;
                                  });
                                },
                              ),
                              const Text("Guranteed"),
                              const SizedBox(width: 20),
                              Radio<bool>(
                                activeColor: kPrimaryColor,
                                value: false,
                                groupValue: _isGuranteed,
                                onChanged: (value) {
                                  setState(() {
                                    _isGuranteed = value ?? false;
                                  });
                                },
                              ),
                              const Text('Not Guranteed'),
                            ],
                          ),
                        ),
                      ])
                    ])),
              ));
        });
  }

  _validateInput() {
    return (_carName.text.isNotEmpty &&
        _carNumber.text.isNotEmpty &&
        _carYearModel.text.isNotEmpty);
  }
}
