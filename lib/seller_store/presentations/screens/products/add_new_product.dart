import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simplibuy/seller_store/presentations/controllers/add_new_product_controller.dart';
import 'package:simplibuy/authentication/presentation/screens/business_details/custom_widgets.dart';
import 'package:simplibuy/core/constant.dart';
import 'package:simplibuy/core/constants/route_constants.dart';
import 'package:simplibuy/core/reusable_widgets/custom_dialog.dart';
import 'package:simplibuy/core/reusable_widgets/reusable_widgets.dart';

class AddNewProductScreen extends StatelessWidget {
  AddNewProductScreen({Key? key}) : super(key: key);
  final padding = const Padding(padding: EdgeInsets.only(top: 10));

  final AddNewProductController controller =
      Get.find<AddNewProductController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
          text: "Upload product",
          onPressed: () {
            Get.back();
          }),
      body: Container(
          padding: const EdgeInsets.all(defaultPadding),
          child: SingleChildScrollView(child: showInputFields(context))),
    );
  }

  Widget showInputFields(BuildContext context) {
    return Column(
      children: [
        Obx(() {
          return textFieldWithHeader(
              title: "What do you want to sell?",
              onChanged: (value) {
                controller.addName(value);
              },
              hintText: "eg. XYZ biscuit",
              errorText:
                  controller.nameError == "" ? null : controller.nameError);
        }),
        padding,
        Obx(() {
          return textFieldWithHeader(
              title: "Product description",
              onChanged: (value) {
                controller.addDesc(value);
              },
              hintText: "eg. 80kg made with milk and ice",
              errorText:
                  controller.descError == "" ? null : controller.descError);
        }),
        padding,
        Obx(() {
          return textFieldWithHeader(
              title: "Item location (Optional)",
              onChanged: (value) {
                controller.addLocation(value);
              },
              hintText: "eg. Line A1 track B22",
              errorText: controller.locationError == ""
                  ? null
                  : controller.locationError);
        }),
        padding,
        textFieldWithHeader(
            title: "Currency",
            onChanged: (value) {},
            hintText: "NGN (Naira)",
            errorText: null),
        padding,
        Obx(() {
          return textFieldWithHeader(
              title: "Item Price",
              onChanged: (value) {
                controller.addPrice(value);
              },
              hintText: "eg. 500",
              errorText:
                  controller.priceError == "" ? null : controller.priceError);
        }),
        padding,
        Obx(() {
          return textFieldWithHeader(
              title: "Reservation price per product ",
              onChanged: (value) {
                controller.addPriceRes(value);
              },
              hintText: "eg. 20",
              errorText: controller.priceResError == ""
                  ? null
                  : controller.priceResError);
        }),
        padding,
        textFieldWithHeader(
            title: "Product category",
            onChanged: (value) {},
            hintText: "Cosmetics",
            errorText: null),
        padding,
        browseFileUpload("Upload Image of item", () {
          controller.uploadProductImages();
        }),
        padding,
        browseFileUpload("Upload Image of rack (optional)", () {
          controller.uploaRackImage();
        }),
        padding,
        defaultButtons(
            pressed: () {
              showCongratulationsDialog(context);
            },
            text: "Submit")
      ],
    );
  }

  Widget browseFileUpload(String title, VoidCallback onClick) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(
        title,
        textAlign: TextAlign.start,
        style: const TextStyle(fontSize: 14),
      ),
      const Padding(padding: EdgeInsets.only(top: 10)),
      Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
                width: 140, // Set the width of the container
                height: 50,
                decoration: BoxDecoration(
                    border: Border.all(
                      width: 2,
                      color: blueColor, // set border color here
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(5))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("Browse file",
                        style: TextStyle(
                            color: blueColor,
                            fontSize: smallTextFontSize,
                            fontWeight: FontWeight.normal)),
                    const Icon(
                      Icons.download_sharp,
                      size: 29,
                    ),
                  ],
                )),
            defaultButtons(
                pressed: onClick, text: "Upload", size: const Size(100, 40))
          ])
    ]);
  }

  void showCongratulationsDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true,
      barrierColor: const Color.fromARGB(255, 168, 164, 164).withOpacity(0.7),
      builder: (BuildContext context) {
        return CustomDialog(
          callback: () {
            Get.toNamed(SELLER_PRODUCT_CATEGORIES);
          },
          icon: Icons.check_circle_outline_rounded,
          buttonText: "View product",
          textDetail: "Your product has been added",
          iconColor: blueColor,
        );
      },
    );
  }
}
