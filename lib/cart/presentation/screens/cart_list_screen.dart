import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:simplibuy/cart/domain/entities/item_cart_detail.dart';
import 'package:simplibuy/cart/presentation/controllers/cart_list_controller.dart';
import 'package:simplibuy/cart/presentation/screens/custom_widgets.dart';
import 'package:simplibuy/core/error_types/error_types.dart';
import 'package:simplibuy/core/reusable_widgets/reusable_widgets.dart';
import 'package:simplibuy/core/state/state.dart';
import '../../../buyer_home/presentation/controller/buyer_home_navigation_controller.dart';
import '../../../core/constants/route_constants.dart';

class CartList extends StatelessWidget {
  CartList({Key? key}) : super(key: key);

  BuyerHomeNavigationController navController =
      Get.find<BuyerHomeNavigationController>();

  CartListController controller = Get.find<CartListController>();

  @override
  Widget build(BuildContext context) {
    controller.getAllItemsInCart();
    return Scaffold(
        backgroundColor: Color(0xFFF9F9FA),
        appBar: customAppBar(
            text: "Cart",
            onPressed: () {
              navController.changePage(0);
            }),
        body: Container(
            padding: const EdgeInsets.all(10),
            child: Obx(() {
              if (controller.state is LoadingState) {
                return defaultLoading(context);
              }
              if (controller.state == ErrorState(errorType: EmptyListError())) {
                return noDataInCart(() => controller.startShopping());
              } else {
                return Column(children: [
                  cartList(context),
                  const Padding(padding: EdgeInsets.only(top: 10)),
                  Obx(() {
                    return controller.cartItems.isEmpty
                        ? Container()
                        : calculations(context);
                  }),
                  const Padding(padding: EdgeInsets.only(top: 10)),
                  Obx(() {
                    return controller.cartItems.isEmpty
                        ? Container()
                        : defaultButtons(
                            pressed: () {
                              Get.toNamed(RESERVE_SCREEN);
                            },
                            text: 'Reserve Item');
                  }),
                ]);
              }
            })));
  }

  Widget cartList(BuildContext context) {
    return Obx(() => Expanded(
        child: ListView.builder(
            physics: BouncingScrollPhysics(),
            itemCount: controller.cartItems.length,
            itemBuilder: (context, position) {
              return singleCartItem(controller.cartItems[position], () {
                controller.deleteCartItem(position);
              }, () {
                controller.updateNumberOfItemsHigher(position);
              }, () {
                controller.updateNumberOfItemsLower(position);
              });
            })));
  }

  Widget calculations(BuildContext context) {
    return Obx(() => Container(
        margin: const EdgeInsets.all(8),
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(8))),
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            calculationInfo('Subtotal', '₦${controller.totalPriceInCart}'),
            const Padding(padding: EdgeInsets.only(top: 10)),
            calculationInfo('Reserve Charges', '₦${controller.charges}'),
            const Padding(padding: EdgeInsets.only(top: 10)),
            const Divider(
              color: Colors.black,
            ),
            const Padding(padding: EdgeInsets.only(top: 10)),
            calculationInfo('Total', '₦${controller.totalPrice}',
                weight: FontWeight.bold)
          ],
        )));
  }

  Widget singleCartItem(ItemCartDetails details, VoidCallback ondelete,
      VoidCallback onadd, VoidCallback onreduce) {
    return Container(
        margin: const EdgeInsets.all(5),
        padding: EdgeInsets.symmetric(horizontal: 15.w),
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(8))),
        child: Column(
          children: [
            const Padding(padding: EdgeInsets.only(top: 10)),
            cartListSingleItem(details),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                deleteTextButton(ondelete),
                Align(
                  alignment: Alignment.centerRight,
                  child: itemCounter(
                      number: details.itemPieces,
                      onAdded: onadd,
                      onSubtracted: onreduce),
                )
              ],
            )
          ],
        ));
  }
}
