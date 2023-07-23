import 'package:carousel_indicator/carousel_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:simplibuy/core/constant.dart';
import 'package:simplibuy/core/constants/string_constants.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:simplibuy/store_and_product/domain/entities/product.dart';

import '../../domain/entities/store_category.dart';

Widget storeNameAndAddress(
    {required BuildContext context,
    required String storeImage,
    required String storeName,
    required String storeAddress}) {
  return Row(
    children: [
      Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.0)),
        width: MediaQuery.of(context).size.width * 0.18,
        height: 60,
        child: FadeInImage.assetNetwork(
            width: MediaQuery.of(context).size.width * 0.18,
            height: 60,
            fit: BoxFit.contain,
            placeholder: defaultStoreImage,
            imageErrorBuilder: (context, error, stackTrace) {
              return Image.asset(defaultStoreImage);
            },
            image: storeImage),
      ),
      Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0), color: Colors.red),
        width: MediaQuery.of(context).size.width * 0.76,
        padding: const EdgeInsets.all(5),
        child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          Text(
            storeName,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            softWrap: false,
            style: const TextStyle(
                color: whiteColor, fontSize: 30, fontWeight: FontWeight.bold),
          ),
          Text(
            overflow: TextOverflow.ellipsis,
            softWrap: false,
            storeAddress,
            style: TextStyle(color: whiteColor, fontSize: smallerTextFontSize),
            maxLines: 2,
          ),
        ]),
      )
    ],
  );
}

Widget searchInput(VoidCallback onPressed) {
  return GestureDetector(
      onTap: onPressed,
      child: const Icon(
        Icons.search,
        color: blackColor,
      ));
}

Widget storeDescription({required String desc}) {
  return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    Text(
      'About',
      style: TextStyle(color: Colors.grey, fontSize: smallerTextFontSize),
      textAlign: TextAlign.start,
    ),
    Text(desc, style: const TextStyle(color: blackColor, fontSize: 17))
  ]);
}

Widget _titleAndIcon(
    {required IconData data, required String text, VoidCallback? onClick}) {
  return TextButton.icon(
      icon: Icon(
        data,
        color: blackColor,
        size: 13,
      ),
      label: Text(
        text,
        style: TextStyle(
          color: blackColor,
          fontSize: 15.sp,
        ),
      ),
      onPressed: onClick);
}

Widget storeContactDetails(
    {required String email, required String phoneNumber}) {
  return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: _titleAndIcon(data: Icons.link, text: email),
        ),
        Expanded(child: _titleAndIcon(data: Icons.call, text: phoneNumber))
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
                text: 'Followers',
                style: TextStyle(color: color, fontSize: smallerTextFontSize)),
          ],
        ),
      ));
}

Widget _followStore() {
  return SizedBox(
      height: 36,
      child: FloatingActionButton.extended(
        heroTag: "follow",
        elevation: 1,
        label: Text(
          'Follow',
          style: TextStyle(color: whiteColor, fontSize: smallTextFontSize),
        ),
        backgroundColor: blueColor,
        icon: const Icon(
          Icons.add,
          color: whiteColor,
        ),
        onPressed: () {},
      ));
}

Widget chatToReserveItem(BuildContext context) {
  return SizedBox(
      height: 50,
      width: MediaQuery.of(context).size.width * 0.85,
      child: ElevatedButton.icon(
        label: Text(
          'Chat to reseve an item',
          style: TextStyle(color: blackColor, fontSize: smallTextFontSize),
        ),
        icon: const Icon(
          Icons.chat,
          color: blueColor,
        ),
        onPressed: () {},
      ));
}

Widget _chatToOrder() {
  return SizedBox(
      height: 36,
      child: FloatingActionButton.extended(
        heroTag: "chat",
        elevation: 1,
        label: Text(
          'Chat to Order',
          style: TextStyle(color: whiteColor, fontSize: smallTextFontSize),
        ),
        backgroundColor: blueColor,
        icon: const Icon(
          Icons.send,
          color: whiteColor,
        ),
        onPressed: () {},
      ));
}

Widget followAndChat() {
  return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _followStore(),
          _chatToOrder(),
        ],
      ));
}

Widget SellerProfileImage(BuildContext context, String image) {
  return FadeInImage.assetNetwork(
      height: MediaQuery.of(context).size.height * 0.3,
      fit: BoxFit.fill,
      placeholder: defaultStoreImage,
      imageErrorBuilder: (context, error, stackTrace) {
        return Image.asset(defaultStoreImageBig,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.3,
            fit: BoxFit.cover);
      },
      image: image);
}

Widget storeRating({required int rating}) {
  return Container(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: Row(children: [
        Text(
          'Rating',
          style: TextStyle(color: blackColor, fontSize: smallTextFontSize),
        ),
        const Padding(padding: EdgeInsets.only(left: 5)),
        RatingBar.builder(
            initialRating: rating.toDouble(),
            itemSize: 15,
            minRating: 1,
            onRatingUpdate: (rating) {},
            direction: Axis.horizontal,
            allowHalfRating: true,
            itemCount: 5,
            itemBuilder: (context, _) =>
                const Icon(Icons.star, color: Colors.amber))
      ]));
}

Widget singleCategoryItem(StoreCategory category, VoidCallback onPressed) {
  return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: GestureDetector(
          onTap: onPressed,
          child: Stack(alignment: Alignment.center, children: [
            ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                child: FadeInImage.assetNetwork(
                    width: 100,
                    height: 100,
                    fit: BoxFit.fill,
                    placeholder: defaultProductImage,
                    imageErrorBuilder: (context, error, stackTrace) {
                      return Image.asset(defaultProductImage);
                    },
                    image: category.categoryImage)),
            Positioned(
                child: Text(
              category.categoryName,
              textAlign: TextAlign.center,
              style: TextStyle(color: whiteColor, fontSize: smallTextFontSize),
            ))
          ])));
}

Widget singleProductItem(BuildContext context, Product product,
    VoidCallback onPressed, VoidCallback addToCart) {
  return GestureDetector(
      onTap: onPressed,
      child: Stack(clipBehavior: Clip.antiAlias, children: [
        ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            child: FadeInImage.assetNetwork(
                width: 110,
                height: 120,
                fit: BoxFit.fill,
                placeholder: defaultProductImage,
                placeholderCacheHeight: 110,
                placeholderCacheWidth: 120,
                imageErrorBuilder: (context, error, stackTrace) {
                  return Image.asset(
                    defaultProductImage,
                    width: 110,
                    height: 120,
                    fit: BoxFit.fill,
                  );
                },
                image: product.productImage[0])),
        Positioned(
          bottom: 2,
          left: 0,
          right: 0,
          child: _productTexts(context, product.productName,
              product.productPrice.toString(), addToCart),
        )
      ]));
}

const snackAdded = SnackBar(
  duration: Duration(milliseconds: 1000),
  content: Text('Product Added To Cart'),
);

Widget _productTexts(
    BuildContext context, String name, String price, VoidCallback addToCart) {
  return SizedBox(
      width: 114,
      height: 50,
      child: Card(
        color: Colors.transparent,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10))),
        child: Row(children: [
          Expanded(
              child: Container(
            width: 80,
            decoration: BoxDecoration(
              color: Color(0xff434041).withOpacity(0.6),
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10)),
            ),
            child: Column(
              children: [
                Text(
                  name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  softWrap: false,
                  style: const TextStyle(
                      color: whiteColor,
                      fontSize: 14,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  "₦$price View Details",
                  maxLines: 1,
                  textAlign: TextAlign.start,
                  overflow: TextOverflow.ellipsis,
                  softWrap: false,
                  style: TextStyle(
                      color: whiteColor,
                      fontSize: smallerTextFontSize,
                      fontWeight: FontWeight.bold),
                )
              ],
            ),
          )),
          GestureDetector(
            onTap: addToCart,
            child: const Icon(
              Icons.add,
              color: blueColor,
              size: 13,
            ),
          )
        ]),
      ));
}

Widget productListContainer(
    {required BuildContext context,
    required Product product,
    required VoidCallback onProductClick,
    required VoidCallback onAddBtnClicked}) {
  return Container(
      padding: const EdgeInsets.only(top: 5, left: 5),
      width: MediaQuery.of(context).size.width * 0.35,
      height: 230.h,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 2,
            offset: const Offset(0, 0),
          ),
        ],
      ),
      child: Stack(clipBehavior: Clip.hardEdge, children: [
        GestureDetector(
            onTap: onProductClick,
            child: Column(children: [
              productImage(product.productImage[0]),
              Text(product.productName,
                  style: TextStyle(
                      color: blackColor,
                      fontSize: smallTextFontSize,
                      fontWeight: FontWeight.bold)),
              /* RichText(
                          text: TextSpan(children: [*/
              Text('₦${product.productPrice}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      color: blackColor,
                      fontSize: 15,
                      fontWeight: FontWeight.bold)),
              /*  const TextSpan(
                          text: " View Details",
                          style: TextStyle(
                              color: blackColor, fontSize: smallerTextFontSize))*/
              //])),
            ])),
        Positioned(right: 0, bottom: 0, child: addSign(onAddBtnClicked))
      ]));
}

Widget productImage(String image) {
  return Container(
    padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.0)),
    child: FadeInImage.assetNetwork(
        width: 70,
        height: 80,
        fit: BoxFit.fill,
        placeholder: defaultProductImage,
        imageErrorBuilder: (context, error, stackTrace) {
          return Image.asset(
            defaultProductImage,
            width: 120.w,
            height: 120.h,
            fit: BoxFit.contain,
          );
        },
        image: image),
  );
}

Widget addSign(VoidCallback onPressed) {
  return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          color: Colors.grey,
          borderRadius:
              const BorderRadius.only(bottomRight: Radius.circular(10))),
      child: InkWell(
          borderRadius: BorderRadius.circular(100.0),
          onTap: onPressed,
          child: const Padding(
              padding: EdgeInsets.all(3.0),
              child: Icon(
                Icons.add,
                size: 15.0,
                color: Colors.black,
              ))));
}

Widget imageSlidersProduct(BuildContext context, List<String> images) {
  return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.45,
      decoration: const BoxDecoration(
          color: whiteColor,
          boxShadow: [
            BoxShadow(
                color: Colors.grey,
                offset: Offset(0.0, 3.0),
                blurRadius: 18.0,
                blurStyle: BlurStyle.outer),
          ],
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20))),
      child: CarouselSlider(
        options: CarouselOptions(
            clipBehavior: Clip.none,
            onPageChanged: (i, reason) {
              // item.sliderCurrentPosition =
              i; //Storing Slider position on the list item
              //   controller.dataList[index] = item; //For Flutter to rebuild the ui
            },
            enableInfiniteScroll: true,
            viewportFraction: 1.0,
            height: MediaQuery.of(context).size.height * 0.45),
        items: images.map((image) {
          return Builder(
            builder: (BuildContext context) {
              return Column(children: [
                FadeInImage.assetNetwork(
                    fit: BoxFit.fill,
                    placeholder: defaultProductImage,
                    imageErrorBuilder: (context, error, stackTrace) {
                      return Image.asset(
                        defaultProductImage,
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.45,
                        fit: BoxFit.cover,
                      );
                    },
                    image: image),
              ]);
            },
          );
        }).toList(),
      ));
}

Widget Indicator(int currentIndex, int count) {
  return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(count, (index) {
        return Container(
          width: 12.w,
          height: 12.h,
          margin: EdgeInsets.symmetric(horizontal: 2.0),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: currentIndex == index ? Colors.red : Colors.grey,
          ),
        );
      }));
}

Widget iconAsBtn(VoidCallback onPressed) {
  return Container(
      width: 55,
      decoration: const BoxDecoration(
          color: blueColor, borderRadius: BorderRadius.all(Radius.circular(5))),
      height: 55,
      child: IconButton(
          onPressed: onPressed,
          icon: const Icon(
            Icons.add_shopping_cart,
            color: whiteColor,
            size: 30,
          )));
}
