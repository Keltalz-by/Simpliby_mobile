import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simplibuy/core/constant.dart';
import 'package:simplibuy/core/constants/route_constants.dart';
import 'package:simplibuy/core/reusable_widgets/reusable_widgets.dart';

class ProPlanScreen extends StatelessWidget {
  ProPlanScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
          text: "",
          onPressed: () {
            Get.back();
          }),
      body: Container(
        padding: const EdgeInsets.only(
            top: 5,
            left: defaultPadding,
            right: defaultPadding,
            bottom: defaultPadding),
        alignment: Alignment.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text("Get more flexibility with premium",
                style: TextStyle(
                    color: blackColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 25)),
            const Padding(padding: EdgeInsets.only(top: 10)),
            const Text("Select a plan",
                style: TextStyle(
                    color: blackColor,
                    fontWeight: FontWeight.normal,
                    fontSize: 18)),
            const Padding(padding: EdgeInsets.only(top: 30)),
            singlePlanOption(context)
          ],
        ),
      ),
    );
  }

  Widget singlePlanOption(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.55,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: lightBlueColor.withAlpha(60)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const Text("PRO",
                style: TextStyle(
                    color: blackColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 24)),
            const Padding(padding: EdgeInsets.only(top: 5)),
            const Text(
                "Use the basic plan to start selling to a larger audience and much more",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: blackColor,
                    fontWeight: FontWeight.normal,
                    fontSize: 16)),
            const Padding(padding: EdgeInsets.only(top: 5)),
            const Text("Switch plans >",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: blueColor,
                    fontWeight: FontWeight.normal,
                    fontSize: 16)),
            const Padding(padding: EdgeInsets.only(top: 15)),
            defaultButtons(
                pressed: () {
                  Get.toNamed(CONFIRM_PRO_SUB_SCREEN, arguments: "2,000");
                },
                text: "Subscribe Monthly N2,000",
                size: Size(MediaQuery.of(context).size.width * 0.7, 70)),
            const Padding(padding: EdgeInsets.only(top: 15)),
            defaultButtons(
                pressed: () {
                  Get.toNamed(CONFIRM_PRO_SUB_SCREEN, arguments: "10,000");
                },
                text: "Subscribe Every 6 months N10,000",
                size: Size(MediaQuery.of(context).size.width * 0.7, 70)),
            const Padding(padding: EdgeInsets.only(top: 15)),
            defaultButtons(
                pressed: () {
                  Get.toNamed(CONFIRM_PRO_SUB_SCREEN, arguments: "19,500");
                },
                text: "Subscribe yearly N19,500",
                size: Size(MediaQuery.of(context).size.width * 0.7, 70)),
          ],
        ),
      ),
    );
  }
}
