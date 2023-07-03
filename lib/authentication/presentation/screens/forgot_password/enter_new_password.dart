import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:simplibuy/authentication/presentation/screen_model_controllers/enter_new_password_controller.dart';
import 'package:simplibuy/authentication/presentation/screens/custom_widgets.dart';
import 'package:simplibuy/core/error_types/error_types.dart';
import 'package:simplibuy/core/reusable_widgets/reusable_widgets.dart';
import 'package:simplibuy/core/constant.dart';
import 'package:simplibuy/core/state/state.dart';

class EnterNewPassword extends StatelessWidget {
  EnterNewPassword({
    Key? key,
  }) : super(key: key);

  final EnterNewPasswordController controller =
      Get.find<EnterNewPasswordController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: customAppBar(
            text: "Create new Password",
            onPressed: () {
              Get.back();
            }),
        body: SafeArea(
            child: Container(
          margin: const EdgeInsets.all(defaultPadding),
          child: Column(
            children: [
              heading(),
              const Padding(
                padding: EdgeInsets.only(top: defaultPadding),
              ),
              const Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Enter your new Password",
                    style: TextStyle(
                        color: blackColor,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold),
                  )),
              SizedBox(
                height: 15.h,
              ),
              passwordField(),
              SizedBox(
                height: 15.h,
              ),
              reenterPasswordField(),
              const Padding(
                padding: EdgeInsets.only(top: 100.0),
              ),
              submitButton(),
              showLoadingOrServerError(context),
            ],
          ),
        )));
  }

  Widget heading() {
    return Text("Your new passwords must be different from the previous ones",
        style: TextStyle(color: blackColor, fontSize: smallTextFontSize));
  }

  Widget passwordField() {
    return Column(
      children: [
        Align(
          alignment: Alignment.bottomLeft,
          child: Text('Enter Password',
              style:
                  TextStyle(color: blackColor, fontSize: smallerTextFontSize)),
        ),
        Obx(
          () {
            return TextField(
                onChanged: (value) {
                  controller.addPassword(value);
                },
                obscureText: controller.isVisible,
                keyboardType: TextInputType.visiblePassword,
                decoration: customInputDecoration(
                    icon: InkWell(
                      onTap: controller.changeVisibility,
                      child: Icon(
                        controller.isVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                    ),
                    hint: "123345",
                    errorText: controller.passwordError == ""
                        ? null
                        : controller.passwordError));
          },
        )
      ],
    );
  }

  Widget reenterPasswordField() {
    return Column(
      children: [
        Align(
          alignment: Alignment.bottomLeft,
          child: Text('Confirm Password',
              style:
                  TextStyle(color: blackColor, fontSize: smallerTextFontSize)),
        ),
        Obx(
          () {
            return TextField(
                obscureText: controller.isVisible,
                onChanged: (value) {
                  controller.addPasswordConfirm(value);
                },
                keyboardType: TextInputType.visiblePassword,
                decoration: customInputDecoration(
                    hint: "123345",
                    errorText: controller.passwordConfirmError == ""
                        ? null
                        : controller.passwordConfirmError));
          },
        )
      ],
    );
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
          controller.resetPassword();
        },
        text: "Continue");
  }
}
