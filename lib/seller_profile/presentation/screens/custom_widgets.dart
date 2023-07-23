import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:simplibuy/core/constant.dart';
import 'package:simplibuy/core/constants/string_constants.dart';
import 'package:simplibuy/seller_profile/data/models/seller_profile_details.dart';

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
            child: ClipRRect(
                borderRadius: BorderRadius.circular(20.r),
                child: FadeInImage.assetNetwork(
                    image: post.image,
                    width: MediaQuery.of(context).size.width,
                    height: 180.h,
                    fit: BoxFit.cover,
                    placeholder: defaultStoreImage,
                    imageErrorBuilder: (context, error, stackTrace) {
                      return ClipRRect(
                          borderRadius: BorderRadius.circular(20.r),
                          child: Image.asset(defaultProductImage,
                              width: MediaQuery.of(context).size.width,
                              height: 180.h,
                              fit: BoxFit.cover));
                    }))),
        const Padding(padding: EdgeInsets.only(top: 10)),
        Text(post.title,
            style: TextStyle(
                fontSize: smallTextFontSize, fontWeight: FontWeight.bold))
      ],
    ),
  );
}
