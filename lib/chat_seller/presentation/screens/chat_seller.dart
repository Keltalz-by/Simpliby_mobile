import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:simplibuy/core/constant.dart';
import 'package:simplibuy/core/reusable_widgets/reusable_widgets.dart';

class ChatSeller extends StatelessWidget {
  const ChatSeller({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
          text: "Chat to order",
          onPressed: () {
            Get.back();
          }),
      body: SafeArea(
          child: Container(
        margin: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
        child: ListView.separated(
            shrinkWrap: true,
            itemBuilder: ((context, index) {
              return singleChat();
            }),
            separatorBuilder: (context, index) {
              return Divider(
                color: Colors.grey,
              );
            },
            itemCount: 5),
      )),
    );
  }

  Widget singleChat() {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/images/test_cht_image.png",
                  width: 80.w,
                  height: 80.h,
                ),
                SizedBox(
                  width: 15.w,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Ikenwa John",
                      style: TextStyle(
                          fontSize: smallTextFontSize,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 8.h,
                    ),
                    Text(
                      "How are you doing",
                      style: TextStyle(fontSize: smallTextFontSize),
                    )
                  ],
                )
              ],
            ),
            Text(
              "1 min ago",
              style: TextStyle(fontSize: smallerTextFontSize),
            )
          ],
        ));
  }
}
