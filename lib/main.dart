// ignore_for_file: unused_import, prefer_const_constructors

import 'package:bloc/bloc.dart';
import 'package:first/layout/home_layout.dart';
import 'package:first/moduels/counter/Counter_Screen.dart';
import 'package:first/moduels/bmi_result/bmi_result_screen.dart';
import 'package:first/moduels/bmi/bmi_screen.dart';
import 'package:first/moduels/messenger/messenger_screen.dart';
import 'package:first/moduels/home/home_screen.dart';
import 'package:first/moduels/login/loginscreen.dart';
import 'package:first/moduels/users/users_screen.dart';
import 'package:first/shared/bloc_observer.dart';
import 'package:flutter/material.dart';

void main() {
  //put run app in runzoned
  BlocOverrides.runZoned(() {
    runApp(const MyApp());
  }, blocObserver: MyBlocObserver());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeLayout(),
    );
  }
}
