import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:simplibuy/core/constant.dart';
import 'package:simplibuy/core/constants/route_constants.dart';
import 'package:simplibuy/core/error_types/error_types.dart';
import 'package:simplibuy/core/reusable_widgets/reusable_widgets.dart';
import 'package:simplibuy/core/state/state.dart';
import 'package:simplibuy/seller_store/data/models/product.dart';
import 'package:simplibuy/seller_store/presentations/controllers/seller_products_controller.dart';

import '../../../../core/reusable_widgets/cache_image.dart';

// ignore: must_be_immutable
class SellerProductsScreens extends StatelessWidget {
  SellerProductsScreens({Key? key}) : super(key: key);

  final SellerProductsController controller =
      Get.find<SellerProductsController>();

  String catId = (Get.arguments as List)[0];
  String catName = (Get.arguments as List)[1];
  @override
  Widget build(BuildContext context) {
    print(catId);
    print(catName);
    controller.getSellerProducts(catId);
    return Scaffold(
      appBar: customAppBar(
          text: "Products",
          onPressed: () {
            Get.back();
          },
          actions: [
            PopupMenuButton<String>(
              icon: const Icon(Icons.add_box_outlined, color: blackColor),
              itemBuilder: (BuildContext context) {
                return actions;
              },
              onSelected: (val) {
                if (val == "Add") {
                  Get.toNamed(ADD_NEW_PRODUCT);
                } else {}
              },
            )
          ]),
      body: Container(
        padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
        child: Column(
          children: [
            Align(
                alignment: Alignment.topLeft,
                child: Padding(
                    padding: EdgeInsets.only(left: 10.w),
                    child: Text(
                      catName,
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          color: blackColor,
                          fontSize: 29.sp,
                          fontWeight: FontWeight.bold),
                    ))),
            const Padding(padding: EdgeInsets.only(top: defaultPadding)),
            showUI(context),
          ],
        ),
      ),
    );
  }

  Widget showUI(BuildContext context) {
    return Obx(() {
      if (controller.state is FinishedState) {
        return controller.products.isNotEmpty
            ? Expanded(
                child: GridView.count(
                    crossAxisCount: 2,
                    physics: const ScrollPhysics(),
                    crossAxisSpacing: 4.0,
                    mainAxisSpacing: 6.0,
                    shrinkWrap: true,
                    children: List.generate(
                        controller.products.length,
                        (index) => Padding(
                            padding: EdgeInsets.all(6),
                            child: Center(
                                child: showItemsGrid(
                                    context, controller.products[index], () {
                              Get.toNamed(SELLER_PRODUCT_DETAIL,
                                  arguments: controller.products[index]);
                            }))))))
            : Text(
                "No products for this category",
                style: TextStyle(fontSize: 24.sp),
              );
      }
      if (controller.state is LoadingState) {
        return defaultLoading(context);
      }
      if (controller.state == ErrorState(errorType: InternetError())) {
        return noInternetConnection(context);
      } else {
        return Container();
      }
    });
  }

  final actions = [
    const PopupMenuItem(
      value: 'Add',
      child: Text('Add new Product'),
    ),
    const PopupMenuItem(
      value: 'Delete',
      child: Text('Delete Items'),
    ),
  ];

  final delete_action = [
    PopupMenuItem(
      height: 10.h,
      value: 'Delete',
      child: Text('Delete Product'),
    ),
  ];

  Widget showItemsGrid(
      BuildContext context, SingleProduct product, VoidCallback onClick) {
    return GestureDetector(
        onTap: () {
          onClick();
        },
        child: Container(
          width: MediaQuery.of(context).size.width * 0.4,
          padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 8.w),
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
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                    child: Container(
                        clipBehavior: Clip.none,
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.width * 0.42,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.r),
                          border: Border.all(color: blueColor, width: 2),
                        ),
                        child: ImageCacheR(
                          product.productImages.first.url,
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.width * 0.42,
                          errorPlaceHolder: 'assets/images/buy.png',
                          topBottom: 20.r,
                          topRadius: 20.r,
                        ))),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                        child: Container(
                            constraints: const BoxConstraints(
                              maxWidth: 80,
                            ),
                            child: Text(
                              product.productName,
                              maxLines: 2,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
                              ),
                            ))),
                    GestureDetector(
                      child: PopupMenuButton(
                          padding: const EdgeInsets.all(0),
                          itemBuilder: (BuildContext context) {
                            return delete_action;
                          }),
                    )
                  ],
                )
              ]),
        ));
  }
}
