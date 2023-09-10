import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:simplibuy/core/constants/route_constants.dart';
import 'package:simplibuy/core/prefs/shared_prefs.dart';
import 'package:simplibuy/core/reusable_widgets/reusable_widgets.dart';
import 'package:simplibuy/core/constant.dart';
import 'package:get/get.dart';

class UserType extends StatelessWidget {
  const UserType({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: imageFromAssetsFolder(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.83,
                  padding: 0,
                  path: 'assets/on_boarding/on_boarding.png')),
          Positioned(bottom: 20.h, child: details(context))
        ],
      ),
    );
  }

  Widget details(BuildContext context) {
    return Column(
      children: [
        imageFromAssetsFolder(
            width: 120.w,
            height: 35.h,
            path: 'assets/images/simplibuy_logo_small.png',
            fit: BoxFit.fill),
        Container(
            width: 380.w,
            padding: const EdgeInsets.all(10),
            alignment: Alignment.topCenter,
            child: Text(
                "Reserve, pay and pickup your item from your favorite store",
                maxLines: 2,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: whiteColor,
                    fontWeight: FontWeight.bold,
                    fontSize: smallTextFontSize))),
        Text("Sign up",
            style: TextStyle(
                color: whiteColor,
                fontWeight: FontWeight.bold,
                fontSize: smallTextFontSize)),
        SizedBox(
          height: 15.h,
        ),
        SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                start(context, () async {
                  await SharedPrefs.initializeSharedPrefs();
                  if (SharedPrefs.isUserVerified() == true) {
                    SharedPrefs.setUserType(TYPEBUYER)
                        .then((value) => {Get.toNamed(BUYER_HOME_PAGE_ROUTE)});
                  } else {
                    SharedPrefs.setUserType(TYPEBUYER)
                        .then((value) => {Get.toNamed(LOGIN_ROUTE)});
                  }
                }, "assets/on_boarding/on_buying.png", "Start Buying"),
                start(context, () async {
                  await SharedPrefs.initializeSharedPrefs();
                  if (SharedPrefs.isUserVerified() == true) {
                    SharedPrefs.setUserType(TYPESELLER)
                        .then((value) => {Get.toNamed(SELLER_HOME_PAGE_ROUTE)});
                  } else {
                    SharedPrefs.setUserType(TYPESELLER)
                        .then((value) => {Get.toNamed(LOGIN_ROUTE)});
                  }
                }, "assets/on_boarding/on_selling.png", "Start Selling"),
              ],
            ))
      ],
    );
  }

  Widget start(
      BuildContext context, VoidCallback onPressed, String file, String text) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.4,
      padding: EdgeInsets.symmetric(vertical: 5.h),
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          color: Color.fromARGB(255, 219, 216, 216),
          blurRadius: 10.r,
          spreadRadius: 5.0,
          offset: Offset(0.0, 5.0),
        ),
      ], borderRadius: BorderRadius.circular(15.r), color: whiteColor),
      child: InkWell(
          onTap: () {
            onPressed();
          },
          child: Column(
            children: [
              imageFromAssetsFolder(
                  width: MediaQuery.of(context).size.width * 0.4,
                  height: 110.h,
                  padding: 0,
                  path: file),
              SizedBox(
                height: 3.h,
              ),
              Text(
                text,
                style: TextStyle(
                  fontSize: 18.sp,
                ),
              ),
              SizedBox(
                height: 10.h,
              )
            ],
          )),
    );
  }

  Widget retailerOption() {
    return defaultButtons(
        pressed: () {
          Get.toNamed(LOGIN_ROUTE);
        },
        text: "Retailer");
  }

  Widget optionCard(String imgUrl, String text) {
    return defaultButtons(
        pressed: () {
          Get.toNamed(SIGNUP_ROUTE);
        },
        text: "Buyer");
  }
}
