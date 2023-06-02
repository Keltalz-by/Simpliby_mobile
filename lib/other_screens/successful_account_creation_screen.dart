import 'package:flutter/material.dart';
import 'package:simplibuy/core/reusable_widgets/reusable_widgets.dart';
import 'package:simplibuy/core/constant.dart';

class AccountSuccess extends StatelessWidget {
  const AccountSuccess({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      margin: const EdgeInsets.all(defaultPadding),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            checkImage(),
            notice(),
            const Padding(
              padding: EdgeInsets.only(top: 30.0),
            ),
            startBuyingOrSelling(),
          ],
        ),
      ),
    ));
  }

  Widget checkImage() {
    return const Icon(
      Icons.check_circle,
      color: blueColor,
      shadows: [Shadow(color: lightBlueColor)],
      size: 170.0,
    );
  }

  Widget notice() {
    return Text("Hurray, your account is now live!",
        style: TextStyle(color: blackColor, fontSize: smallTextFontSize));
  }

  Widget startBuyingOrSelling() {
    return defaultButtons(
        pressed: () {}, text: "Start Buying", size: const Size(150.0, 50.0));
  }
}
