// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
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
          child: Column(children: [
            Container(
                padding: const EdgeInsets.all(15.0),
                child: Icon(
                  icon,
                  color: iconColor,
                  size: 150,
                )),
            Container(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                textDetail,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16.0,
                ),
              ),
            ),
            setButtons()
          ]),
        ));
  }

  Widget setButtons() {
    return Container(
      child: defaultButtons(
          pressed: callback, text: buttonText, size: const Size(60, 30)),
    );
  }
}
