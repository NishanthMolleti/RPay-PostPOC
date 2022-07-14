import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:temp/myhome.dart';
import 'loginScreen.dart';
import 'main.dart';
import 'package:temp/utils/loadingBar.dart';

dynamic finalUid;

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);
  @override
  _Splash createState() => _Splash();
}

class _Splash extends State<Splash> {
  LoadingBar lb = LoadingBar();
  @override
  void initState() {
    super.initState();
    getValidationData().whenComplete(() async {
      if (finalUid == null) {
        Timer(const Duration(seconds: 3), () {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => LoginScreen()));
        });
      } else {
        lb.on();
        var response = await getUserfromInfo(finalUid);
        loginrefresh = true;
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const MyHomePage()));
        lb.off();
      }
    });
  }

  Future getValidationData() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    dynamic uid = sharedPreferences.getString("uid");
    setState(() {
      finalUid = uid;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                padding:
                    EdgeInsets.only(left: 120.w, right: 120.w, bottom: 30.h),
                color: const Color.fromARGB(0, 216, 36, 36),
                child: Image.asset(
                  "assets/images/RakutenPay.jpg",
                  fit: BoxFit.contain,
                ),
              ),
              Text("Let's  get  started",
                  style:
                      TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold)),
              const SizedBox(
                height: 10,
              ),
              lb
            ]),
      ),
    );
  }
}


// Scaffold(
//       body: Center(
//         child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               Container(
//                 padding:
//                     const EdgeInsets.only(left: 120, right: 120, bottom: 30),
//                 color: const Color.fromARGB(0, 216, 36, 36),
//                 child: Image.asset(
//                   "assets/images/RakutenPay.jpg",
//                   fit: BoxFit.contain,
//                 ),
//               ),
//               const Text("Let's  get  started",
//                   style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
//             ]),
//       ),
//     );
//