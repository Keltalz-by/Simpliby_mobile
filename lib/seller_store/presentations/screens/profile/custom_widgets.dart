import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:simplibuy_seller/core/constant.dart';
import 'package:simplibuy_seller/core/constants/string_constants.dart';
import 'package:simplibuy_seller/core/reusable_widgets/cache_image.dart';
import 'package:simplibuy_seller/seller_store/data/models/seller_profile_details.dart';

Widget storeDescription({required String desc}) {
  return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    Text(
      'About',
      style: TextStyle(color: Colors.grey, fontSize: smallerTextFontSize),
      textAlign: TextAlign.start,
    ),
    Text(desc, style: TextStyle(color: blackColor, fontSize: smallTextFontSize))
  ]);
}

Widget storeFollowers(
    {required int followers,
    BoxDecoration? decoration,
    Color color = blackColor}) {
  return Container(
      padding: const EdgeInsets.all(10),
      decoration: decoration,
      child: RichText(
        text: TextSpan(
          style: TextStyle(color: blackColor, fontSize: smallerTextFontSize),
          children: <TextSpan>[
            TextSpan(
                text: followers.toString(),
                style: TextStyle(
                    color: color,
                    fontSize: smallTextFontSize,
                    fontWeight: FontWeight.bold)),
            TextSpan(
                text: ' Followers',
                style: TextStyle(color: color, fontSize: smallerTextFontSize)),
          ],
        ),
      ));
}

Widget _titleAndIcon(
    {required IconData data, required String text, VoidCallback? onClick}) {
  return InkWell(
      onTap: () {
        onClick!();
      },
      child: Row(children: [
        Icon(
          data,
          color: blackColor,
          size: 16,
        ),
        SizedBox(
          width: 8.w,
        ),
        Text(
          text,
          style: TextStyle(
            color: blackColor,
            fontSize: smallTextFontSize,
          ),
        ),
      ]));
}

Widget storeContactDetails(
    {required String email, required String phoneNumber}) {
  return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _titleAndIcon(data: Icons.link, text: email),
        _titleAndIcon(data: Icons.call, text: phoneNumber)
      ]);
}

Widget SellerProfileImage(BuildContext context, String image) {
  return ImageCacheR(
    "",
    width: MediaQuery.of(context).size.width,
    height: MediaQuery.of(context).size.height * 0.3,
    errorPlaceHolder: defaultStoreImageBig,
  );
}

Widget singlePromo(BuildContext context, SellerSinglePromoPost post) {
  return Container(
    width: MediaQuery.of(context).size.width,
    padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
    decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.all(Radius.circular(20.r))),
    child: Column(
      children: [
        Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.r),
              border: Border.all(color: blueColor, width: 2),
            ),
            child: ImageCacheR(
              "",
              width: MediaQuery.of(context).size.width,
              height: 180.h,
              errorPlaceHolder: defaultProductImage,
              topBottom: 20.r,
              topRadius: 20.r,
            )),
        const Padding(padding: EdgeInsets.only(top: 10)),
        Text(post.title,
            style: TextStyle(
                fontSize: smallTextFontSize, fontWeight: FontWeight.bold))
      ],
    ),
  );
}
