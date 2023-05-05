import 'package:flutter/material.dart';
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
            const Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Food",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      color: blackColor,
                      fontSize: 29,
                      fontWeight: FontWeight.bold),
                )),
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
        return Flexible(
            child: GridView.count(
                crossAxisCount: 2,
                physics: const ScrollPhysics(),
                crossAxisSpacing: 4.0,
                mainAxisSpacing: 18.0,
                shrinkWrap: true,
                children: List.generate(
                    controller.products.length,
                    (index) => Center(
                            child: showItemsGrid(
                                context, controller.products[index], () {
                          Get.toNamed(SELLER_PRODUCT_DETAIL);
                        })))));
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
      child: Text('Delete Categosry'),
    ),
  ];

  final delete_action = [
    const PopupMenuItem(
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
                      borderRadius: BorderRadius.circular(60),
                      child: FadeInImage.assetNetwork(
                          width: MediaQuery.of(context).size.width * 0.4,
                          height: 90,
                          fit: BoxFit.fill,
                          placeholder: 'assets/images/buy.png',
                          imageErrorBuilder: (context, error, stackTrace) {
                            return Image.asset(
                              'assets/images/buy.png',
                              width: MediaQuery.of(context).size.width * 0.35,
                              height: 90,
                            );
                          },
                          image: product.img)),
                ),
                Expanded(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
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
                        )),
                    GestureDetector(
                      child: PopupMenuButton(
                          padding: const EdgeInsets.all(1),
                          itemBuilder: (BuildContext context) {
                            return delete_action;
                          }),
                    )
                  ],
                ))
              ]),
        ));
  }
}
