// ignore_for_file: file_names, non_constant_identifier_names, avoid_print, unused_field
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:temp/utils/loadingBar.dart';
import 'package:yaml/yaml.dart';
import 'main.dart';
import 'snack_bar.dart';
import 'myhome.dart';
import "package:flutter/services.dart" as s;

dynamic getUserfromInfo(contact) async {
  String yamlString = await s.rootBundle.loadString("lib/config.yaml");
  links = loadYaml(yamlString);
  var url = links['host'] + links['get_user'] + contact;
  var response = await http.get(Uri.parse(url));
  await Future.delayed(const Duration(seconds: 10), () {});
  if (response.statusCode == 200) {
    final jsonResponse = jsonDecode(response.body);
    balance = jsonResponse["balance"];
    uname = jsonResponse["name"];
    uid = jsonResponse["user_login_id"];
    rakutenPoints = jsonResponse["rakuten_points"];
    cashBack = jsonResponse["cash_back"];
  }
  url = links['host'] + links['get_cards'] + contact;
  final card_response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    cards = jsonDecode(card_response.body);
  }
  return jsonDecode(response.body);
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

// ignore: must_be_immutable
class _LoginScreenState extends State<LoginScreen> {
  String userId = '';
  String password = '';
  Color uidColor = Colors.black;
  Color passwordColor = Colors.black;
  LoadingBar lb = LoadingBar();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Builder(builder: (context) {
          return Center(
              child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 25.0.w, vertical: 25.0.h),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: 80.0.w, vertical: 80.0.h),
                  child: Container(
                    alignment: Alignment.center,
                    width: 200.w,
                    height: 75.h,
                    child: Image.asset(
                      "assets/images/RakutenPay.jpg",
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 5.h, left: 30.w, right: 30.w),
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: 'User ID',
                      border: const OutlineInputBorder(),
                      labelStyle: TextStyle(
                        fontSize: 25.0.sp,
                        color: uidColor,
                      ),
                      hintStyle:
                          TextStyle(color: Colors.black, fontSize: 30.0.sp),
                    ),
                    onChanged: (value) {
                      setState(() {
                        uidColor = Colors.black;
                      });
                      userId = value;
                    },
                  ),
                ),
                SizedBox(
                  height: 30.h,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 5.0.h, left: 30.w, right: 30.w),
                  child: TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                      iconColor: Colors.green,
                      labelText: 'Password',
                      border: const OutlineInputBorder(),
                      labelStyle: TextStyle(
                        fontSize: 25.0.sp,
                        color: passwordColor,
                      ),
                      hintStyle:
                          TextStyle(color: Colors.white, fontSize: 30.0.sp),
                    ),
                    onChanged: (value) {
                      setState(() {
                        passwordColor = Colors.black;
                      });
                      password = value;
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 35.0.h),
                  child: Container(
                    alignment: Alignment.bottomCenter,
                    width: 150.w,
                    height: 50.h,
                    child: FloatingActionButton.extended(
                      elevation: 1,
                      heroTag: "Hero6",
                      foregroundColor: Colors.white,
                      label: const Text("Login"), //remove the variable
                      icon: const Icon(Icons.login),
                      backgroundColor: Colors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      onPressed: () async {
                        final result = await Connectivity().checkConnectivity();
                        if (result == ConnectivityResult.none) {
                          snackBar(context,
                              'You are not connected to internet. Please check your connection');
                        } else {
                          if (userId != '' && password != '') {
                            lb.on();
                            var response = await getUserfromInfo(userId);
                            lb.off();
                            if (response['status'] == 1) {
                              loginrefresh = true;
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const MyHomePage()));
                            } else {
                              setState(() {
                                uidColor = Colors.red;
                                passwordColor = Colors.red;
                              });
                              snackBar(context, 'Entered wrong Credentials');
                            }
                          } else {
                            snackBar(context, 'Enter necessary Credentials');
                          }
                          if (userId == '') {
                            setState(() {
                              uidColor = Colors.red;
                            });
                          }
                          if (password == '') {
                            setState(() {
                              passwordColor = Colors.red;
                            });
                          }
                        }
                      },
                    ),
                  ),
                ),
                lb
              ],
            ),
          ));
        }),
      ),
    );
  }
}
