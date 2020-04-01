import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'ui/splash.dart';

void main() async {
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(child: Splash()),
//      routes: {
//        '/home' : (context) => Home(),
//      },
    ),
  );
}
