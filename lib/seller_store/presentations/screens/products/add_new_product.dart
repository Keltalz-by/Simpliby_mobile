import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:simplibuy/core/state/state.dart';
import 'package:simplibuy/seller_store/presentations/controllers/add_new_product_controller.dart';
import 'package:simplibuy/authentication/presentation/screens/business_details/custom_widgets.dart';
import 'package:simplibuy/core/constant.dart';
import 'package:simplibuy/core/constants/route_constants.dart';
import 'package:simplibuy/core/reusable_widgets/custom_dialog.dart';
import 'package:simplibuy/core/reusable_widgets/reusable_widgets.dart';
import 'package:simplibuy/seller_store/presentations/screens/products/categories_drop_down.dart';

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
          child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: showInputFields(context))),
    );
  }

  Widget showInputFields(BuildContext context) {
    return Column(
      children: [
        textFieldWithHeader2(
          title: "What do you want to sell?",
          controller: controller.name,
          hintText: "eg. XYZ biscuit",
        ),
        padding,
        textFieldWithHeader2(
          title: "Product description",
          controller: controller.desc,
          hintText: "eg. 80kg made with milk and ice",
        ),
        padding,
        textFieldWithHeader2(
          title: "Item location (Optional)",
          controller: controller.location,
          hintText: "eg. Line A1 track B22",
        ),
        padding,
        textFieldWithHeader2(
            title: "Item Price",
            controller: controller.price,
            hintText: "eg. 500",
            type: TextInputType.number),
        padding,
        textFieldWithHeader2(
            title: "Reservation price per product ",
            controller: controller.priceRes,
            type: TextInputType.number,
            hintText: "eg. 20"),
        padding,
        Align(
            alignment: Alignment.topLeft,
            child: Text(
              "Product Category",
              style: TextStyle(fontSize: 18.sp),
            )),
        Obx(() => controller.isCategoriesRetrieved.value == true
            ? CustomDropdown(
                items: controller.categories,
                value: controller.selectedCategory.value,
                hintText: "Select a Category",
                onChanged: (newValue) {
                  controller.selectedCategory.value = newValue!;
                },
              )
            : Container()),
        padding,
        browseFileUpload("Upload Image of item", () {
          controller.uploadProductImages();
        }),
        padding,
        browseFileUpload2("Upload Image of rack (optional)", () {
          controller.uploaRackImage();
        }),
        padding,
        Obx(() => controller.state is LoadingState
            ? defaultLoading(context)
            : Container()),
        padding,
        defaultButtons(
            pressed: () {
              controller.addNewProduct();
            },
            text: "Submit"),
        Obx(() => controller.state is FinishedState
            ? showCongratulationsDialog()
            : Container())
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
      const Padding(padding: EdgeInsets.only(top: 5)),
      Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
                width: 140,
                height: 50,
                decoration: BoxDecoration(
                    border: Border.all(
                      width: 2,
                      color: blueColor,
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(5))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Obx(() => !controller.areImagesSelected
                        ? Text("Browse file",
                            style: TextStyle(
                                color: blueColor,
                                fontSize: smallTextFontSize,
                                fontWeight: FontWeight.normal))
                        : Expanded(
                            child: Text("  Image upload success",
                                style: TextStyle(
                                    color: Colors.red,
                                    fontSize: smallTextFontSize,
                                    fontWeight: FontWeight.normal)))),
                    Obx(() => !controller.areImagesSelected
                        ? const Icon(
                            Icons.download_sharp,
                            size: 29,
                          )
                        : Container()),
                  ],
                )),
            defaultButtons(
                pressed: onClick, text: "Upload", size: const Size(100, 40)),
          ])
    ]);
  }

  Widget browseFileUpload2(String title, VoidCallback onClick) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(
        title,
        textAlign: TextAlign.start,
        style: const TextStyle(fontSize: 14),
      ),
      const Padding(padding: EdgeInsets.only(top: 5)),
      Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
                width: 140,
                height: 50,
                decoration: BoxDecoration(
                    border: Border.all(
                      width: 2,
                      color: blueColor,
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(5))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Obx(() => !controller.isLogoSelected
                        ? Text("Browse file",
                            style: TextStyle(
                                color: blueColor,
                                fontSize: smallTextFontSize,
                                fontWeight: FontWeight.normal))
                        : Expanded(
                            child: Text("  Image upload success",
                                style: TextStyle(
                                    color: Colors.red,
                                    fontSize: smallTextFontSize,
                                    fontWeight: FontWeight.normal)))),
                    Obx(() => !controller.isLogoSelected
                        ? const Icon(
                            Icons.download_sharp,
                            size: 29,
                          )
                        : Container()),
                  ],
                )),
            defaultButtons(
                pressed: onClick, text: "Upload", size: const Size(100, 40)),
          ])
    ]);
  }

  showCongratulationsDialog() {
    Get.dialog(CustomDialog(
      callback: () {
        Get.toNamed(SELLER_PRODUCT_CATEGORIES);
      },
      icon: Icons.check_circle_outline_rounded,
      buttonText: "View product",
      textDetail: "Your product has been added",
      iconColor: blueColor,
    ));
  }
}
