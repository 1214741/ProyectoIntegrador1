import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:newtonapp/providers/auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplahScreen extends StatefulWidget {
  const SplahScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SplashScreen();
}

class _SplashScreen extends State<SplahScreen> {
 
  @override
  void initState() {
    super.initState();
    startTimer();
  }

  final AuthService _authS = AuthService();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
    return const Image(image: AssetImage('assets/gif/newton.gif'), fit: BoxFit.fill,);
  }

  void startTimer() {
    Timer(const Duration(seconds: 5), () {
      navigationUser();
    });
  }

  void navigationUser() async {
    SharedPreferences em = await SharedPreferences.getInstance();
    SharedPreferences pw = await SharedPreferences.getInstance();
    dynamic result = await _authS.signInWithEmailAndPassword(
        em.getString('email').toString(), pw.getString('password').toString(), false);
    if (result != null) {
      Navigator.of(context).pushNamedAndRemoveUntil('index', (route) => false);
    } else {
      Navigator.of(context).pushNamedAndRemoveUntil('home', (route) => false);
    }
  }
}
