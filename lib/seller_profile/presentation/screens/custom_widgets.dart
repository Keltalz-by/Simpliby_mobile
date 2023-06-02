import 'package:flutter/material.dart';
import 'package:simplibuy/core/constant.dart';
import 'package:simplibuy/core/constants/string_constants.dart';
import 'package:simplibuy/seller_profile/data/models/seller_profile_details.dart';

Widget singlePromo(BuildContext context, SellerSinglePromoPost post) {
  return Container(
    width: MediaQuery.of(context).size.width,
    padding: const EdgeInsets.all(10),
    decoration: const BoxDecoration(
        color: whiteColor, borderRadius: BorderRadius.all(Radius.circular(20))),
    child: Column(
      children: [
        ClipRRect(
            borderRadius: BorderRadius.circular(
                20), // adjust this value as per your needs
            child: FadeInImage.assetNetwork(
                image: post.image,
                width: MediaQuery.of(context).size.width,
                height: 60,
                fit: BoxFit.cover,
                placeholder: defaultStoreImage,
                imageErrorBuilder: (context, error, stackTrace) {
                  return ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: Image.asset(defaultProductImage,
                          width: MediaQuery.of(context).size.width,
                          height: 120,
                          fit: BoxFit.cover));
                })),
        const Padding(padding: EdgeInsets.only(top: 10)),
        Text(post.title,
            style: TextStyle(
                fontSize: smallTextFontSize, fontWeight: FontWeight.bold))
      ],
    ),
  );
}
