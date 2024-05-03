import 'package:emergancy_call/ui/home/emergency_page/emergency_page.dart';
import 'package:emergancy_call/ui/home/home_page_provider.dart';
import 'package:emergancy_call/ui/home/profile_page/profile_page.dart';
import 'package:emergancy_call/ui/home/reports_page/reports_page.dart';
import 'package:emergancy_call/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

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
              title: const Text("Amank"),
              automaticallyImplyLeading: false,
              centerTitle: true,
            ),
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: _selectedPage,
              selectedItemColor: kPrimaryColor,
              unselectedItemColor: kPrimaryDarkerColor,
              onTap: (index){
                setState(() {
                  _selectedPage = index;
                });
              },
              items: const [
                BottomNavigationBarItem(label: "Home", icon: Icon(Icons.home)),
                BottomNavigationBarItem(label: "Reports", icon: Icon(Icons.present_to_all)),
                BottomNavigationBarItem(label: "Profile", icon: Icon(Icons.person)),
              ],
            ),
            body: _buildScreenAt(context, _selectedPage)
                  );
          }
        );
  }

  _buildScreenAt(BuildContext context, int index){
    switch(index){
      case 0: 
        return const EmergencyPage();
        case 1: 
        return const ReportsPage();
      case 2: 
        return const ProfilePage();
    }
  }
}