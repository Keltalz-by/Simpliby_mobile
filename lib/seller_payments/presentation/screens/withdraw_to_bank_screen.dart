import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simplibuy/core/constant.dart';
import 'package:simplibuy/core/constants/route_constants.dart';
import 'package:simplibuy/core/reusable_widgets/custom_dialog.dart';
import 'package:simplibuy/core/reusable_widgets/reusable_widgets.dart';

class WithdrawToBankScreen extends StatelessWidget {
  const WithdrawToBankScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: customAppBar(
            text: "Withdrawal",
            onPressed: () {
              Get.back();
            }),
        body: Container(
          padding: const EdgeInsets.all(defaultPadding),
          child: Column(
            children: [
              Align(
                child: Text("Currency"),
                alignment: Alignment.centerLeft,
              ),
              TextField(
                  onChanged: (business) {},
                  keyboardType: TextInputType.name,
                  maxLines: 1,
                  decoration:
                      customInputDecoration(hint: null, errorText: null)),
              Padding(padding: EdgeInsets.only(top: 10)),
              Align(
                child: Text("Enter the amount you wish to withdraw"),
                alignment: Alignment.centerLeft,
              ),
              TextField(
                  onChanged: (business) {},
                  keyboardType: TextInputType.number,
                  maxLines: 1,
                  decoration:
                      customInputDecoration(hint: null, errorText: null)),
              Padding(padding: EdgeInsets.only(top: 10)),
              Align(
                child: Text("Account"),
                alignment: Alignment.centerLeft,
              ),
              TextField(
                  onChanged: (business) {},
                  keyboardType: TextInputType.name,
                  maxLines: 1,
                  decoration:
                      customInputDecoration(hint: null, errorText: null)),
              const Padding(padding: EdgeInsets.only(top: 30)),
              Text(
                "Your payment would be processed while you get credited only on saturdays ",
                style: TextStyle(fontSize: smallerTextFontSize),
              ),
              defaultButtons(
                  pressed: () {
                    showCongratulationsDialog(context);
                  },
                  text: "Add bank details")
            ],
          ),
        ));
  }

  void showCongratulationsDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true,
      barrierColor: const Color.fromARGB(255, 168, 164, 164).withOpacity(0.7),
      builder: (BuildContext context) {
        return CustomDialog(
          callback: () {
            Get.toNamed(SELLER_HOME_PAGE_ROUTE);
          },
          icon: Icons.check_circle_outline_rounded,
          buttonText: "Home",
          textDetail:
              "Your payment has been processed. You will be credited on Saturday",
          iconColor: blueColor,
        );
      },
    );
  }
}
