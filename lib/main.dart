import 'dart:async';

import 'package:emergancy_call/app/amank_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


Future<void> main() async {
  runZonedGuarded<Future<void>>(() async {
    WidgetsFlutterBinding.ensureInitialized();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light
        .copyWith(statusBarColor: Colors.transparent));
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

    _setupGetIt();

    await _preInit();

    runApp(const AmankApp());
  }, (error, stack) {
    //handling system errors
  });
}

void _setupGetIt() {
  //lazy singelton registration for repos, apis, all needed
}

Future _preInit() async {
  //initing the cookie managers and repos
}
