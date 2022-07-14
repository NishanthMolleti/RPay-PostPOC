import 'dart:convert';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:temp/acoount_screens/cashBack.dart';
import 'package:temp/myhome.dart';
import 'package:temp/acoount_screens/rakutenPoints.dart';
import '../main.dart';

dynamic jsonres;
dynamic redeem_cb_post(amount) async {
  Map data = {"uid": uid.toString(), "redeem_amount": int.parse(amount)};
  Map<String, String> headers = {
    'Content-Type': 'application/json; charset=UTF-8',
  };
  var body = jsonEncode(data);
  var url = links['host'] + links['redeem_cb'];
  // await Future.delayed(const Duration(seconds: 5), () {});
  var response = await http.post(Uri.parse(url), body: body, headers: headers);
  jsonres = json.decode(response.body.toString());
  url = links['host'] + links['update_cb'] + uid.toString();
  print(url);
  response = await http.get(Uri.parse(url));
  cashBack = response.body.toString();
  url = links['host'] + links['update_balance'] + uid.toString();
  response = await http.get(Uri.parse(url));
  balance = response.body.toString();
  return "";
}

class CBScreen extends StatefulWidget {
  const CBScreen({Key? key}) : super(key: key);

  @override
  State<CBScreen> createState() => _CBScreenState();
}

class _CBScreenState extends State<CBScreen> {
  final _textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: const Text("Cash Back Redeem"),
          backgroundColor: Colors.transparent),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/image.jpeg"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(35.0),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Container(
                alignment: Alignment.center,
                child: TextFormField(
                  controller: _textEditingController,
                  style: GoogleFonts.roboto(color: Colors.white, fontSize: 24),
                  decoration: const InputDecoration(
                      label: Center(
                        child: Text("Amount"),
                      ),
                      labelStyle: TextStyle(
                        color: Colors.white,
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      fillColor: Colors.transparent,
                      filled: true),
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _textEditingController.clear();
                        _textEditingController.text = '10';
                      });
                    },
                    child: Container(
                      width: 70,
                      height: 40,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.white,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Center(
                          child: Text("\$10",
                              style: TextStyle(
                                  fontSize: 16, color: Colors.white))),
                    ),
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _textEditingController.clear();
                        _textEditingController.text = '50';
                      });
                    },
                    child: Container(
                      width: 70,
                      height: 40,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.white,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Center(
                          child: Text("\$50",
                              style: TextStyle(
                                  fontSize: 16, color: Colors.white))),
                    ),
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _textEditingController.clear();
                        _textEditingController.value =
                            const TextEditingValue(text: '100');
                      });
                    },
                    child: Container(
                      width: 70,
                      height: 40,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.white,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Center(
                          child: Text("\$100",
                              style: TextStyle(
                                  fontSize: 16, color: Colors.white))),
                    ),
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _textEditingController.clear();
                        _textEditingController.value =
                            const TextEditingValue(text: '500');
                      });
                    },
                    child: Container(
                      width: 70,
                      height: 40,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.white,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Center(
                          child: Text("\$500",
                              style: TextStyle(
                                  fontSize: 16, color: Colors.white))),
                    ),
                  )
                ],
              ),
              SizedBox(height: 20),
              FloatingActionButton.extended(
                onPressed: () async {
                  print("hi");
                  var amount = _textEditingController.text;
                  if (false) {
                    print("No");
                  } else {
                    await redeem_cb_post(amount);
                    myHomePageState.setState(() {});
                    cashBackScreenState.setState(() {});
                    if (jsonres['status'] == 0) {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return Center(
                              child: Material(
                                type: MaterialType.transparency,
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.r),
                                      color: Colors.white),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 15.w, vertical: 15.h),
                                  width:
                                      MediaQuery.of(context).size.width * 0.85,
                                  height:
                                      MediaQuery.of(context).size.height * 0.55,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Text("Please try after some time",
                                          style: TextStyle(
                                            color: Colors.red,
                                            fontSize: 25,
                                          ))
                                    ],
                                  ),
                                ),
                              ),
                            );
                          });
                    } else if ((jsonres['status'] == 1)) {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return Center(
                              child: Material(
                                type: MaterialType.transparency,
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.r),
                                      color: Colors.white),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 15.w, vertical: 15.h),
                                  width:
                                      MediaQuery.of(context).size.width * 0.85,
                                  height:
                                      MediaQuery.of(context).size.height * 0.55,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Text("Redeem Success",
                                          style: TextStyle(
                                            color: Colors.green,
                                            fontSize: 25,
                                          ))
                                    ],
                                  ),
                                ),
                              ),
                            );
                          });
                    } else if ((jsonres['status'] == 2)) {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return Center(
                              child: Material(
                                type: MaterialType.transparency,
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.r),
                                      color: Colors.white),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 15.w, vertical: 15.h),
                                  width:
                                      MediaQuery.of(context).size.width * 0.85,
                                  height:
                                      MediaQuery.of(context).size.height * 0.55,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Text("Exceeded Limit",
                                          style: TextStyle(
                                            color: Colors.red,
                                            fontSize: 25,
                                          ))
                                    ],
                                  ),
                                ),
                              ),
                            );
                          });
                    }
                  }
                },
                label: const Text('Redeem'),
                backgroundColor: Color.fromARGB(255, 171, 172, 184),
              )
            ]),
          ),
        ],
      ),
    );
  }
}
