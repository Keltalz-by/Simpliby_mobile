import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:simplibuy/core/constant.dart';
import 'package:simplibuy/core/constants/route_constants.dart';
import 'package:simplibuy/core/error_types/error_types.dart';
import 'package:simplibuy/core/reusable_widgets/reusable_widgets.dart';
import 'package:simplibuy/core/state/state.dart';
import 'package:simplibuy/seller_products/data/models/seller_product.dart';
import 'package:simplibuy/seller_products/presentation/controllers/seller_products_controller.dart';

class SellerProductsScreens extends StatelessWidget {
  SellerProductsScreens({Key? key}) : super(key: key);

  final SellerProductsController controller =
      Get.find<SellerProductsController>();
  @override
  Widget build(BuildContext context) {
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
                      "Food",
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
        return Expanded(
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
                          Get.toNamed(SELLER_PRODUCT_DETAIL);
                        }))))));
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
      BuildContext context, SellerProduct product, VoidCallback onClick) {
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
                        clipBehavior: Clip.hardEdge,
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.width * 0.42,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.r),
                          border: Border.all(color: blueColor, width: 2),
                        ),
                        child: ClipRRect(
                            clipBehavior: Clip.hardEdge,
                            borderRadius: BorderRadius.circular(20),
                            child: FadeInImage.assetNetwork(
                                width: MediaQuery.of(context).size.width,
                                height:
                                    MediaQuery.of(context).size.width * 0.42,
                                fit: BoxFit.fill,
                                placeholder: 'assets/images/buy.png',
                                imageErrorBuilder:
                                    (context, error, stackTrace) {
                                  return Image.asset(
                                    'assets/images/buy.png',
                                    width: MediaQuery.of(context).size.width,
                                    height: MediaQuery.of(context).size.width *
                                        0.42,
                                    fit: BoxFit.fill,
                                  );
                                },
                                image: product.img)))),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                        child: Container(
                            constraints: const BoxConstraints(
                              maxWidth: 80,
                            ),
                            child: Text(
                              product.name,
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
