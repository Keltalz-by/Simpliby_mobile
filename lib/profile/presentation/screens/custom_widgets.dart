import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constant.dart';
import '../../../core/reusable_widgets/reusable_widgets.dart';

Widget inputFieldProfile(
    String title, Function(String) onChanged, String error, String? hint) {
  return Column(children: [
    Align(
      alignment: Alignment.bottomLeft,
      child: Text(title,
          style: TextStyle(color: blackColor, fontSize: smallerTextFontSize)),
    ),
    Obx(() {
      return TextField(
          onChanged: onChanged,
          keyboardType: TextInputType.emailAddress,
          decoration: customInputDecoration(hint: hint, errorText: error));
    })
  ]);
}
