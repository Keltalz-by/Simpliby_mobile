import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:simplibuy/core/constant.dart';
import 'package:simplibuy/core/constants/route_constants.dart';
import 'package:simplibuy/core/prefs/shared_prefs.dart';
import 'package:simplibuy/core/reusable_widgets/reusable_widgets.dart';

class AccountCreationSuccess extends StatelessWidget {
  const AccountCreationSuccess({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Container(
        padding: const EdgeInsets.all(defaultPadding),
        alignment: Alignment.center,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/images/bubble.png"),
              SizedBox(
                height: 20.h,
              ),
              Text(
                "Congratulations!",
                style: TextStyle(
                    color: blackColor,
                    fontWeight: FontWeight.w500,
                    fontSize: 30.sp),
              ),
              SizedBox(
                height: 20.h,
              ),
              Text(
                "Your account has successfully been created",
                style: TextStyle(
                    color: blackColor,
                    fontWeight: FontWeight.w500,
                    fontSize: smallTextFontSize),
              ),
              SizedBox(
                height: 90.h,
              ),
              Align(
                  alignment: Alignment.topRight,
                  child: defaultButtons(
                      pressed: () {
                        navigate();
                      },
                      text: "Next",
                      size: Size(120.w, 50.h)))
            ],
          ),
        ),
      ),
    ));
  }

  navigate() async {
    await SharedPrefs.initializeSharedPrefs();
    if (SharedPrefs.userType() == TYPEBUYER) {
      Get.offNamed(LOGIN_ROUTE);
    } else {
      Get.offNamed(BUSINESS_DETAILS_SCREEN);
    }
  }
}
