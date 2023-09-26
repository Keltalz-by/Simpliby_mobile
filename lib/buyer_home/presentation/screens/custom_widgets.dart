import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:simplibuy/core/constant.dart';
import 'package:simplibuy/buyer_home/domain/entities/strore_details.dart';

import '../../../core/reusable_widgets/reusable_widgets.dart';

PreferredSizeWidget homeAppBar(
    {required String text,
    required String name,
    required VoidCallback onPressed,
    required VoidCallback openDrawer}) {
  return AppBar(
      elevation: 0,
      iconTheme: const IconThemeData(color: blackColor),
      leading: Padding(
          padding: EdgeInsets.only(left: 20.w),
          child: GestureDetector(
              onTap: openDrawer,
              child: Container(
                  padding: EdgeInsets.all(6),
                  decoration: ShapeDecoration(shadows: [
                    BoxShadow(
                        color: Colors.grey.withAlpha(150),
                        offset: Offset(1.0, 1.0),
                        blurRadius: 10.r)
                  ], color: Colors.white, shape: CircleBorder()),
                  child: Icon(Icons.menu)))),
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

Widget customButtonWithIcon(
    {required String text,
    required IconData iconData,
    required VoidCallback onPressed,
    BorderSide? side}) {
  return Container(
      height: 60,
      alignment: Alignment.center,
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(35))),
      padding: const EdgeInsets.all(2),
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: Icon(
          iconData,
          color: blackColor,
        ), //icon data for elevated button
        label: Text(
          text,
          style: TextStyle(color: blackColor, fontSize: smallTextFontSize),
        ), //label text
        style: OutlinedButton.styleFrom(
          backgroundColor: Colors.white,
          primary: Colors.white,
          side: side,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(18))),
          elevation: 3,
        ),
      ));
}

Widget filterOption(VoidCallback onPressed) {
  return Container(
      height: 50.h,
      width: 48.w,
      clipBehavior: Clip.hardEdge,
      decoration: const ShapeDecoration(
          color: blueColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
          )),
      child: IconButton(
          iconSize: 25,
          color: whiteColor,
          onPressed: onPressed,
          icon: const Icon(Icons.filter_list)));
}

Widget searchInputBlue(BuildContext context) {
  return SizedBox(
      width: MediaQuery.of(context).size.width * 0.78,
      height: 50.h,
      child: Align(
          alignment: Alignment.center,
          child: TextField(
            decoration: InputDecoration(
              prefixIcon: const Icon(
                Icons.search,
                color: blueColor,
              ),
              contentPadding: EdgeInsets.all(8),
              enabledBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(8)),
                borderSide: BorderSide(width: 3, color: blueColor),
              ),
              focusedBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(8)),
                borderSide: BorderSide(width: 3, color: blueColor),
              ),
              hintText: "Where do you want to shop?",
              hintStyle: TextStyle(color: Colors.grey[800]),
            ),
            textAlign: TextAlign.center,
          )));
}

Widget searchInputGrey(BuildContext context) {
  return SizedBox(
      child: TextField(
    decoration: InputDecoration(
      filled: true,
      border: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(8)),
        borderSide:
            BorderSide(width: 0, color: Color.fromRGBO(236, 240, 243, 1)),
      ),
      fillColor: const Color.fromRGBO(236, 240, 243, 1),
      prefixIcon: const Icon(
        Icons.search,
        color: blackColor,
      ),
      hintText: "Search for a store",
      hintStyle: TextStyle(color: Colors.grey[800]),
    ),
    textAlign: TextAlign.left,
  ));
}

Widget showEmptyFavorites(BuildContext context) {
  return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(Icons.favorite_border, size: 40),
          Text(
            'No favorites yet',
            textAlign: TextAlign.center,
            style: TextStyle(color: blackColor, fontSize: smallTextFontSize),
          )
        ],
      ));
}

const snackAdded = SnackBar(
  duration: Duration(milliseconds: 1000),
  content: Text('Item Added To Favorites'),
);

const snackRemoved = SnackBar(
  duration: Duration(milliseconds: 1000),
  content: Text('Item Removed from Favorites'),
);

Widget storesListSingleItem(
    {required StoreDetails details,
    required VoidCallback onClick,
    required VoidCallback? onFavClicked}) {
  return Card(
      margin: EdgeInsets.all(10),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8))),
      elevation: 5,
      color: Colors.white,
      child: Container(
          padding: EdgeInsets.symmetric(vertical: 7.h, horizontal: 7.w),
          child: GestureDetector(
              onTap: onClick,
              child: Row(
                children: [
                  Image.asset(
                    "assets/images/shoprite_small.png",
                    width: 100.w,
                    height: 100.h,
                    fit: BoxFit.cover,
                  ),
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Align(
                          alignment: Alignment.bottomRight,
                          child: RatingBar.builder(
                              initialRating: 3,
                              itemSize: 11,
                              minRating: 1,
                              onRatingUpdate: (rating) {},
                              direction: Axis.horizontal,
                              allowHalfRating: true,
                              itemCount: 5,
                              itemBuilder: (context, _) =>
                                  const Icon(Icons.star, color: Colors.amber)),
                        ),
                        Text(details.name,
                            maxLines: 1,
                            style: TextStyle(
                                color: blackColor,
                                fontSize: smallTextFontSize)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(details.location,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    color: blackColor, fontSize: 15)),
                          ],
                        ),
                        Text(details.address,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                color: blackColor, fontSize: 15))
                      ],
                    ),
                  )
                ],
              ))));
}

Widget storesGridSingleItem(
    {required StoreDetails details,
    required VoidCallback onPressed,
    required VoidCallback onFavClicked,
    required bool isFav,
    required BuildContext context}) {
  return Container(
      width: MediaQuery.of(context).size.width * 0.35,
      padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 8.w),
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withAlpha(100),
              offset: Offset(0.0, 1.0),
              blurRadius: 6.0,
            ),
          ],
          borderRadius: BorderRadius.all(Radius.circular(8))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
              splashColor: Colors.blue,
              highlightColor: Colors.red,
              radius: 20.r,
              onTap: onPressed,
              child: Image.asset("assets/images/buy.png",
                  fit: BoxFit.cover,
                  width: MediaQuery.of(context).size.width,
                  height: 140.h)),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Flexible(
              child: Text(
                details.name,
                textAlign: TextAlign.left,
                overflow: TextOverflow.ellipsis,
                style:
                    TextStyle(fontSize: smallTextFontSize, color: blackColor),
              ),
            ),
            !isFav
                ? InkWell(
                    onTap: () {
                      onFavClicked();
                    },
                    child: const Icon(
                      Icons.favorite_border,
                      size: 18,
                    ))
                : InkWell(
                    onTap: () {
                      onFavClicked();
                    },
                    child: const Icon(
                      Icons.favorite_rounded,
                      color: Colors.red,
                      size: 18,
                    ))
          ]),
          Flexible(
              child: Text(
            details.location,
            textAlign: TextAlign.left,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: 16.sp, color: blackColor),
          )),
        ],
      ));
}

Widget noInternet(VoidCallback startShoppingClicked) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Image.asset('assets/images/no_network.png'),
      const Padding(padding: EdgeInsets.only(top: 10)),
      Text(
        'Oops!',
        style: TextStyle(
            color: blackColor,
            fontSize: smallTextFontSize,
            fontWeight: FontWeight.bold),
      ),
      const Padding(padding: EdgeInsets.only(top: 10)),
      const Text(
        'Please check your Internet connection and try again',
        style: TextStyle(color: blackColor, fontSize: 15),
      ),
      const Padding(padding: EdgeInsets.only(top: 30)),
      defaultButtons(
          pressed: startShoppingClicked, text: 'Try Again', size: Size(120, 50))
    ],
  );
}

Widget toBuyListSingleItem(String text, RxBool isBought, VoidCallback save) {
  return GestureDetector(
      child: SizedBox(
          height: 30.h,
          child: Row(
            children: [
              Checkbox(
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  value: isBought.value,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  onChanged: (value) =>
                      {isBought.value = !isBought.value, save()}),
              Text(
                text,
                style: TextStyle(
                  decoration: isBought.value
                      ? TextDecoration.lineThrough
                      : TextDecoration.none,
                ),
              ),
            ],
          )));
}
