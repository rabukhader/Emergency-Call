import 'package:emergancy_call/ui/home/dashboard/dahsboard.dart';
import 'package:emergancy_call/ui/home/emergency_page/emergency_page.dart';
import 'package:emergancy_call/ui/home/home_page_provider.dart';
import 'package:emergancy_call/ui/home/profile_page/profile_page.dart';
import 'package:emergancy_call/ui/home/reports_page/reports_page.dart';
import 'package:emergancy_call/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  final String type;
  const HomePage({super.key, required this.type});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedPage = 0;
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => HomePageProvider(),
        builder: (context, snapshot) {
          // ignore: unused_local_variable
          HomePageProvider model = context.watch();
          return Scaffold(
              appBar: AppBar(
                backgroundColor: kPrimaryColor,
                title: Text(widget.type == "default"
                    ? "Amank"
                    : widget.type.capitalizeFirst ?? ""),
                automaticallyImplyLeading: false,
                centerTitle: true,
              ),
              bottomNavigationBar: BottomNavigationBar(
                currentIndex: _selectedPage,
                selectedItemColor: kPrimaryColor,
                unselectedItemColor: kPrimaryDarkerColor,
                onTap: (index) {
                  setState(() {
                      _selectedPage = index;
                  });
                },
                items: [
                  const BottomNavigationBarItem(
                      label: "Home", icon: Icon(Icons.home)),
                  if (widget.type == "default")
                    const BottomNavigationBarItem(
                        label: "Reports", icon: Icon(Icons.present_to_all)),
                  const BottomNavigationBarItem(
                      label: "Profile", icon: Icon(Icons.person)),
                ],
              ),
              body: _buildScreenAt(context, _selectedPage));
        });
  }

  _buildScreenAt(BuildContext context, int index) {
    switch (index) {
      case 0:
        return getMainPage();
      case 1:
        return getSecondPage();
      case 2:
        return const ProfilePage();
    }
  }

  getMainPage() {
    if (widget.type == "default") {
      return const EmergencyPage();
    } else {
      return DashboardPage(type: widget.type);
    }
  }
    getSecondPage() {
    if (widget.type == "default") {
      return const ReportsPage();
    } else {
      return const ProfilePage();
    }
  }
}
