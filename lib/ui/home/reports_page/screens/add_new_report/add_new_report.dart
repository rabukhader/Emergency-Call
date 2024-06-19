import 'package:emergancy_call/model/car.dart';
import 'package:emergancy_call/model/emergency.dart';
import 'package:emergancy_call/model/report.dart';
import 'package:emergancy_call/services/auth_store.dart';
import 'package:emergancy_call/ui/home/reports_page/screens/add_new_report/add_new_report_provider.dart';
import 'package:emergancy_call/utils/buttons.dart';
import 'package:emergancy_call/utils/colors.dart';
import 'package:emergancy_call/utils/date_picker.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class AddNewReport extends StatefulWidget {
  const AddNewReport({super.key});

  @override
  State<AddNewReport> createState() => _AddNewReportState();
}

class _AddNewReportState extends State<AddNewReport> {
  final TextEditingController _title = TextEditingController();
  final TextEditingController _description = TextEditingController();
  final TextEditingController _policeName = TextEditingController();
  final TextEditingController _numberOfCars = TextEditingController();
  final TextEditingController _numberOfInjuries = TextEditingController();
  final GlobalKey<FormState> _formState = GlobalKey<FormState>();
  DateTime? selectedDate = DateTime.now();
  String? _selectedWeather;
  EmergencyType? _selectedType;
  List<String> images = [];
  bool _isDeath = false;
  List<Car> cars = [];
  List<String> injuriesInAccident = [];
  List<String> injuryDegrees = ["Minor", "Moderate", "Severe"];
  List<String> weather = ["Sunny", "Cloudy", "Rainy", "Snowy"];

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => AddNewReportProvider(authStore: GetIt.I<AuthStore>()),
        builder: (context, snapshot) {
          AddNewReportProvider model = context.watch();
          return SingleChildScrollView(
            child: Column(
              children: [
                Form(
                  key: _formState,
                  child: Column(
                    children: [
                      const Center(
                        child: Text("New Report",
                            style: TextStyle(color: kPrimaryDarkerColor)),
                      ),
                      Container(
                          margin: const EdgeInsets.symmetric(
                              vertical: 6, horizontal: 12),
                          padding: const EdgeInsets.symmetric(
                              vertical: 6, horizontal: 12),
                          child: TextFormField(
                            onChanged: (value) {
                              setState(() {
                                _formState.currentState!.validate();
                                _validateInput();
                              });
                            },
                            controller: _title,
                            decoration: const InputDecoration(
                                label: Text('Title'),
                                labelStyle: TextStyle(color: Colors.black),
                                border: InputBorder.none,
                                hintText: "Title",
                                hintStyle:
                                    TextStyle(color: kPrimaryDarkerColor)),
                          )),
                      Container(
                          margin: const EdgeInsets.symmetric(
                              vertical: 6, horizontal: 12),
                          padding: const EdgeInsets.symmetric(
                              vertical: 6, horizontal: 12),
                          child: TextFormField(
                            maxLines: 6,
                            onChanged: (value) {
                              setState(() {
                                _formState.currentState!.validate();
                                _validateInput();
                              });
                            },
                            controller: _description,
                            decoration: const InputDecoration(
                                label: Text('Description'),
                                labelStyle: TextStyle(color: Colors.black),
                                border: InputBorder.none,
                                hintText: "Description",
                                hintStyle:
                                    TextStyle(color: kPrimaryDarkerColor)),
                          )),
                      Container(
                          margin: const EdgeInsets.symmetric(
                              vertical: 6, horizontal: 12),
                          padding: const EdgeInsets.symmetric(
                              vertical: 6, horizontal: 12),
                          child: TextFormField(
                            onChanged: (value) {
                              setState(() {
                                _formState.currentState!.validate();
                                _validateInput();
                              });
                            },
                            controller: _policeName,
                            decoration: const InputDecoration(
                                label: Text('Police Officer'),
                                labelStyle: TextStyle(color: Colors.black),
                                border: InputBorder.none,
                                hintText: "Police Officer",
                                hintStyle:
                                    TextStyle(color: kPrimaryDarkerColor)),
                          )),
                      Container(
                        margin: const EdgeInsets.symmetric(
                            vertical: 6, horizontal: 12),
                        padding: const EdgeInsets.symmetric(
                            vertical: 6, horizontal: 12),
                        child: GestureDetector(
                          onTap: () async {
                            selectedDate = await model.showDate(context);
                            setState(() {});
                          },
                          child: DatePicker(
                            date: selectedDate ?? DateTime.now(),
                          ),
                        ),
                      ),
                      Container(
                            margin: const EdgeInsets.symmetric(
                                vertical: 6, horizontal: 12),
                            padding: const EdgeInsets.symmetric(
                                vertical: 6, horizontal: 12),
                            child: DropdownButtonFormField<String>(
                              decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Weather Status",
                                  hintStyle:
                                      TextStyle(color: kPrimaryDarkerColor)),
                              items: weather.map((String weatherStatus) {
                                return DropdownMenuItem<String>(
                                  value: weatherStatus,
                                  child: Text(weatherStatus),
                                );
                              }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  _selectedWeather = value;
                                });
                              },
                            )),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 12),
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Row(
                          children: [
                            Checkbox(
                              activeColor: kPrimaryColor,
                                value: _isDeath,
                                onChanged: (bool? value) {
                                  setState(() {
                                    _isDeath = value ?? false;
                                  });
                                }),
                            const Text("Any Death?")
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(
                            vertical: 6, horizontal: 12),
                        padding: const EdgeInsets.symmetric(
                            vertical: 6, horizontal: 12),
                        child: const Divider(
                          height: 4,
                          thickness: 2,
                          color: kPrimaryColor,
                        ),
                      ),
                      Container(
                          margin: const EdgeInsets.symmetric(
                              vertical: 6, horizontal: 12),
                          padding: const EdgeInsets.symmetric(
                              vertical: 6, horizontal: 12),
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            onChanged: (value) {
                              setState(() {
                                _updateCarsList(int.tryParse(value) ?? 0);
                                _formState.currentState!.validate();
                                _validateInput();
                              });
                            },
                            controller: _numberOfCars,
                            decoration: const InputDecoration(
                                label: Text('Number of Cars'),
                                labelStyle: TextStyle(color: Colors.black),
                                border: InputBorder.none,
                                hintText: "Number of Cars",
                                hintStyle:
                                    TextStyle(color: kPrimaryDarkerColor)),
                          )),
                      ...List.generate(int.tryParse(_numberOfCars.text) ?? 0,
                          (index) {
                        return Column(
                          children: [
                            Text("Car ${index + 1}"),
                            Container(
                                margin: const EdgeInsets.symmetric(
                                    vertical: 6, horizontal: 12),
                                padding: const EdgeInsets.symmetric(
                                    vertical: 6, horizontal: 12),
                                child: TextFormField(
                                  onChanged: (value) {
                                    setState(() {
                                      cars[index].carName = value;
                                      _formState.currentState!.validate();
                                      _validateInput();
                                    });
                                  },
                                  decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Car Name",
                                      hintStyle: TextStyle(
                                          color: kPrimaryDarkerColor)),
                                )),
                            Container(
                                margin: const EdgeInsets.symmetric(
                                    vertical: 6, horizontal: 12),
                                padding: const EdgeInsets.symmetric(
                                    vertical: 6, horizontal: 12),
                                child: TextFormField(
                                  onChanged: (value) {
                                    setState(() {
                                      cars[index].carYearModel = value;
                                      _formState.currentState!.validate();
                                      _validateInput();
                                    });
                                  },
                                  decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Car Model Year",
                                      hintStyle: TextStyle(
                                          color: kPrimaryDarkerColor)),
                                )),
                                Container(
                                margin: const EdgeInsets.symmetric(
                                    vertical: 6, horizontal: 12),
                                padding: const EdgeInsets.symmetric(
                                    vertical: 6, horizontal: 12),
                                child: TextFormField(
                                  onChanged: (value) {
                                    setState(() {
                                      cars[index].insuranceCompany = value;
                                      _formState.currentState!.validate();
                                      _validateInput();
                                    });
                                  },
                                  decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Insurance Company",
                                      hintStyle: TextStyle(
                                          color: kPrimaryDarkerColor)),
                                )),
                            Container(
                                margin: const EdgeInsets.symmetric(
                                    vertical: 6, horizontal: 12),
                                padding: const EdgeInsets.symmetric(
                                    vertical: 6, horizontal: 12),
                                child: TextFormField(
                                  onChanged: (value) {
                                    setState(() {
                                      cars[index].carNumber = int.parse(value);
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
                                  decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Car Plate Number",
                                      hintStyle: TextStyle(
                                          color: kPrimaryDarkerColor)),
                                )),
                            Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 12),
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12),
                              child: Row(
                                children: [
                                  Checkbox(
                                      value: cars[index].isGuranteed ?? false,
                                      onChanged: (bool? value) {
                                        setState(() {
                                          cars[index].isGuranteed =
                                              value ?? false;
                                        });
                                      }),
                                  const Text("Guaranteed?")
                                ],
                              ),
                            ),
                          ],
                        );
                      }),
                      Container(
                          margin: const EdgeInsets.symmetric(
                              vertical: 6, horizontal: 12),
                          padding: const EdgeInsets.symmetric(
                              vertical: 6, horizontal: 12),
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            onChanged: (value) {
                              setState(() {
                                _formState.currentState!.validate();
                                _validateInput();
                              });
                            },
                            controller: _numberOfInjuries,
                            decoration: const InputDecoration(
                                label: Text('Number of Injuries'),
                                border: InputBorder.none,
                                hintText: "Number of Injuries",
                                labelStyle: TextStyle(color: Colors.black),
                                hintStyle:
                                    TextStyle(color: kPrimaryDarkerColor)),
                          )),
                      ...List.generate(
                          int.tryParse(_numberOfInjuries.text) ?? 0, (index) {
                        return Container(
                            margin: const EdgeInsets.symmetric(
                                vertical: 6, horizontal: 12),
                            padding: const EdgeInsets.symmetric(
                                vertical: 6, horizontal: 12),
                            child: DropdownButtonFormField<String>(
                              decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Injury Degree",
                                  hintStyle:
                                      TextStyle(color: kPrimaryDarkerColor)),
                              items: injuryDegrees.map((String degree) {
                                return DropdownMenuItem<String>(
                                  value: degree,
                                  child: Text(degree),
                                );
                              }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  injuriesInAccident.add(value ?? '');
                                });
                              },
                            ));
                      }),
                      Center(
                          child: QPrimaryButton(
                        label: "Add Photos",
                        onPressed: () => showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text("Choose an image source"),
                              actions: [
                                TextButton(
                                  onPressed: () async {
                                    Navigator.pop(context);
                                    String link = await model
                                        .pickImage(ImageSource.camera);
                                    if (link != "false") {
                                      images.add(link);
                                    }
                                    setState(() {});
                                  },
                                  child: const Text("Camera"),
                                ),
                                TextButton(
                                  onPressed: () async {
                                    Navigator.pop(context);
                                    String link = await model
                                        .pickImage(ImageSource.gallery);
                                    if (link != "false") {
                                      images.add(link);
                                    }
                                    setState(() {});
                                  },
                                  child: const Text("Gallery"),
                                ),
                              ],
                            );
                          },
                        ),
                      )),
                      Column(
                        children: images
                            .map((e) => Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Image.network(
                                    e,
                                    width: 150,
                                    height: 150,
                                  ),
                                ))
                            .toList(),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 24),
                  child: Row(
                    children: [
                      Expanded(
                        child: QPrimaryButton(
                          label: "Add",
                          enabled: _validateInput(),
                          onPressed: () {
                            model.addNewReport(Report(
                              policeOfficer: _policeName.text,
                                weather : _selectedWeather!,
                                imagesUrl: images,
                                death: _isDeath,
                                location: model.userLocation,
                                injuries: injuriesInAccident,
                                cars: cars,
                                type: _selectedType ?? EmergencyType.ambulance,
                                title: _title.text,
                                description: _description.text,
                                date: selectedDate ?? DateTime.now()));
                            clear();
                            setState(() {});
                          },
                          isLoading: model.isAdding,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }

  void _updateCarsList(int count) {
    if (count > cars.length) {
      for (int i = cars.length; i < count; i++) {
        cars.add(Car(
            carNumber: 0, isGuranteed: false, carName: '', carYearModel: '', insuranceCompany: ''));
      }
    } else {
      cars = cars.sublist(0, count);
    }
  }

  bool _validateInput() {
    return (_title.text.isNotEmpty && _selectedWeather != null &&
        _description.text.isNotEmpty &&
        _policeName.text.isNotEmpty &&
        int.tryParse(_numberOfCars.text) != null &&
        int.tryParse(_numberOfInjuries.text) != null);
  }

  void clear() {
    _title.text = "";
    _description.text = "";
    _policeName.text = "";
    _numberOfCars.text = "";
    _numberOfInjuries.text = "";
    selectedDate = DateTime.now();
    images = [];
    _isDeath = false;
    cars = [];
  }
}
