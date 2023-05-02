import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simplibuy/buyer_home/presentation/screens/custom_widgets.dart';
import 'package:simplibuy/core/constant.dart';
import 'package:simplibuy/core/error_types/error_types.dart';
import 'package:simplibuy/core/reusable_widgets/custom_dialog.dart';
import 'package:simplibuy/core/reusable_widgets/reusable_widgets.dart';
import 'package:simplibuy/core/state/state.dart';
import 'package:simplibuy/orders/presentation/controllers/orders_controllers.dart';
import 'package:simplibuy/orders/presentation/screens/custom_widgets.dart';

class OrdersScreen extends StatelessWidget {
  OrdersScreen({Key? key}) : super(key: key);
  final OrdersController controller = Get.find<OrdersController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 243, 243, 243),
      appBar: customAppBar(
          text: "Back",
          onPressed: () {
            Get.back();
          }),
      body: Container(
        padding: const EdgeInsets.all(10),
        alignment: Alignment.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            orderButtons(context),
            const Padding(padding: EdgeInsets.only(top: 20)),
            Obx(() {
              if (controller.state is LoadingState) {
                return defaultLoading(context);
              }
              if (controller.state == ErrorState(errorType: InternetError())) {
                return noInternet(() {
                  controller.reload();
                });
              }
              if (controller.state == ErrorState(errorType: EmptyListError())) {
                return emptyOrder();
              }
              if (controller.state == ErrorState(errorType: ServerError())) {
                return noInternet(() {
                  controller.reload();
                });
              }
              if (controller.isIncoming) {
                return icomingOrdersList(context);
              } else {
                return acceptedOrdersList();
              }
            })
          ],
        ),
      ),
    );
  }

  showBottomSheetAcceptedOrders() {
    Get.bottomSheet(acceptedOrdersBottomSheet(() {
      Get.dialog(CustomDialog(
          callback: () {},
          buttonText: "Confirm Payment",
          textDetail: "Offer Accepted"));
    }));
  }

  showBottomSheetIncoingOrders() {
    Get.bottomSheet(incomingOrdersBottomSheet(() {
      Get.dialog(CustomDialog(
          callback: () {},
          buttonText: "Confirm Payment",
          textDetail: "Offer Accepted"));
    }, () {
      Get.dialog(CustomDialog(
          callback: () {},
          buttonText: "Continue",
          iconColor: Colors.black,
          textDetail: "Offer Declined"));
    }));
  }

  Widget orderButtons(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width * 0.78,
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.3),
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(6.0),
                decoration: BoxDecoration(
                  color: whiteColor,
                  borderRadius: BorderRadius.circular(2.0),
                ),
                child: GestureDetector(onTap: () {
                  controller.getIncomingOrders();
                }, child: Obx(() {
                  return Text(
                    "Incoming Orders",
                    style: TextStyle(
                      fontSize: 18.0,
                      color: controller.isIncoming
                          ? blueColor
                          : blackColor.withOpacity(0.8),
                      fontWeight: FontWeight.bold,
                    ),
                  );
                })),
              ),
              const Padding(padding: EdgeInsets.only(left: 6)),
              Container(
                padding: const EdgeInsets.all(6.0),
                decoration: BoxDecoration(
                  color: whiteColor,
                  borderRadius: BorderRadius.circular(2.0),
                ),
                child: GestureDetector(onTap: () {
                  controller.getAcceptedOrders();
                }, child: Obx(() {
                  return Text(
                    "Accepted Orders",
                    style: TextStyle(
                      fontSize: 18.0,
                      color: controller.isIncoming
                          ? blackColor.withOpacity(0.8)
                          : blueColor,
                      fontWeight: FontWeight.bold,
                    ),
                  );
                })),
              )
            ]));
  }

  Widget icomingOrdersList(BuildContext context) {
    return Obx(() {
      return Expanded(
          child: ListView.separated(
              separatorBuilder: (context, value) {
                return const Padding(padding: EdgeInsets.only(top: 12));
              },
              itemCount: controller.incomingOrdersList.length,
              itemBuilder: (context, position) {
                return singleIncomingOrder(
                    context, controller.incomingOrdersList[position], () {
                  showBottomSheetIncoingOrders();
                });
              }));
    });
  }

  Widget acceptedOrdersList() {
    return Obx(() {
      return Expanded(
          child: ListView.separated(
              separatorBuilder: (context, value) {
                return const Padding(padding: EdgeInsets.only(top: 12));
              },
              itemCount: controller.acceptedOrdersList.length,
              itemBuilder: (context, position) {
                return singleAcceptedOrder(
                    context, controller.acceptedOrdersList[position], () {
                  showBottomSheetAcceptedOrders();
                });
              }));
    });
  }
}
