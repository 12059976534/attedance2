import 'dart:async';

import 'package:attendance2/auth/login.dart';
import 'package:attendance2/page/homepage.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CheckStatus extends StatefulWidget {
  const CheckStatus({Key? key}) : super(key: key);

  @override
  State<CheckStatus> createState() => _CheckStatusState();
}

class _CheckStatusState extends State<CheckStatus> {
  _replaceto() async {
    final prefs = await SharedPreferences.getInstance();
    var time = const Duration(seconds: 1);
    // bool status = await prefs.setBool('login', true);
    return Timer(time, (() {
      final bool? status = prefs.getBool('login');
      (status != true)
          ? Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (BuildContext context) => Login()))
          : Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (BuildContext context) => Homepage()));
    }));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _replaceto();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Container(
        child: CircularProgressIndicator(
          color: Colors.black,
        ),
      ),
    ));
  }
}
