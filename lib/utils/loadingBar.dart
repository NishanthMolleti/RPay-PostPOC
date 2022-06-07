// ignore_for_file: use_key_in_widget_constructors, must_be_immutable, file_names, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingBar extends StatefulWidget {
  _LoadingBarState state = _LoadingBarState();

  void on() {
    state.on();
  }

  void off() {
    state.off();
  }

  bool getIsLoading() {
    return state.isLoading;
  }

  @override
  State<LoadingBar> createState() => state;
}

class _LoadingBarState extends State<LoadingBar> {
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void deactivate() {
    super.deactivate();
  }

  void on() {
    setState(() {
      isLoading = true;
    });
  }

  void off() {
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? SpinKitFadingCircle(
            color: Colors.red,
            size: 50.0,
          )
        : const Text("");
  }
}
