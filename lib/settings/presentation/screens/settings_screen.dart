import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simplibuy/core/constant.dart';
import 'package:simplibuy/core/reusable_widgets/reusable_widgets.dart';

class SettingsScreen extends StatelessWidget {
  SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
          text: "Settings",
          onPressed: () {
            Get.back();
          }),
      body: SingleChildScrollView(child: Container(
        padding: const EdgeInsets.all(defaultPadding),
        child: Column(
          children: [
            Padding(
                padding: padding,
                child: showSingleSetting("Account", Icons.person)),
            div,
            Padding(
                padding: padding,
                child: showSingleSetting(
                    "Availability", Icons.remove_red_eye_outlined)),
            div,
            showNotificationToggleSetting(
                "Notification", Icons.notification_important),
            div,
            Padding(
                padding: padding,
                child:
                    showSingleSetting("Switch to buyer", Icons.switch_account)),
            div,
            Padding(
                padding: padding,
                child: showSingleSetting(
                    "Change reservation price", Icons.price_change)),
            div,
            Padding(
                padding: padding,
                child: showSingleSetting("Upgrade package", Icons.upgrade)),
            div,
            Padding(
                padding: padding,
                child:
                    showSingleSetting("Help and Support", Icons.support_agent)),
            div,
            Padding(
                padding: padding,
                child: showSingleSetting("About", Icons.help_center_rounded)),
            div,
          ],
        ),
      ),
     ) );
  }

  final div = const Divider(
    color: Colors.grey,
  );

  final padding = const EdgeInsets.only(top: 10, bottom: 10);

  Widget showSingleSetting(String title, IconData icon) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Row(
        children: [
          Icon(
            icon,
            color: blueColor,
          ),
          const Padding(padding: EdgeInsets.only(left: 10)),
          Text(
            title,
            style: TextStyle(fontSize: smallTextFontSize),
          ),
        ],
      ),
      const Align(
        child: Icon(
          Icons.arrow_forward_ios,
          color: blackColor,
          size: 15,
        ),
        alignment: Alignment.topRight,
      ),
    ]);
  }

  Widget showNotificationToggleSetting(String title, IconData icon) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Row(
        children: [
          Icon(
            icon,
            color: blueColor,
          ),
          const Padding(padding: EdgeInsets.only(left: 10)),
          Text(
            title,
            style: TextStyle(fontSize: smallTextFontSize),
          ),
        ],
      ),
      Align(
        child: Switch(value: true, onChanged: (bool value) {}),
        alignment: Alignment.topRight,
      ),
    ]);
  }
}
