import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simplibuy/core/constant.dart';
import 'package:simplibuy/core/constants/route_constants.dart';
import 'package:simplibuy/core/reusable_widgets/custom_dialog.dart';
import 'package:simplibuy/core/reusable_widgets/reusable_widgets.dart';

class AddBankScreen extends StatelessWidget {
  const AddBankScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: customAppBar(
            text: "Add Bank",
            onPressed: () {
              Get.back();
            }),
        body: Container(
          padding: const EdgeInsets.all(defaultPadding),
          child: Column(
            children: [
              Text(
                "Upload te details of the bank account you would like to receive payments into. ",
                style: TextStyle(fontSize: smallTextFontSize),
              ),
              const Padding(padding: EdgeInsets.only(top: 10)),
              const Align(
                child: Text("Add bank"),
                alignment: Alignment.centerLeft,
              ),
              TextField(
                  onChanged: (business) {},
                  keyboardType: TextInputType.name,
                  maxLines: 1,
                  decoration:
                      customInputDecoration(hint: null, errorText: null)),
              const Padding(padding: EdgeInsets.only(top: 10)),
              const Align(
                child: Text("Account number"),
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
                child: Text("Account name"),
                alignment: Alignment.centerLeft,
              ),
              TextField(
                  onChanged: (business) {},
                  keyboardType: TextInputType.name,
                  maxLines: 1,
                  decoration:
                      customInputDecoration(hint: null, errorText: null)),
              const Padding(padding: EdgeInsets.only(top: 30)),
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
            Get.toNamed(SELLER_PRODUCT_CATEGORIES);
          },
          icon: Icons.check_circle_outline_rounded,
          buttonText: "Start selling",
          textDetail: "You have successfully added your bank details",
          iconColor: blueColor,
        );
      },
    );
  }
}
