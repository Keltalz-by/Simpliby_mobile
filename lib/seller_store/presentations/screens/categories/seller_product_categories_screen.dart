import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:simplibuy/core/constant.dart';
import 'package:simplibuy/core/constants/route_constants.dart';
import 'package:simplibuy/core/reusable_widgets/reusable_widgets.dart';
import 'package:simplibuy/core/state/state.dart';
import 'package:simplibuy/seller_store/presentations/controllers/seller_categories_controller.dart';

class SellerProductCategoriesScreen extends StatelessWidget {
  SellerProductCategoriesScreen({Key? key}) : super(key: key);

  final SellerCategoriesController controller =
      Get.find<SellerCategoriesController>();

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
                  return actions();
                })
          ]),
      body: Obx(() => Container(
            padding: const EdgeInsets.all(defaultPadding),
            child: controller.state is FinishedState
                ? controller.categories.isNotEmpty
                    ? GridView.count(
                        crossAxisCount: 2,
                        physics: const ScrollPhysics(),
                        crossAxisSpacing: 4.0,
                        mainAxisSpacing: 10.0,
                        shrinkWrap: true,
                        children: List.generate(
                            controller.categories.length,
                            (index) => Center(
                                    child: singleCategory(context, () {
                                  Get.toNamed(SELLER_PRODUCTS);
                                }, controller.categories[index].categoryName))))
                    : Text(
                        "You don't have any categories",
                        style: TextStyle(fontSize: 24.sp),
                      )
                : controller.state is LoadingState
                    ? defaultLoading(context)
                    : Container(),
          )),
    );
  }

  List<PopupMenuEntry<String>> actions() {
    return [
      PopupMenuItem(
        onTap: () {
          Get.bottomSheet(addCategory());
        },
        value: 'Add',
        child: Text(
          'Add new Category',
          style: TextStyle(fontSize: smallTextFontSize),
        ),
      ),
      PopupMenuItem(
        value: 'Delete',
        child: Text(
          'Delete Category',
          style: TextStyle(fontSize: smallTextFontSize),
        ),
      )
    ];
  }

  final padding = const Padding(padding: EdgeInsets.only(top: 10));

  Widget addCategory() {
    final List<String> suggestions = [
      "Clothing and Fashion",
      "Electronics",
      "Home and Kitchen",
      "Health",
      "Beauty and Cosmetics",
      "Books and Media",
      "Sports and Outdoors",
      "Toys and Games",
      "Automotive",
      "Jewelry and Accessories",
      "Furniture and Decoration",
      "Pet Supplies",
      "Office Supplies",
      "Tools and Home gadgets",
      "Groceries and Food",
      "Arts and Crafts",
      "Travel and Luggage",
      "Fitness and Exercise",
      "Music and Instruments",
    ];

    return SingleChildScrollView(
        child: Container(
            padding: EdgeInsets.only(
                top: 10.h, bottom: 25.h, left: 25.w, right: 25.w),
            alignment: Alignment.topCenter,
            decoration: BoxDecoration(
              color: whiteColor,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  blurRadius: 3.0,
                  offset: const Offset(0, 2),
                ),
              ],
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25.r),
                  topRight: Radius.circular(25.r)),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 80.w,
                  height: 4.h,
                  decoration: BoxDecoration(
                    color: Colors.grey.withAlpha(100),
                    borderRadius: BorderRadius.all(Radius.circular(25.r)),
                  ),
                ),
                padding,
                padding,
                Text(
                  "Category Name",
                  style:
                      TextStyle(color: blackColor, fontSize: smallTextFontSize),
                ),
                padding,
                padding,
                Autocomplete<String>(
                  optionsBuilder: (TextEditingValue textEditingValue) {
                    if (textEditingValue.text == '') {
                      return const Iterable<String>.empty();
                    } else {
                      List<String> matches = <String>[];
                      matches.addAll(suggestions);

                      matches.retainWhere((s) {
                        return s
                            .toLowerCase()
                            .contains(textEditingValue.text.toLowerCase());
                      });
                      return matches;
                    }
                  },
                  onSelected: (String selection) {
                    print('You just selected $selection');
                  },
                  fieldViewBuilder: (BuildContext context,
                      TextEditingController textEditingController,
                      FocusNode focusNode,
                      VoidCallback onFieldSubmitted) {
                    return TextField(
                      decoration: customInputDecoration(),
                      controller: textEditingController,
                      focusNode: focusNode,
                      onSubmitted: (value) {
                        onFieldSubmitted();
                      },
                    );
                  },
                ),
                SizedBox(
                  height: 200.h,
                ),
                defaultButtons(pressed: () {}, text: "Add")
              ],
            )));
  }

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
