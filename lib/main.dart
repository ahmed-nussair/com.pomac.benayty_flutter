import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'globals.dart';
import 'ui/splash.dart';

void main()  async {

  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await Globals.firebaseMessaging.subscribeToTopic('benayty');
  Globals.firebaseMessaging.configure(
    onMessage: (Map<String, dynamic> message) async {
      print("onMessage: $message");
    },
    onBackgroundMessage: Globals.myBackgroundMessageHandler,
    onLaunch: (Map<String, dynamic> message) async {
      print("onLaunch: $message");
    },
    onResume: (Map<String, dynamic> message) async {
      print("onResume: $message");
    },
  );

  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(child: Splash()),
    ),
  );
}
