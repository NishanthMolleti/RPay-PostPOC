// ignore_for_file: file_names, non_constant_identifier_names
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:temp/SearchPage.dart';
import 'package:temp/main.dart';
import 'package:temp/qrcodepage.dart';

import '../loginScreen.dart';

class Navbar extends StatelessWidget {
  const Navbar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: SafeArea(
      child: Container(
        child: Column(
          children: <Widget>[
            Row(
              //change to row again
              children: <Widget>[
                Row(
                  children: [
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        style: TextButton.styleFrom(primary: Colors.black),
                        child: const Icon(
                          Icons.arrow_back_ios,
                        )),
                  ],
                ),
                const Spacer(),
                Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      TextButton(
                        onPressed: () {},
                        style: TextButton.styleFrom(primary: Colors.black),
                        child: const Icon(Icons.notifications_none_outlined),
                      ),
                    ]),
              ],
            ),
            account_Balance_Widget("Prepaid debit", "\$" + balance.toString()),
            drawDivider(),
            account_Balance_Widget("Installments", "\$0"),
            drawDivider(),
            GestureDetector(
                onTap: (() {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SearchPage()),
                  );
                }),
                child: NamedTextButton("Send Money")),
            drawDivider(),
            account_Balance_Widget("Cash Back", "\$ $cashBack"),
            drawDivider(),
            account_Balance_Widget(
                "Rakuten Points", rakutenPoints.toString() + "P"),
            drawDivider(),
            GestureDetector(
                onTap: (() {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const qrcodepage()),
                  );
                }),
                child: NamedTextButton("My QR Code")),
            drawDivider(),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  NamedTextButton("Support"),
                  drawDivider(),
                  GestureDetector(
                      onTap: (() async {
                        final SharedPreferences sharedPreferences =
                            await SharedPreferences.getInstance();
                        sharedPreferences.remove('uid');
                        loginrefresh = false;
                        receiverUid = "";
                        receiverName = "";
                        refresh = true;
                        uid = '';
                        uname = '';
                        balance = 0;
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    const LoginScreen()),
                            (Route<dynamic> route) => false);
                      }),
                      child: NamedTextButton("Log out")),
                  drawDivider(),
                  SizedBox(
                    height: 53.h,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    ));
  }
}

Widget account_Balance_Widget(String acc_type, String balance) {
  return Padding(
    padding: EdgeInsets.only(top: 12.h, left: 16.w, bottom: 12.h),
    child: Row(
      children: <Widget>[
        Text(
          acc_type + " - ",
          style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 17.sp,
              fontFamily: '.SF Pro Text'),
        ),
        Text(
          balance,
          style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 17.sp,
              fontFamily: '.SF Pro Text',
              color: Colors.blue),
        ),
      ],
    ),
  );
}

Widget NamedTextButton(String text) {
  return Container(
    color: Colors.white.withOpacity(0.01),
    width: double.infinity,
    padding: EdgeInsets.only(top: 12.h, left: 16.w, bottom: 12.h),
    child: Row(
      children: <Widget>[
        Text(
          text,
          style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 17.sp,
              fontFamily: '.SF Pro Text'),
        ),
      ],
    ),
  );
}

Widget drawDivider() {
  return Divider(
    thickness: 1,
    indent: 16.w,
    height: 1.w,
  );
}
