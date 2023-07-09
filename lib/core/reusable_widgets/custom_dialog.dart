// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:simplibuy/core/constant.dart';
import 'reusable_widgets.dart';

class CustomDialog extends StatelessWidget {
  VoidCallback callback;
  IconData icon;
  Color iconColor;
  String textDetail;
  String buttonText;

  CustomDialog({
    Key? key,
    required this.callback,
    this.icon = Icons.check_circle_outline_rounded,
    required this.buttonText,
    required this.textDetail,
    this.iconColor = blueColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Container(
          height: MediaQuery.of(context).size.height * 0.45,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(children: [
                  Icon(
                    icon,
                    color: iconColor,
                    size: 100,
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Text(
                    textDetail,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                ]),
                setButtons()
              ]),
        ));
  }

  Widget setButtons() {
    return Container(
      child: defaultButtons(
          pressed: callback, text: buttonText, size: Size(80.w, 40.h)),
    );
  }
}
