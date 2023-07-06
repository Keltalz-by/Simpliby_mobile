import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:simplibuy/buyer_home/presentation/screens/custom_widgets.dart';
import 'package:simplibuy/core/constant.dart';
import 'package:simplibuy/core/constants/route_constants.dart';
import 'package:simplibuy/core/utils/utils.dart';
import 'package:simplibuy/seller_home/presentation/screens/custom_widgets.dart';

class SellerHomeScreen extends StatefulWidget {
  const SellerHomeScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _MyWidgetState createState() => _MyWidgetState();
}

class _MyWidgetState extends State<SellerHomeScreen> {
  bool isAvailable = false;

  void _toggleAvailability(bool newValue) {
    setState(() {
      isAvailable = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: whiteColor.withAlpha(80),
        appBar: sellerhomeAppBar(
            text: greeting(),
            name: "Roban Stores",
            onPressed: () {
              Get.toNamed(NOTIFICATION_SCREEN);
            }),
        body: SafeArea(
            child: SingleChildScrollView(
                child: Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(defaultPadding),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          "Ready to make some cool cash today?",
                          style: TextStyle(
                              color: blackColor,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                        const Padding(padding: EdgeInsets.only(top: 20)),
                        availabilitySwitch(context),
                        const Padding(padding: EdgeInsets.only(top: 20)),
                        optionsToClick(context),
                        mostPurchasedProducts()
                      ],
                    )))));
  }

  Widget availabilitySwitch(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.7,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            blurRadius: 4.0,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Available",
            style: TextStyle(fontSize: 16.0),
          ),
          const SizedBox(width: 8.0),
          Switch(
            value: isAvailable,
            onChanged: (value) => {_toggleAvailability(value)},
          ),
          const SizedBox(width: 16.0),
          const Text(
            "Unavailable",
            style: TextStyle(fontSize: 16.0),
          ),
        ],
      ),
    );
  }

  Widget optionsToClick(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // rgba(100, 188, 244, 0.3)

            customContainer(
                MediaQuery.of(context).size.width * 0.4,
                Color.fromARGB(255, 187, 225, 248),
                Color.fromRGBO(100, 188, 244, 1),
                Icons.person_add_alt_1_outlined,
                "Orders",
                "View incoming orders, Accept or reject orders.", () {
              Get.toNamed(ORDERS_SCREEN);
            }),
            customContainer(
                MediaQuery.of(context).size.width * 0.4,
                Color.fromARGB(255, 148, 241, 164),
                Color.fromRGBO(17, 255, 55, 1),
                Icons.production_quantity_limits,
                "Add Product",
                "Add new products to be displayed.", () {
              Get.toNamed(ADD_NEW_PRODUCT);
            })
          ],
        ),
        const Padding(padding: EdgeInsets.only(top: 20)),
        customContainer(
            MediaQuery.of(context).size.width,
            Color.fromARGB(255, 247, 169, 173),
            Color(0xffFA0611),
            Icons.card_giftcard,
            "View Products",
            "View your products to see your items displayed.", () {
          Get.toNamed(SELLER_PRODUCT_CATEGORIES);
        }),
        const Padding(padding: EdgeInsets.only(top: 20)),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            customContainer(
                MediaQuery.of(context).size.width * 0.4,
                Color.fromARGB(255, 245, 222, 138),
                const Color(0xffEBB90A),
                Icons.task_alt_outlined,
                "Records",
                "View your daily transactions and take records.", () {
              Get.toNamed(HISTORY_SCREEN);
            }),
            customContainer(
                MediaQuery.of(context).size.width * 0.4,
                Color.fromARGB(255, 245, 222, 138),
                const Color(0xffEBB90A),
                Icons.payment_outlined,
                "Payments",
                "Withdraw your money or view your financial transactions", () {
              Get.toNamed(SELLER_PAYMENTS);
            })
          ],
        ),
      ],
    );
  }

  Widget mostPurchasedProducts() {
    return Container();
  }
}

Widget customContainer(double width, Color color, Color borderColor,
    IconData icon, String text, String details, VoidCallback onClick) {
  return GestureDetector(
      onTap: () {
        onClick();
      },
      child: Container(
        width: width,
        height: 200.h,
        padding: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.9),
              offset: const Offset(0, 2),
            ),
          ],
          border: Border.all(
            color: borderColor,
            width: 1.2,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              icon,
              size: 30.0,
              color: blackColor,
            ),
            SizedBox(height: 16.h),
            Text(
              text,
              textAlign: TextAlign.start,
              style: TextStyle(
                fontSize: 18.sp,
                color: blackColor,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 16.h),
            Text(
              details,
              textAlign: TextAlign.start,
              style: TextStyle(
                fontSize: 15.sp,
                color: blackColor,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ));
}
