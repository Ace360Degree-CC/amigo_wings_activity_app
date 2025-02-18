import 'dart:async';

import 'package:amigo_academy/screens/login.dart';
import 'package:flutter/material.dart';
 

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState

    Timer(Duration(seconds: 2), () {
      Navigator.push(context, MaterialPageRoute(builder: (context) =>const Login()));
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Image.asset('assets/loginlogo.png'),
      const  Text(
          'WINGS ACTIVITY',
          style: TextStyle(color: Colors.black87, letterSpacing: 4),
        )
      ]),
    );
  }
}
