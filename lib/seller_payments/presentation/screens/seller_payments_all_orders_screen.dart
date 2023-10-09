import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simplibuy/core/constant.dart';
import 'package:simplibuy/core/error_types/error_types.dart';
import 'package:simplibuy/core/reusable_widgets/reusable_widgets.dart';
import 'package:simplibuy/core/state/state.dart';
import 'package:simplibuy/seller_payments/presentation/controllers/seller_payment_controller.dart';
import 'package:simplibuy/seller_payments/presentation/screens/custom_widgets.dart';

class SellerAllPaymentsScreen extends StatelessWidget {
  SellerAllPaymentsScreen({Key? key}) : super(key: key);

  final SellerPaymentController controller =
      Get.find<SellerPaymentController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        text: "Orders",
        onPressed: () {
          Get.back();
        },
      ),
      body: Container(
        padding: const EdgeInsets.only(
          left: defaultPadding,
          right: defaultPadding,
          bottom: defaultPadding,
        ),
        child: showResult(context),
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
        return Center(
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
}
