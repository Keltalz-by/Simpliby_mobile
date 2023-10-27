import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:simplibuy/core/constants/string_constants.dart';
import 'package:simplibuy/core/prefs/shared_prefs.dart';
import 'dart:async';
import '../core/constants/route_constants.dart';
import '../core/reusable_widgets/reusable_widgets.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    SharedPrefs.initializeSharedPrefs().then((value) {
      final uid = SharedPrefs.userId();
      final type = SharedPrefs.userType();
      final isVerified = SharedPrefs.isUserVerified();
      print("uid is $uid type is $type isverified is $isVerified");
      Timer(const Duration(seconds: 2), () async {
        if (SharedPrefs.isUserFirstTime() == false) {
          Get.toNamed(USER_FIRST_TIME);
          SharedPrefs.setUserFirstTimeStatus(true);
        } else {
          refreshUserToken(type);
        }
      });
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

  refreshUserToken(String type) async {
    var url = Uri.parse('${BASE_URL}auth/refresh');
    var res = await http.get(url);
    final status = json.decode(res.body);
    print("This is the status $status");
    if (status['success'] == true) {
      if (type == TYPEBUYER) {
        Get.offNamed(BUYER_HOME_PAGE_ROUTE);
      } else {
        Get.offNamed(SELLER_HOME_PAGE_ROUTE);
      }
    } else {
      Get.offNamed(LOGIN_ROUTE);
    }
  }
}
