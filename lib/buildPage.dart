// ignore_for_file: file_names, prefer_const_constructors, unused_import
import 'package:flutter/material.dart';
import 'package:temp/buildPayments.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:temp/buildSheet.dart';
import 'package:temp/topup.dart';

import 'buildBalance.dart';
import 'buildCard.dart';
import 'buildIndicator.dart';

Widget buildPage(
  BuildContext context,
  dynamic card,
  int activeIndex,
) =>
    Container(
      margin: EdgeInsets.symmetric(horizontal: 15.w),
      child: Column(children: [
        // cards
        GestureDetector(
            onTap: () {
              showModalBottomSheet(
                  isScrollControlled: true,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                        top: Radius.circular(35.r),
                        bottom: Radius.circular(35.r)),
                  ),
                  context: context,
                  builder: (context) => bottomSheet(context,card));
            },
            child: buildCard(card, context)),
        //balance
        GestureDetector(
            onTap: () {
              showModalBottomSheet(
                  isScrollControlled: true,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                        top: Radius.circular(35.r),
                        bottom: Radius.circular(35.r)),
                  ),
                  context: context,
                  builder: (context) => Container(
                      margin: EdgeInsets.symmetric(
                          vertical: 15.0.h, horizontal: 15.w),
                      child: topUp(context)));
            },
            child: buildBalance(activeIndex)),
      ]),
    );
