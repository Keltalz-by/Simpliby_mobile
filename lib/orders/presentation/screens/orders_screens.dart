import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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

  showBottomSheetIncoingOrders(BuildContext context) {
    Get.bottomSheet(showStates(context));
  }

  Widget showStates(BuildContext context) {
    return Obx(() {
      if (controller.stateOrderDetails is LoadingState) {
        return defaultLoading(context);
      }
      if (controller.stateOrderDetails is FinishedState) {
        return incomingOrdersBottomSheet(() {
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
        });
      } else {
        return Container();
      }
    });
  }

  Widget orderButtons(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width * 0.82,
        padding: EdgeInsets.symmetric(vertical: 6.h),
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.6),
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Obx(() => Container(
                    width: MediaQuery.of(context).size.width * 0.40,
                    padding: const EdgeInsets.all(6.0),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: controller.isIncoming
                          ? whiteColor
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: GestureDetector(
                        onTap: () {
                          controller.getIncomingOrders();
                        },
                        child: Text(
                          "Incoming orders",
                          style: TextStyle(
                            fontSize: 18.sp,
                            color: controller.isIncoming
                                ? blueColor
                                : blackColor.withOpacity(0.8),
                            fontWeight: FontWeight.w500,
                          ),
                        )),
                  )),
              const Padding(padding: EdgeInsets.only(left: 6)),
              Obx(() => Container(
                    padding: const EdgeInsets.all(6.0),
                    width: MediaQuery.of(context).size.width * 0.38,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: !controller.isIncoming
                          ? whiteColor
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: GestureDetector(
                        onTap: () {
                          controller.getAcceptedOrders();
                        },
                        child: Text(
                          "Accepted Orders",
                          style: TextStyle(
                            fontSize: 18.sp,
                            color: controller.isIncoming
                                ? blackColor.withOpacity(0.8)
                                : blueColor,
                            fontWeight: FontWeight.w500,
                          ),
                        )),
                  ))
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
                  controller.getInOrderDetails();
                  showBottomSheetIncoingOrders(context);
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
