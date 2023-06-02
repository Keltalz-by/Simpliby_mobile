import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:simplibuy/authentication/presentation/screen_model_controllers/verify_email_controller.dart';
import 'package:simplibuy/authentication/presentation/screens/custom_widgets.dart';
import 'package:simplibuy/core/constants/route_constants.dart';
import 'package:simplibuy/core/error_types/error_types.dart';
import 'package:simplibuy/core/reusable_widgets/custom_dialog.dart';
import 'package:simplibuy/core/reusable_widgets/reusable_widgets.dart';
import 'package:simplibuy/core/constant.dart';
import 'package:simplibuy/core/state/state.dart';

class VerifyEmail extends StatelessWidget {
  VerifyEmail({
    Key? key,
  }) : super(key: key);

  final controller = Get.find<VerifyEmailController>();
  final String email = Get.arguments as String;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: customAppBar(
            text: "Verification",
            onPressed: () {
              Get.back();
            }),
        body: SafeArea(
            child: Container(
          margin: const EdgeInsets.symmetric(horizontal: defaultPadding),
          child: SingleChildScrollView(
            child: Column(
              children: [
                notice(),
                Padding(
                  padding: EdgeInsets.only(top: 50.h),
                ),
                showConnectionError(context),
                inputPin((data) {}, context),
                Text("00:20",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: blackColor, fontSize: smallTextFontSize)),
                SizedBox(
                  height: 10.h,
                ),
                InkWell(
                    onTap: () {
                      controller.resendOtp(email);
                    },
                    child: Text("Resend Otp",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: blackColor, fontSize: smallTextFontSize))),
                SizedBox(
                  height: 60.h,
                ),
                continueButton(context),
                showLoadingOrServerError(context),
                Obx(() {
                  if (controller.state is FinishedState) {
                    showVerifiedDialog(context);
                  }
                  return Container();
                })
              ],
            ),
          ),
        )));
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

  Widget showConnectionError(BuildContext context) {
    return Obx(() {
      if (controller.state == ErrorState(errorType: InternetError())) {
        return noInternetConnection(context);
      }
      return const Padding(
        padding: EdgeInsets.only(top: 15.0),
      );
    });
  }

  Widget notice() {
    return Align(
        alignment: Alignment.bottomLeft,
        child: Text("We sent a code to your email Address",
            textAlign: TextAlign.center,
            style: TextStyle(color: blackColor, fontSize: smallTextFontSize)));
  }

  Widget inputPin(ValueChanged output, BuildContext context) {
    return Column(
      children: [
        Text("Enter your OTP code here",
            textAlign: TextAlign.center,
            style: TextStyle(color: blackColor, fontSize: smallTextFontSize)),
        const Padding(padding: EdgeInsets.only(top: 10.0)),
        PinCodeTextField(
          appContext: context,
          pinTheme: PinTheme(
            shape: PinCodeFieldShape.box,
            borderRadius: BorderRadius.circular(5),
            fieldHeight: 60,
            errorBorderColor: Colors.red,
            fieldWidth: 50,
            disabledColor: lightBlueColor,
            inactiveColor: lightBlueColor,
            activeFillColor: lightBlueColor,
          ),
          cursorColor: Colors.black,
          length: 4,
          keyboardType: TextInputType.text,
          textStyle: const TextStyle(
            fontSize: 30.0,
            fontWeight: FontWeight.bold,
          ),
          onChanged: (value) {
            controller.addCode(value);
          },
        )
      ],
    );
  }

  Widget continueButton(BuildContext context) {
    return defaultButtons(
        pressed: () {
          controller.verifyEmail(email);
        },
        text: "Continue");
  }
}

void showVerifiedDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: true,
    barrierColor: const Color.fromARGB(255, 168, 164, 164).withOpacity(0.7),
    builder: (BuildContext context) {
      return CustomDialog(
        callback: () {
          Get.delete<VerifyEmailController>();
          Get.offAllNamed(LOGIN_ROUTE);
        },
        icon: Icons.check_circle_outline_rounded,
        buttonText: "Continue",
        textDetail:
            "You have succesfully verified your Email addrress, you can now log in",
        iconColor: blueColor,
      );
    },
  );
}
