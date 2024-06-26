import 'package:emergancy_call/services/auth_store.dart';
import 'package:emergancy_call/ui/home/profile_page/car_info/car_info.dart';
import 'package:emergancy_call/ui/home/profile_page/profile_provider.dart';
import 'package:emergancy_call/ui/home/profile_page/user_info/edit_user_info_page.dart';
import 'package:emergancy_call/ui/home/profile_page/user_info/user_information_page.dart';
import 'package:emergancy_call/ui/on_boarding_page/onboarding_page.dart';
import 'package:emergancy_call/utils/colors.dart';
import 'package:emergancy_call/utils/icons.dart';
import 'package:emergancy_call/utils/loader.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_it/get_it.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatelessWidget {
  final String type;
  const ProfilePage({super.key, required this.type});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => ProfileProvider(authStore: GetIt.I<AuthStore>(), userType: type),
        builder: (context, snapshot) {
          ProfileProvider provider = context.watch();
          return provider.isLoading
              ? const LoaderWidget()
              : SingleChildScrollView(
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
                                  child: SvgPicture.asset(
                                      provider.getGender == 'female'
                                          ? kProfileFemale
                                          : kProfileMale)),
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
                                child: const Icon(
                                  LineAwesomeIcons.alternate_pencil,
                                  color: Colors.black,
                                  size: 20,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Text(provider.getEmail ?? "",
                            style: Theme.of(context).textTheme.headlineMedium),
                        Text("0${provider.getPhone ?? 0}",
                            style: Theme.of(context).textTheme.bodyMedium),
                        const SizedBox(height: 20),

                        /// -- BUTTON
                        SizedBox(
                          width: 200,
                          child: ElevatedButton(
                            onPressed: () async {
                              await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => UserInfoPage(
                                          user: provider.userData)));
                              await provider.refreshData();
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: kPrimaryColor,
                                side: BorderSide.none,
                                shape: const StadiumBorder()),
                            child: const Text("Edit Profile",
                                style: TextStyle(color: kWhiteColor)),
                          ),
                        ),
                        const SizedBox(height: 30),
                        const Divider(),
                        const SizedBox(height: 10),

                        if(type == "default") ProfileMenuWidget(
                            title: "Car Information",
                            icon: LineAwesomeIcons.car,
                            onPress: () async {
                              await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => CarInfoPage(
                                          userCar: provider.userCar)));
                              await provider.refreshData();
                            }),
                            if(type == "default") ProfileMenuWidget(
                            title: "User Information",
                            icon: LineAwesomeIcons.user,
                            onPress: () async {
                              await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => UserInformationPage(
                                          user: provider.userData)));
                              await provider.refreshData();
                            }),
                        const SizedBox(height: 10),
                        ProfileMenuWidget(
                            title: "Logout",
                            icon: LineAwesomeIcons.alternate_sign_out,
                            textColor: Colors.red,
                            endIcon: false,
                            onPress: () async {
                              await logout();
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const OnBoardingPage()));
                            }),
                      ],
                    ),
                  ),
                );
        });
  }

  logout() async {
    await FirebaseAuth.instance.signOut();
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.clear();
  }
}

class ProfileMenuWidget extends StatelessWidget {
  const ProfileMenuWidget({
    super.key,
    required this.title,
    required this.icon,
    required this.onPress,
    this.endIcon = true,
    this.textColor,
  });

  final String title;
  final IconData icon;
  final VoidCallback onPress;
  final bool endIcon;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    var iconColor = kPrimaryDarkerColor;

    return ListTile(
      onTap: onPress,
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: iconColor.withOpacity(0.1),
        ),
        child: Icon(icon, color: iconColor),
      ),
      title: Text(title,
          style:
              Theme.of(context).textTheme.bodyLarge?.apply(color: textColor)),
      trailing: endIcon
          ? Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: Colors.grey.withOpacity(0.1),
              ),
              child: const Icon(LineAwesomeIcons.angle_right,
                  size: 18.0, color: Colors.grey))
          : null,
    );
  }
}
