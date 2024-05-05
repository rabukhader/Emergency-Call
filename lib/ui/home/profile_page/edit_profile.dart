import 'package:emergancy_call/utils/buttons.dart';
import 'package:emergancy_call/utils/colors.dart';
import 'package:emergancy_call/utils/icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        automaticallyImplyLeading: false,
        centerTitle: true,
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(LineAwesomeIcons.angle_left)),
        title: const Text(
          "Edit Profile",
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Stack(
                children: [
                  SizedBox(
                    width: 120,
                    height: 120,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: SvgPicture.asset(kProfileFemale)),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 35,
                      height: 35,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: kPrimaryColor),
                      child: const Icon(LineAwesomeIcons.camera,
                          color: Colors.black, size: 20),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 50),

              // -- Form Fields
              Form(
                child: Column(
                  children: [
                    // TextFormField(
                    //   decoration: const InputDecoration(
                    //       label: Text(tFullName), prefixIcon: Icon(LineAwesomeIcons.user)),
                    // ),
                    // const SizedBox(height: tFormHeight - 20),
                    // TextFormField(
                    //   decoration: const InputDecoration(
                    //       label: Text(tEmail), prefixIcon: Icon(LineAwesomeIcons.envelope_1)),
                    // ),
                    // const SizedBox(height: tFormHeight - 20),
                    // TextFormField(
                    //   decoration: const InputDecoration(
                    //       label: Text(tPhoneNo), prefixIcon: Icon(LineAwesomeIcons.phone)),
                    // ),
                    const SizedBox(height: 24 - 20),
                    TextFormField(
                      obscureText: true,
                      decoration: InputDecoration(
                        label: const Text("Password"),
                        prefixIcon: const Icon(Icons.fingerprint),
                        suffixIcon: IconButton(
                            icon: const Icon(LineAwesomeIcons.eye_slash),
                            onPressed: () {}),
                      ),
                    ),
                    const SizedBox(height: 12.0),

                    // -- Form Submit Button
                    SizedBox(
                      width: double.infinity,
                      child: QSecondaryButton(
                        onPressed: () {},
                        label: "Edit Profile",
                      ),
                    ),
                    const SizedBox(height: 12.0),

                    // -- Created Date and Delete Button
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: QPrimaryButton(
                            onPressed: () {},
                            label: "Delete",
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
