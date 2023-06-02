import 'package:flutter/material.dart';
import 'package:simplibuy/core/constant.dart';
import 'package:fluttertoast/fluttertoast.dart';

Future<bool?> errorToast(String err) {
  return Fluttertoast.showToast(
      msg: err,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0);
}

Future<bool?> normalToast(String err) {
  return Fluttertoast.showToast(
      msg: err,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.black,
      textColor: Colors.white,
      fontSize: 16.0);
}
