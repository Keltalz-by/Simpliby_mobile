import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
        child: GridView.count(
            crossAxisCount: 2,
            physics: const ScrollPhysics(),
            crossAxisSpacing: 4.0,
            mainAxisSpacing: 18.0,
            shrinkWrap: true,
            children: List.generate(
                categories.length,
                (index) => Center(
                        child: singleCategory(context, () {
                      Get.toNamed(SELLER_PRODUCTS);
                    }, categories[index])))),
      ),
    );
  }

  final categories = [
    "Food",
    "Furniture",
    "Cosmetics",
    "Groceries",
    "Gadgets",
    "Health",
    "Drinks",
    "Books"
  ];

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

  Widget singleCategory(
      BuildContext context, VoidCallback onClick, String categoryName) {
    return GestureDetector(
        onTap: () {
          onClick();
        },
        child: Container(
          alignment: Alignment.topLeft,
          padding: EdgeInsets.all(10),
          width: MediaQuery.of(context).size.width * 0.4,
          height: MediaQuery.of(context).size.width * 0.4,
          decoration: BoxDecoration(
            border: Border.all(color: Color(0xff64BCF4)),
            color: Color.fromARGB(255, 128, 199, 243),
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                categoryName,
                style: TextStyle(
                  fontSize: smallTextFontSize,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Text(
                'View Items in $categoryName category',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ],
          ),
        ));
  }
}
