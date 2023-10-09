import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:simplibuy/core/prefs/shared_prefs.dart';
import 'dart:async';

import '../core/constants/route_constants.dart';
import '../core/reusable_widgets/reusable_widgets.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () async {
      await SharedPrefs.initializeSharedPrefs();
      if (SharedPrefs.isUserFirstTime() == false) {
        Get.toNamed(USER_FIRST_TIME);
        SharedPrefs.setUserFirstTimeStatus(true);
      } else {
        if (SharedPrefs.userType() == TYPESELLER) {
          if (SharedPrefs.userId().isEmpty ||
              SharedPrefs.isUserVerified() == false) {
            Get.offNamed(LOGIN_ROUTE);
          } else {
            Get.offNamed(SELLER_HOME_PAGE_ROUTE);
          }
        }
        if (SharedPrefs.userType() == TYPEBUYER) {
          if (SharedPrefs.userId().isEmpty ||
              SharedPrefs.isUserVerified() == false) {
            Get.offNamed(LOGIN_ROUTE);
          } else {
            Get.offNamed(BUYER_HOME_PAGE_ROUTE);
          }
        } else {
          Get.offNamed(USER_TYPE);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: imageFromAssetsFolder(
                width: 180.w,
                height: 150.h,
                fit: BoxFit.contain,
                path: 'assets/images/simpliby_logo.png')));
  }
}
