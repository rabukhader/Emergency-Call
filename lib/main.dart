import 'dart:async';

import 'package:emergancy_call/app/amank_app.dart';
import 'package:emergancy_call/firebase_options.dart';
import 'package:emergancy_call/services/auth_store.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';

Future<void> main() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light
        .copyWith(statusBarColor: Colors.transparent));
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

        _setupGetIt();

    runApp(const AmankApp());
}
void _setupGetIt(){
  GetIt.I.registerLazySingleton<AuthStore>(() => AuthStore());
}