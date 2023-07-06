import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:simplibuy/core/constant.dart';

PreferredSizeWidget sellerhomeAppBar(
    {required String text,
    required String name,
    required VoidCallback onPressed}) {
  return AppBar(
      elevation: 0,
      iconTheme: const IconThemeData(color: blackColor),
      leading: Padding(
          padding: EdgeInsets.only(left: 20.w),
          child: GestureDetector(
            child: CircleAvatar(
              radius: 15,
              backgroundImage: AssetImage(
                  'assets/images/shoprite_small.png'), // Replace with your asset path
            ),
          )),
      title: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              text,
              style: TextStyle(color: blackColor, fontSize: smallTextFontSize),
            ),
            Text(
              name,
              style: TextStyle(color: blackColor, fontSize: smallTextFontSize),
            )
          ]),
      backgroundColor: whiteColor,
      actions: [
        Padding(
            padding: EdgeInsets.only(right: 20.w),
            child: GestureDetector(
                onTap: onPressed,
                child: Container(
                    padding: EdgeInsets.all(6),
                    decoration: ShapeDecoration(shadows: [
                      BoxShadow(
                          color: Colors.grey.withAlpha(150),
                          offset: Offset(1.0, 1.0),
                          blurRadius: 10.r)
                    ], color: Colors.white, shape: CircleBorder()),
                    child: Icon(Icons.notifications))))
      ]);
}
