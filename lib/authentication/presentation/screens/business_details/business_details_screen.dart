import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simplibuy/authentication/presentation/screen_model_controllers/business_reg_controller.dart';
import 'package:simplibuy/authentication/presentation/screens/business_details/custom_widgets.dart';
import 'package:simplibuy/authentication/presentation/screens/custom_widgets.dart';
import 'package:simplibuy/core/constant.dart';
import 'package:simplibuy/core/constants/route_constants.dart';
import 'package:simplibuy/core/error_types/error_types.dart';
import 'package:simplibuy/core/reusable_widgets/custom_dialog.dart';
import 'package:simplibuy/core/reusable_widgets/custom_dialog_two_button.dart';
import 'package:simplibuy/core/reusable_widgets/custom_loading_dialog.dart';
import 'package:simplibuy/core/reusable_widgets/reusable_widgets.dart';
import 'package:simplibuy/core/state/state.dart';

class BusinessDetailsScreen extends StatelessWidget {
  BusinessDetailsScreen({Key? key}) : super(key: key);

  final padding = const Padding(padding: EdgeInsets.only(top: 10));
  final BusinessRegController controller = Get.find<BusinessRegController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      padding: const EdgeInsets.only(top: 50, left: 15, right: 15, bottom: 20),
      child: SingleChildScrollView(child: showInputFields(context)),
    ));
  }

  Widget showInputFields(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        header(),
        const Text("We want to verify that you own a store",
            style: TextStyle(
                color: blueColor,
                fontSize: smallTextFontSize,
                fontWeight: FontWeight.w400)),
        padding,
        Obx(() {
          return textFieldWithHeader(
              errorText:
                  controller.nameError == "" ? null : controller.nameError,
              hintText: "eg. Simbi's enterprice",
              title: "Business Name",
              onChanged: (value) {
                controller.addName(value);
              });
        }),
        padding,
        Obx(() {
          return textFieldWithHeader(
              errorText: controller.locationError == ""
                  ? null
                  : controller.locationError,
              hintText: "eg. Enugu, Nigeria",
              title: "Business Location",
              onChanged: (value) {
                controller.addLocation(value);
              });
        }),
        padding,
        Obx(() {
          return textFieldWithHeader(
              errorText:
                  controller.descError == "" ? null : controller.descError,
              hintText: "eg. We specialize in selling beauty soaps",
              title: "Brief description about your business",
              onChanged: (value) {
                controller.addDesc(value);
              },
              lines: 6);
        }),
        padding,
        Obx(() {
          return textFieldWithHeader(
              errorText: controller.addressError == ""
                  ? null
                  : controller.addressError,
              hintText: "eg. Plot 13 New Heaven, Enugu",
              title: "Store Address",
              onChanged: (value) {
                controller.addAddress(value);
              });
        }),
        padding,
        Obx(() {
          return textFieldWithHeader(
            errorText: controller.cityError == "" ? null : controller.cityError,
            hintText: "eg. Enugu State",
            title: "Store City",
            onChanged: (value) {
              controller.addCity(value);
            },
          );
        }),
        padding,
        country(context, "Country", (value) {
          controller.setCountry(value);
        }),
        padding,
        Obx(() {
          return imageUpload(
              context: context,
              title: "Upload Images of your store",
              onClick: () {
                controller.uploadBusinessImages();
              },
              infoText: controller.areImagesSelected
                  ? "${controller.images.length} images selected"
                  : "No Images Selected");
        }),
        padding,
        Obx(() {
          return imageUpload(
              context: context,
              title: "Upload logo of your store",
              onClick: () {
                controller.uploadImageLogo();
              },
              infoText: controller.areImagesSelected
                  ? "logo uploaded"
                  : "No Image Selected");
        }),
        padding,
        defaultButtons(
            pressed: () {
              controller.registerBusiness();
              Get.dialog(showCustomDialog(context), barrierDismissible: true);
            },
            text: "Submit"),
      ],
    );
  }

  Widget showCustomDialog(BuildContext context) {
    return Obx(() {
      if (controller.state is FinishedState) {
        return CustomDialog(
          callback: () {
            Get.toNamed(PLAN_CHOICE_SCREEN);
          },
          icon: Icons.check_circle_outline_rounded,
          buttonText: "Start Seling",
          textDetail: "Congratulations, you have successfully been verified",
          iconColor: blueColor,
        );
      } else if (controller.state is LoadingState) {
        return CustomLoadingDialog();
      } else if (controller.state == ErrorState(errorType: ServerError())) {
        return CustomDialog(
          callback: () {
            Get.reloadAll();
          },
          icon: Icons.cancel_outlined,
          buttonText: "Back",
          textDetail: (controller.state as ErrorState).getErrorMessage(),
          iconColor: Colors.red,
        );
      } else if (controller.state == ErrorState(errorType: InternetError())) {
        return CustomDialog(
          callback: () {
            controller.refresh();
          },
          icon: Icons.cancel_outlined,
          buttonText: "Back",
          textDetail: "No Internet Connection",
          iconColor: Colors.red,
        );
      } else {
        return Container();
      }
    });
  }
}
