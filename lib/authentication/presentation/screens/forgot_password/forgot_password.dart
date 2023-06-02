import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simplibuy/authentication/presentation/screens/custom_widgets.dart';
import 'package:simplibuy/core/error_types/error_types.dart';
import 'package:simplibuy/core/reusable_widgets/reusable_widgets.dart';
import 'package:simplibuy/core/constant.dart';
import 'package:simplibuy/core/state/state.dart';

import '../../screen_model_controllers/forgot_password_controller.dart';

class ForgotPassword extends StatelessWidget {
  ForgotPassword({
    Key? key,
  }) : super(key: key);

  final ForgotPasswordController controller =
      Get.find<ForgotPasswordController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: customAppBar(
            text: "Forgot Password",
            onPressed: () {
              Get.back();
            }),
        body: Container(
          margin: const EdgeInsets.all(defaultPadding),
          child: Column(
            children: [
              heading(),
              const Padding(
                padding: EdgeInsets.only(top: defaultPadding),
              ),
              emailField(),
              const Padding(
                padding: EdgeInsets.only(top: 100.0),
              ),
              submitButton(),
              showLoadingOrServerError(context),
            ],
          ),
        ));
  }

  Widget heading() {
    return Text("Enter the Email Address associated with the account",
        style: TextStyle(color: blackColor, fontSize: smallTextFontSize));
  }

  Widget emailField() {
    return Column(children: [
      Align(
        alignment: Alignment.bottomLeft,
        child: Text("Email Address",
            style: TextStyle(color: blackColor, fontSize: smallerTextFontSize)),
      ),
      Obx(() {
        return TextField(
            onChanged: (email) {
              controller.addEmail(email);
            },
            keyboardType: TextInputType.emailAddress,
            decoration: customInputDecoration(
                hint: 'example@email.com',
                errorText: controller.emailError == ""
                    ? null
                    : controller.emailError));
      })
    ]);
  }

  Widget showLoadingOrServerError(BuildContext context) {
    return Obx(() {
      if (controller.state is LoadingState) {
        return defaultLoading(context);
      }
      if (controller.state == ErrorState(errorType: ServerError())) {
        final err = (controller.state as ErrorState).getErrorMessage();
        errorToast(err);
      }
      return Container();
    });
  }

  Widget submitButton() {
    return defaultButtons(
        pressed: () {
          controller.sendPaswordResetCode();
        },
        text: "Send code");
  }
}
