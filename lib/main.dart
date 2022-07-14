// ignore_for_file: unused_import, prefer_const_constructors

import 'package:first/moduels/counter/Counter_Screen.dart';
import 'package:first/moduels/bmi_result/bmi_result_screen.dart';
import 'package:first/moduels/bmi/bmi_screen.dart';
import 'package:first/moduels/messenger/messenger_screen.dart';
import 'package:first/moduels/home/home_screen.dart';
import 'package:first/moduels/login/loginscreen.dart';
import 'package:first/moduels/users/users_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    );
  }
}
