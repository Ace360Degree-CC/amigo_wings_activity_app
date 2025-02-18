import 'package:amigo_academy/screens/lead.dart';
import 'package:amigo_academy/screens/splash.dart';

import 'package:amigo_academy/shared_preferences/user_status.dart';
import 'package:flutter/material.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,

      home: SplashScreen(),
      // home: Lead()
    );
  }
}
