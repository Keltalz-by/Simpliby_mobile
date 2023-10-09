import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simplibuy/core/constant.dart';
import 'package:simplibuy/core/constants/route_constants.dart';
import 'package:simplibuy/core/prefs/shared_prefs.dart';
import 'package:simplibuy/core/reusable_widgets/reusable_widgets.dart';

class SettingsScreen extends StatelessWidget {
  SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SharedPrefs.initializeSharedPrefs();
    final type = SharedPrefs.userType();
    return Scaffold(
        appBar: customAppBar(
            text: "Settings",
            onPressed: () {
              Get.back();
            }),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(defaultPadding),
            child: Column(
              children: [
                Padding(
                    padding: padding,
                    child: showSingleSetting("Account", Icons.person, () {})),
                div,
                type == TYPESELLER
                    ? Padding(
                        padding: padding,
                        child: showSingleSetting("Availability",
                            Icons.remove_red_eye_outlined, () {}))
                    : Container(),
                type == TYPESELLER ? div : Container(),
                showNotificationToggleSetting(
                    "Notification", Icons.notification_important),
                div,
                Padding(
                    padding: padding,
                    child: type == TYPEBUYER
                        ? showSingleSetting(
                            "Switch to seller", Icons.switch_account, () {
                            SharedPrefs.setUserType(TYPESELLER);
                            Get.offAllNamed(SELLER_HOME_PAGE_ROUTE);
                          })
                        : showSingleSetting(
                            "Switch to buyer", Icons.switch_account, () {
                            SharedPrefs.setUserType(TYPEBUYER);
                            Get.offAllNamed(BUYER_HOME_PAGE_ROUTE);
                          })),
                div,
                type == TYPESELLER
                    ? Padding(
                        padding: padding,
                        child: showSingleSetting("Change reservation price",
                            Icons.price_change, () {}))
                    : Container(),
                type == TYPESELLER ? div : Container(),
                type == TYPESELLER
                    ? Padding(
                        padding: padding,
                        child: showSingleSetting(
                            "Upgrade package", Icons.upgrade, () {}))
                    : Container(),
                type == TYPESELLER ? div : Container(),
                Padding(
                    padding: padding,
                    child: showSingleSetting(
                        "Help and Support", Icons.support_agent, () {})),
                div,
                Padding(
                    padding: padding,
                    child: showSingleSetting(
                        "About", Icons.help_center_rounded, () {})),
                div,
              ],
            ),
          ),
        ));
  }

  final div = const Divider(
    color: Colors.grey,
  );

  final padding = const EdgeInsets.only(top: 10, bottom: 10);

  Widget showSingleSetting(
      String title, IconData icon, VoidCallback doSomething) {
    return InkWell(
        onTap: doSomething,
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
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
        ]));
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
