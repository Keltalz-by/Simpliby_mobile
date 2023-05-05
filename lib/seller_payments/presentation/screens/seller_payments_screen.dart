import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simplibuy/core/constant.dart';
import 'package:simplibuy/core/constants/route_constants.dart';
import 'package:simplibuy/core/error_types/error_types.dart';
import 'package:simplibuy/core/reusable_widgets/reusable_widgets.dart';
import 'package:simplibuy/core/state/state.dart';
import 'package:simplibuy/seller_payments/presentation/controllers/seller_payment_controller.dart';
import 'package:simplibuy/seller_payments/presentation/screens/custom_widgets.dart';
import 'package:simplibuy/seller_payments/presentation/screens/seller_payments_all_orders_screen.dart';

// ignore: must_be_immutable
class SellerPaymentsScreen extends StatelessWidget {
  SellerPaymentsScreen({Key? key}) : super(key: key);

  SellerPaymentController controller = Get.find<SellerPaymentController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
          text: "",
          onPressed: () {
            Get.back();
          },
          actions: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
              IconButton(
                  onPressed: () {
                    Get.toNamed(ADD_BANK_SCREEN);
                  },
                  icon: const Icon(
                    Icons.add_box_outlined,
                    color: blackColor,
                  )),
              const Text(
                "Add Bank",
                style:
                    TextStyle(color: blackColor, fontSize: smallTextFontSize),
              ),
              const Padding(padding: EdgeInsets.only(left: 10))
            ])
          ]),
      body: Container(
        padding: const EdgeInsets.only(
          left: defaultPadding,
          right: defaultPadding,
          bottom: defaultPadding,
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          showTotalAmoundSold(context),
          const Padding(padding: EdgeInsets.only(top: 10)),
          defaultButtons(
              pressed: () {
                Get.toNamed(WITHDRAWAL_SCREEN);
              },
              text: "Withdraw",
              size: const Size(120, 40)),
          const Padding(padding: EdgeInsets.only(top: 5)),
          orderButtons(context),
          const Padding(padding: EdgeInsets.only(top: 10)),
          transactionButton(),
          showResult(context)
        ]),
      ),
    );
  }

  Widget showResult(BuildContext context) {
    return Obx(() {
      if (controller.state is FinishedState) {
        return Expanded(
            child: ListView.separated(
                itemBuilder: (value, index) {
                  return singleTransaction(context, controller.orderList[index],
                      controller.isPaid ? Colors.green : Colors.yellow);
                },
                separatorBuilder: (context, index) {
                  return const Padding(padding: EdgeInsets.only(top: 5));
                },
                itemCount: controller.orderList.length));
      }
      if (controller.state is LoadingState) {
        return defaultLoading(context);
      }
      if (controller.state == ErrorState(errorType: EmptyListError())) {
        return const Center(
            child: Text(
          "No transactions yet",
          style: TextStyle(fontSize: smallTextFontSize),
        ));
      }
      if (controller.state == ErrorState(errorType: InternetError())) {
        return noInternetConnection(context);
      } else {
        return Container();
      }
    });
  }

  Widget transactionButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text(
          "Transactions",
          style: TextStyle(fontSize: smallTextFontSize),
        ),
        GestureDetector(
          child: const Text(
            "View all",
            style: TextStyle(fontSize: smallerTextFontSize),
          ),
          onTap: () {
            Get.to(SellerAllPaymentsScreen());
          },
        )
      ],
    );
  }

  Widget showTotalAmoundSold(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(defaultPadding),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.22,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            blueColor,
            Color.fromARGB(255, 3, 89, 160),
            Color.fromARGB(255, 14, 141, 245),
            Color.fromARGB(255, 116, 182, 236)
          ],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  "Total amount sold",
                  style: TextStyle(
                      color: whiteColor, fontSize: smallerTextFontSize),
                ),
                Text(
                  "This month ",
                  style: TextStyle(
                      color: whiteColor, fontSize: smallerTextFontSize),
                )
              ]),
          const Padding(padding: EdgeInsets.only(top: 10)),
          const Text(
            "\$30,000",
            style: TextStyle(
                color: whiteColor, fontSize: 32, fontWeight: FontWeight.bold),
          ),
          const Padding(padding: EdgeInsets.only(top: 30)),
          const Text(
            "Roban stores",
            style: TextStyle(color: whiteColor, fontSize: smallerTextFontSize),
          )
        ],
      ),
    );
  }

  Widget orderButtons(BuildContext context) {
    return Container(
        width: 290,
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
                width: 130,
                alignment: Alignment.center,
                padding: const EdgeInsets.all(6.0),
                decoration: BoxDecoration(
                  color: whiteColor,
                  borderRadius: BorderRadius.circular(2.0),
                ),
                child: GestureDetector(onTap: () {
                  controller.getPaidOrders();
                }, child: Obx(() {
                  return Text(
                    "Paid Orders",
                    style: TextStyle(
                      fontSize: 18.0,
                      color: controller.isPaid
                          ? blueColor
                          : blackColor.withOpacity(0.8),
                      fontWeight: FontWeight.bold,
                    ),
                  );
                })),
              ),
              const Padding(padding: EdgeInsets.only(left: 6)),
              Container(
                width: 130,
                alignment: Alignment.center,
                padding: const EdgeInsets.all(6.0),
                decoration: BoxDecoration(
                  color: whiteColor,
                  borderRadius: BorderRadius.circular(2.0),
                ),
                child: GestureDetector(onTap: () {
                  controller.getUnpaidOrders();
                }, child: Obx(() {
                  return Text(
                    "Unpaid Orders",
                    style: TextStyle(
                      fontSize: 18.0,
                      color: controller.isPaid
                          ? blackColor.withOpacity(0.8)
                          : blueColor,
                      fontWeight: FontWeight.bold,
                    ),
                  );
                })),
              )
            ]));
  }
}
