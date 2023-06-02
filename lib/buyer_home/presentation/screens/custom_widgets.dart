import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:simplibuy/buyer_home/data/models/fav_stores_model.dart';
import 'package:simplibuy/core/constant.dart';
import 'package:simplibuy/buyer_home/domain/entities/strore_details.dart';

import '../../../core/reusable_widgets/reusable_widgets.dart';

PreferredSizeWidget homeAppBar(
    {required String text, required VoidCallback onPressed}) {
  return AppBar(
      elevation: 2,
      iconTheme: const IconThemeData(color: blackColor),
      title: Text(
        text,
        style: TextStyle(color: blackColor, fontSize: smallTextFontSize),
      ),
      backgroundColor: whiteColor,
      actions: [
        Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: GestureDetector(
                onTap: onPressed,
                child: Ink(
                    decoration: const ShapeDecoration(shadows: [
                      BoxShadow(color: Color.fromARGB(255, 129, 127, 127))
                    ], color: Colors.white, shape: CircleBorder()),
                    child: IconButton(
                        color: blackColor,
                        highlightColor: whiteColor,
                        focusColor: whiteColor,
                        onPressed: onPressed,
                        icon: const Icon(Icons.notifications)))))
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
      height: 45,
      width: 45,
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
      height: 45,
      width: MediaQuery.of(context).size.width * 0.78,
      child: Align(
          alignment: Alignment.center,
          child: TextField(
            decoration: InputDecoration(
              prefixIcon: const Icon(
                Icons.search,
                color: blueColor,
              ),
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
      margin: const EdgeInsets.all(5),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8))),
      elevation: 5,
      color: Colors.white,
      child: GestureDetector(
          onTap: onClick,
          child: Row(
            children: [
              Image.asset("assets/images/shoprite_small.png"),
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
                            color: blackColor, fontSize: smallTextFontSize)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(details.location,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                color: blackColor, fontSize: 15)),
                        onFavClicked != null
                            ? FavoriteButton(
                                iconSize: 24,
                                iconDisabledColor: lightBlueColor,
                                iconColor: lightBlueColor,
                                valueChanged: (isFavorite) {
                                  onFavClicked();
                                },
                              )
                            : Container(),
                      ],
                    ),
                    Text(details.address,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(color: blackColor, fontSize: 15))
                  ],
                ),
              )
            ],
          )));
}

Widget storesGridSingleItem(
    {required StoreDetails details,
    required VoidCallback onPressed,
    required VoidCallback onFavClicked}) {
  return Container(
      width: 130,
      decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              offset: Offset(0.0, 1.0), //(x,y)
              blurRadius: 6.0,
            ),
          ],
          borderRadius: BorderRadius.all(Radius.circular(8))),
      clipBehavior: Clip.hardEdge,
      child: Column(
        children: [
          InkWell(
              splashColor: Colors.blue,
              highlightColor: Colors.red,
              radius: 20.0,
              onTap: onPressed,
              child: Image.asset("assets/images/buy.png",
                  width: 130, height: 130)),
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            Flexible(
                child: Text(
              details.name,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: smallTextFontSize, color: blackColor),
            )),
            FavoriteButton(
              iconSize: 24,
              iconDisabledColor: lightBlueColor,
              iconColor: lightBlueColor,
              valueChanged: (isFavorite) {
                onFavClicked();
              },
            )
          ]),
          Flexible(
              child: Text(
            details.location,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: smallerTextFontSize, color: blackColor),
          )),
          const Padding(padding: EdgeInsets.only(top: 5))
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
          height: 30,
          child: Row(
            children: [
              Checkbox(
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  value: isBought.value,
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
