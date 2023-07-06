import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:simplibuy/core/constant.dart';
import 'package:simplibuy/core/constants/route_constants.dart';
import 'package:simplibuy/core/reusable_widgets/reusable_widgets.dart';

class PlanScreen extends StatelessWidget {
  PlanScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            imageFromAssetsFolder(
                width: 140.w,
                height: 40.h,
                path: 'assets/images/simplibuy_logo_small.png',
                fit: BoxFit.fill),
            const Padding(padding: EdgeInsets.only(top: 10)),
            Text("Want to reach out to more buyers and earn more?",
                style: TextStyle(
                    color: blackColor,
                    fontWeight: FontWeight.bold,
                    fontSize: smallTextFontSize)),
            const Padding(padding: EdgeInsets.only(top: 10)),
            Text("Select a suitable subscription plan",
                style:
                    TextStyle(color: blueColor, fontSize: smallTextFontSize)),
            const Padding(padding: EdgeInsets.only(top: 10)),
            singlePlanOption(context, "FREE", blueColor, freePts, () {
              Get.toNamed(SELLER_HOME_PAGE_ROUTE);
            }),
            const Padding(padding: EdgeInsets.only(top: 10)),
            singlePlanOption(context, "PRO", Colors.red, paidPts, () {
              Get.toNamed(PRO_PLAN_CHOICE_SCREEN);
            })
          ],
        ),
      ),
    );
  }

  final freePts = ["Max of 30 buyers per week", "Free"];
  final paidPts = [
    "Unlimited no. of buyers",
    "Initiate chat with buyers",
    "Advertise products",
    "N5,000 monthly"
  ];

  Widget singlePlanOption(BuildContext context, String planType, Color color,
      List<String> pts, VoidCallback onClick) {
    return GestureDetector(
      onTap: () {
        onClick();
      },
      child: Container(
          width: MediaQuery.of(context).size.width,
          // height: 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(
              color: color,
            ),
            color: Colors.white,
            boxShadow: const [
              BoxShadow(
                color: Color.fromARGB(255, 207, 206, 206),
                blurRadius: 4,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: 80.w,
                  height: 80.h,
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          planType,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 17.sp,
                              fontWeight: FontWeight.bold),
                        ),
                        const Text(
                          'Plan',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ]),
                ),
                SizedBox(width: 16.w),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: pts
                        .map((element) => Text(
                              '• $element',
                              style: TextStyle(fontSize: smallTextFontSize),
                            ))
                        .toList(), // Convert the list of widgets to a list and pass it to children property
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
