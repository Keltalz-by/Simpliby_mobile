import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:simplibuy/core/constant.dart';

Widget defaultButtons(
    {required VoidCallback pressed,
    required String text,
    Size size = fullWidthButtonSize}) {
  return ElevatedButton(
      onPressed: pressed,
      style: ElevatedButton.styleFrom(
          backgroundColor: blueColor,
          minimumSize: size,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.r),
          ),
          shadowColor: blueColor),
      child: Text(
        text,
        style: TextStyle(
            color: whiteColor,
            fontSize: smallTextFontSize,
            fontWeight: FontWeight.w700,
            fontFamily: appFontFamily),
      ));
}

Widget defaultLoading(BuildContext context) {
  return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Center(
        child: Image.asset(
          "assets/gifs/simpliby_loading.gif",
          height: 80.h,
          width: 80.w,
        ),
      ));
}

InputDecoration customInputDecoration(
    {String? hint, String? label, String? errorText, Widget? icon}) {
  return InputDecoration(
      hintText: hint,
      errorText: errorText,
      labelText: label,
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(width: 2.w, color: blueColor),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(width: 2.w, color: lightBlueColor),
      ),
      suffixIcon: icon,
      errorBorder: const OutlineInputBorder(
        borderSide: BorderSide(width: 2, color: errorColor),
      ));
}

Widget clickableSmallButton(
    {required VoidCallback onPressed,
    required String path,
    double height = 30,
    double width = 30.0}) {
  return Container(
      padding: const EdgeInsets.all(15.0),
      child: InkWell(
        onTap: onPressed,
        child: Image.asset(
          path,
          height: height,
          width: width,
        ),
      ));
}

Widget imageFromAssetsFolder(
    {required double width,
    required double height,
    required String path,
    double padding = 15,
    BoxFit fit = BoxFit.cover}) {
  return Container(
    padding: EdgeInsets.all(padding),
    child: Image.asset(
      path,
      height: height,
      width: width,
      fit: fit,
    ),
  );
}

Widget ordinaryAndClickableText(
    {required String text,
    required String clickableText,
    required VoidCallback onClicked}) {
  return RichText(
    text: TextSpan(
      style: TextStyle(color: blackColor, fontSize: smallerTextFontSize),
      children: <TextSpan>[
        TextSpan(text: text),
        TextSpan(
            text: clickableText,
            style: TextStyle(
                color: blueColor,
                fontSize: smallerTextFontSize,
                fontWeight: FontWeight.bold),
            recognizer: TapGestureRecognizer()..onTap = onClicked),
      ],
    ),
  );
}

PreferredSizeWidget customAppBar(
    {required String text,
    required VoidCallback onPressed,
    List<Widget>? actions}) {
  return AppBar(
    elevation: 0.0,
    title: Text(
      text,
      style: TextStyle(color: blackColor, fontSize: smallTextFontSize),
    ),
    backgroundColor: Colors.transparent,
    actions: actions,
    automaticallyImplyLeading: false,
    leading: IconButton(
      onPressed: onPressed,
      icon: const Icon(
        Icons.arrow_back_ios,
        color: blackColor,
        size: 15.0,
      ),
    ),
  );
}

Widget bottmNavItemWithIcon(
    {required IconData data,
    required String text,
    required VoidCallback onClick}) {
  return Column(
    children: [
      Icon(data, color: blueColor, size: 17),
      const Padding(padding: EdgeInsets.only(left: 5.0)),
      RichText(
          text: TextSpan(
              text: text,
              style: TextStyle(
                  color: blueColor,
                  fontSize: smallerTextFontSize,
                  fontWeight: FontWeight.bold),
              recognizer: TapGestureRecognizer()..onTap = onClick))
    ],
  );
}

Widget noInternetConnection(BuildContext context) {
  return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 35,
      child: Card(
        color: Colors.red,
        child: Row(children: [
          Image.asset('assets/images/no_nwk_auth.png'),
          const Padding(padding: EdgeInsets.only(left: 4)),
          Text(
            'No internet connection, please try again',
            style: TextStyle(color: whiteColor, fontSize: smallerTextFontSize),
          )
        ]),
      ));
}
