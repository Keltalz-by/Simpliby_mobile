import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simplibuy/core/constant.dart';
import 'package:simplibuy/core/constants/route_constants.dart';
import 'package:simplibuy/core/reusable_widgets/reusable_widgets.dart';

class SellerProductCategoriesScreen extends StatelessWidget {
  SellerProductCategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withAlpha(250),
      appBar: customAppBar(
          text: "Categories",
          onPressed: () {
            Get.back();
          },
          actions: [
            PopupMenuButton<String>(
                icon: const Icon(Icons.more_vert, color: blackColor),
                itemBuilder: (BuildContext context) {
                  return actions;
                })
          ]),
      body: Container(
        padding: const EdgeInsets.all(defaultPadding),
        child: Expanded(
            child: ListView.separated(
                separatorBuilder: (context, value) {
                  return const Padding(padding: EdgeInsets.only(top: 12));
                },
                itemCount: 5,
                itemBuilder: (context, position) {
                  return singleCategory(context, () {
                    Get.toNamed(SELLER_PRODUCTS);
                  });
                })),
      ),
    );
  }

  final actions = [
    const PopupMenuItem(
      value: 'Add',
      child: Text('Add new Category'),
    ),
    const PopupMenuItem(
      value: 'Delete',
      child: Text('Delete Category'),
    ),
  ];

  Widget singleCategory(BuildContext context, VoidCallback onClick) {
    return GestureDetector(
        onTap: () {
          onClick();
        },
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 160,
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: FadeInImage.assetNetwork(
                        width: MediaQuery.of(context).size.width,
                        height: 100,
                        fit: BoxFit.cover,
                        placeholder: 'assets/images/buy.png',
                        imageErrorBuilder: (context, error, stackTrace) {
                          return Image.asset(
                            'assets/images/buy.png',
                            width: MediaQuery.of(context).size.width,
                            height: 100,
                            fit: BoxFit.cover,
                          );
                        },
                        image: "")),
              ),
              Text(
                'Food',
                style: TextStyle(
                  fontSize: smallTextFontSize,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ],
          ),
        ));
  }
}
