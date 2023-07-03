import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simplibuy/buyer_home/presentation/screens/custom_widgets.dart';
import 'package:simplibuy/core/constant.dart';
import 'package:simplibuy/core/constants/route_constants.dart';
import 'package:simplibuy/core/utils/utils.dart';

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
        //    appBar: homeAppBar(
        //    text: greeting(),
        //      onPressed: () {
        //    Get.toNamed(NOTIFICATION_SCREEN);
        //    }),
        body: Container(
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
            )));
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
            customContainer(
                MediaQuery.of(context).size.width * 0.4,
                Color.fromARGB(255, 188, 217, 240),
                Icons.person_add_alt_1_outlined,
                "Orders", () {
              Get.toNamed(ORDERS_SCREEN);
            }),
            customContainer(
                MediaQuery.of(context).size.width * 0.4,
                Color.fromARGB(255, 189, 231, 191),
                Icons.production_quantity_limits,
                "Add New Product", () {
              Get.toNamed(ADD_NEW_PRODUCT);
            })
          ],
        ),
        const Padding(padding: EdgeInsets.only(top: 20)),
        customContainer(
            MediaQuery.of(context).size.width,
            Color.fromARGB(255, 236, 187, 183),
            Icons.card_giftcard,
            "View Products", () {
          Get.toNamed(SELLER_PRODUCT_CATEGORIES);
        }),
        const Padding(padding: EdgeInsets.only(top: 20)),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            customContainerInv(
                MediaQuery.of(context).size.width * 0.4,
                const Color.fromARGB(255, 137, 192, 238),
                Icons.task_alt_outlined,
                "Records", () {
              Get.toNamed(HISTORY_SCREEN);
            }),
            customContainerInv(
                MediaQuery.of(context).size.width * 0.4,
                const Color.fromARGB(255, 137, 192, 238),
                Icons.payment_outlined,
                "Payments", () {
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

Widget customContainer(double width, Color color, IconData icon, String text,
    VoidCallback onClick) {
  return GestureDetector(
      onTap: () {
        onClick();
      },
      child: Container(
        width: width,
        height: 130,
        padding: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 4.0,
              offset: const Offset(0, 2),
            ),
          ],
          border: Border.all(
            color: blueColor.withOpacity(0.7),
            width: 2.0,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 30.0,
              color: blackColor,
            ),
            SizedBox(height: 16.0),
            Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24.0,
                color: blackColor.withOpacity(0.8),
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ));
}

Widget customContainerInv(double width, Color color, IconData icon, String text,
    VoidCallback onClick) {
  return GestureDetector(
      onTap: () {
        onClick();
      },
      child: Container(
        width: width,
        padding: EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(
            color: blueColor.withOpacity(0.7),
            width: 2.0,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 3.0,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text,
              style: TextStyle(
                fontSize: 24.0,
                color: blackColor.withOpacity(0.8),
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.0),
            Icon(
              icon,
              size: 30.0,
              color: blackColor,
            ),
          ],
        ),
      ));
}
