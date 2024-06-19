import 'package:emergancy_call/model/user.dart';
import 'package:emergancy_call/utils/colors.dart';
import 'package:emergancy_call/utils/icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class UserInformationPage extends StatelessWidget {
  final User? user;
  const UserInformationPage({super.key, this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: const Text("Information"),
        automaticallyImplyLeading: false,
        centerTitle: true,
        leading: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: const Icon(Icons.cancel)),
      ),
      body: Column(
        children: [
          SizedBox(
            width: 120,
            height: 120,
            child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: SvgPicture.asset(
                    user?.gender == 'female' ? kProfileFemale : kProfileMale)),
          ),
          Text(
            user?.fullname ?? "No Full name",
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 22,),
          Text("National Id: ${(user?.nationalId ?? "No National Id Added")} "),
          Center(
            child: SingleChildScrollView(
              child: SizedBox(
                width: double.infinity,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      if (user?.bloodType != null)
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Text('Blood Type: ${user?.bloodType}'),
                        ),
                      if (user?.userNumber != null)
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Text('User Number: ${user?.userNumber}'),
                        ),
                      if (user?.dateOfBirth != null)
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Text(
                              'Date Of Birth : ${user?.dateOfBirth.toString()}'),
                        ),
                      if (user?.email != null)
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Text('Email: ${user?.email}'),
                        ),
                      if (user?.gender != null)
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Text('Gender: ${user?.gender}'),
                        ),
                      if (user?.weight != null &&
                          user?.weight?.toString().trim() != '')
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Text('Weight : ${user?.weight.toString()}'),
                        ),
                      if (user?.height != null &&
                          user?.height?.toString().trim() != '')
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Text('Height : ${user?.height.toString()}'),
                        ),
                      if (user?.medicalHistory != null &&
                          user?.medicalHistory?.trim() != '')
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child:
                              Text('Medical History : ${user?.medicalHistory}'),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
