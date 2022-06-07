// ignore_for_file: unused_element, unused_import

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:temp/splash.dart';
import 'package:flutter/services.dart';
import "package:flutter/services.dart" as s;
import 'package:temp/utils/loadingBar.dart';
import "package:yaml/yaml.dart";

// global variables
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
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // EasyLoading.init();
    return ScreenUtilInit(
      builder: (BuildContext context) => const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'RPay',
        home: Splash(),
      ),
      designSize: const Size(375, 812),
    );
  }
}
