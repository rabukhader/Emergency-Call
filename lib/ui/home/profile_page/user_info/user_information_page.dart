import 'package:emergancy_call/model/user.dart';
import 'package:emergancy_call/utils/colors.dart';
import 'package:flutter/material.dart';

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
      body: Container(
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Text('Name: ${user?.fullname}')),
              if (user?.nationalId != null)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text('National Id: ${user?.nationalId}'),
                ),
              if (user?.bloodType != null)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text('Blood Type: ${user?.bloodType}'),
                ),
              if (user?.userNumber != null)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical:  8.0),
                  child: Text('User Number: ${user?.userNumber}'),
                ),
              if (user?.dateOfBirth != null)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical:  8.0),
                  child: Text('Date Of Birth : ${user?.dateOfBirth.toString()}'),
                ),
              if (user?.email != null) Padding(
                padding: const EdgeInsets.symmetric(vertical:  8.0),
                child: Text('Email: ${user?.email}'),
              ),
              if (user?.gender != null) Padding(
                padding: const EdgeInsets.symmetric(vertical:  8.0),
                child: Text('Gender: ${user?.gender}'),
              ),
              if (user?.weight != null && user?.weight?.toString().trim() != '') 
                Padding(
                  padding: const EdgeInsets.symmetric(vertical:  8.0),
                  child: Text('Weight : ${user?.weight.toString()}'),
                ),
              if (user?.height != null  && user?.height?.toString().trim() != '')
                Padding(
                  padding: const EdgeInsets.symmetric(vertical:  8.0),
                  child: Text('Height : ${user?.height.toString()}'),
                ),
              if (user?.medicalHistory != null && user?.medicalHistory?.trim() != '')
                Padding(
                  padding: const EdgeInsets.symmetric(vertical:  8.0),
                  child: Text('Medical History : ${user?.medicalHistory}'),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
