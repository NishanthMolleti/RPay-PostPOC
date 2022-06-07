// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

import 'main.dart';

class qrcodepage extends StatelessWidget {
  const qrcodepage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // drawer: Navbar(),

      appBar: AppBar(
        leading: const BackButton(
          color: Colors.black,
        ),
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Image.asset(
          "assets/images/RakutenPay.jpg",
          fit: BoxFit.cover,
          height: 30,
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            QrImage(
              data: '{ "user_login_id" : "$uid" , "name": "$uname" }',
              version: QrVersions.auto,
              size: 320,
            )
          ],
        ),
      ),
    );
  }
}
