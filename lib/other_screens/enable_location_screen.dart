import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:simplibuy/core/reusable_widgets/reusable_widgets.dart';
import 'package:simplibuy/core/constant.dart';

class EnableLocation extends StatelessWidget {
  const EnableLocation({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      margin: const EdgeInsets.all(defaultPadding),
      child: Center(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 50.0),
            ),
            enableLocationText(),
            const Padding(
              padding: EdgeInsets.only(top: 100.0),
            ),
            locationImage(),
            const Padding(
              padding: EdgeInsets.only(top: 100.0),
            ),
            enableLocationNotice(),
            enableLocationNotice2(),
            const Padding(
              padding: EdgeInsets.only(top: defaultPadding),
            ),
            enableButton(),
            const Padding(
              padding: EdgeInsets.only(top: 10.0),
            ),
            notNow(() {}),
          ],
        ),
      ),
    ));
  }

  Widget enableLocationText() {
    return Text("Enable Location",
        style: TextStyle(color: blueColor, fontSize: smallTextFontSize));
  }

  Widget locationImage() {
    return Image.asset(
      'assets/images/location_symbol.png',
      height: 120.0,
      width: 120.0,
    );
  }

  Widget notNow(VoidCallback onClicked) {
    return RichText(
        text: TextSpan(
            text: "Not now",
            style: TextStyle(
                color: blackColor,
                fontSize: smallTextFontSize,
                fontWeight: FontWeight.normal),
            recognizer: TapGestureRecognizer()..onTap = onClicked));
  }

  Widget enableLocationNotice() {
    return Text("This app requires your permission,",
        style: TextStyle(color: blackColor, fontSize: smallTextFontSize));
  }

  Widget enableLocationNotice2() {
    return Text("Allow Simpliby access your location?",
        style: TextStyle(color: blackColor, fontSize: smallTextFontSize));
  }

  Widget enableButton() {
    return defaultButtons(
        pressed: () {}, text: "Enable", size: mediumWidthButtonSize);
  }
}
