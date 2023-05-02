// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:simplibuy/core/constant.dart';

import 'reusable_widgets.dart';

class CustomLoadingDialog extends StatelessWidget {
  CustomLoadingDialog({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Container(
            height: MediaQuery.of(context).size.height * 0.25,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                color: Colors.transparent),
            child: Center(
              child: Image.asset(
                "assets/gifs/simpliby_loading.gif",
                height: 80.0,
                width: 80.0,
              ),
            )));
  }
}
