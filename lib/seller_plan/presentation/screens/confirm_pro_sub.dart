import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:simplibuy/core/constant.dart';
import 'package:simplibuy/core/constants/route_constants.dart';
import 'package:simplibuy/core/reusable_widgets/reusable_widgets.dart';

class ConfirmProSubScreen extends StatelessWidget {
  final String args = Get.arguments as String;
  ConfirmProSubScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Align(
                alignment: Alignment.topLeft,
                child: imageFromAssetsFolder(
                    width: 140.w,
                    height: 40.h,
                    path: 'assets/images/simplibuy_logo_small.png',
                    fit: BoxFit.fill)),
            const Padding(padding: EdgeInsets.only(top: 10)),
            Text(
                "You are subscribing for the Basic mothly plan. You will charged NGN $args monthly and you can cancel at anytime,",
                style: TextStyle(
                    color: blackColor,
                    fontWeight: FontWeight.normal,
                    fontSize: 18.sp)),
            Padding(padding: EdgeInsets.only(top: 30.h)),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text("Total",
                  style: TextStyle(
                      color: blackColor,
                      fontWeight: FontWeight.normal,
                      fontSize: 18.sp)),
              Text("NGN $args",
                  style: TextStyle(
                      color: blackColor,
                      fontWeight: FontWeight.normal,
                      fontSize: 18.sp))
            ]),
            const Divider(
              color: blackColor,
              thickness: 2,
            ),
            const Padding(padding: EdgeInsets.only(top: 60)),
            defaultButtons(
                pressed: () {
                  Get.toNamed(PAY_SUB_SCREEN, arguments: args);
                },
                text: "Pay now"),
            Padding(padding: EdgeInsets.only(top: 40.h)),
            Text(
                "By purchasing this plan, you agree that you are purchasing a subscription that is charged on a recurring monthly basis",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: blackColor,
                    fontWeight: FontWeight.normal,
                    fontSize: 15.sp)),
            Padding(padding: EdgeInsets.only(top: 20.h)),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                      text: "You also agree to our ",
                      style: TextStyle(
                          color: blackColor,
                          fontWeight: FontWeight.normal,
                          fontSize: 15.sp)),
                  TextSpan(
                      text: "Terms",
                      style: TextStyle(
                          color: blueColor,
                          fontWeight: FontWeight.normal,
                          fontSize: 15.sp)),
                  TextSpan(
                      text: " and ",
                      style: TextStyle(
                          color: blackColor,
                          fontWeight: FontWeight.normal,
                          fontSize: 15.sp)),
                  TextSpan(
                      text: "privacy policy",
                      style: TextStyle(
                          color: blueColor,
                          fontWeight: FontWeight.normal,
                          fontSize: 15.sp)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
