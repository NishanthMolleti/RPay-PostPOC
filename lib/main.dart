// ignore_for_file: unused_element, unused_import

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:temp/splash.dart';
import 'package:flutter/services.dart';
import "package:flutter/services.dart" as s;
import "package:yaml/yaml.dart";

var loginrefresh = false;
String receiverUid = "";
String receiverName = "";
bool refresh = true;
dynamic uid;
dynamic uname;
int balance = 0;
int rakutenPoints = 0;
double cashBack = 0;
dynamic cards;

dynamic getBalance() async {
  String yamlString = await s.rootBundle.loadString("lib/config.yaml");
  links = loadYaml(yamlString);
  var url = links['host'] + links['get_balance'] + uid;
  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    balance = int.parse(response.body.toString());
    return '';
  }
}

Map links = {};

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(const MyApp());
  configLoading();
}

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.dark
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = Colors.yellow
    ..backgroundColor = Colors.green
    ..indicatorColor = Colors.yellow
    ..textColor = Colors.yellow
    ..maskColor = Colors.blue.withOpacity(0.5)
    ..userInteractions = true
    ..dismissOnTap = false;
  // ..customAnimation = CustomAnimation();
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: (BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'RPay',
        home: Splash(),
        builder: EasyLoading.init(),
      ),
      designSize: const Size(375, 812),
    );
  }
}
