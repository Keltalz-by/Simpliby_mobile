import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:get/get.dart';
import 'package:simplibuy/core/constant.dart';
import 'package:simplibuy/core/constants/route_constants.dart';
import 'package:simplibuy/core/reusable_widgets/custom_dialog.dart';
import 'package:simplibuy/core/reusable_widgets/reusable_widgets.dart';

class PaySubScreen extends StatelessWidget {
  final String args = Get.arguments as String;
  PaySubScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(
            top: 60, left: defaultPadding, right: defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Pay with card",
                style: TextStyle(
                    color: blackColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 18)),
            const Padding(padding: EdgeInsets.only(top: 10)),
            Align(
                alignment: Alignment.topLeft,
                child: imageFromAssetsFolder(
                    width: 120.0,
                    height: 50.0,
                    path: 'assets/images/simplibuy_logo_small.png')),
            const Padding(padding: EdgeInsets.only(top: 20)),
            payNowWidget(context)
          ],
        ),
      ),
    );
  }

  Widget _cardIcon() {
    return Row(
      children: const [
        Icon(Icons.local_atm_sharp, color: blueColor),
        SizedBox(width: 10),
        Text(
          "Card",
          style: TextStyle(color: blackColor),
        ),
      ],
    );
  }

  Widget payNowWidget(BuildContext context) {
    return Column(children: [
      Container(
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
              color: Colors.grey.withAlpha(40),
              borderRadius: BorderRadius.all(Radius.circular(8))),
          child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
            _cardIcon(),
            CreditCardForm(
              onCreditCardModelChange: onCreditCardModelChange,
              cardHolderName: '',
              cardNumberDecoration: customInputDecoration(
                  hint: "XXXX XXXX XXXX XXXX", label: "Card Number"),
              cvvCodeDecoration:
                  customInputDecoration(hint: "XXX", label: "CVV"),
              expiryDateDecoration:
                  customInputDecoration(hint: "MM/YY", label: "Expired date"),
              cardHolderDecoration: customInputDecoration(label: "Card holder"),
              formKey: GlobalKey(),
              cvvCode: "",
              themeColor: lightBlueColor,
              cardNumber: "",
              expiryDate: '',
            )
          ])),
      Row(children: [
        Switch(
          value: false,
          onChanged: (bool newValue) {},
        ),
        Text(
          'Remember this card next time',
          style: TextStyle(fontSize: smallTextFontSize),
        ),
      ]),
      const Padding(padding: EdgeInsets.only(top: 30)),
      defaultButtons(
          pressed: () {
            showPaidDialog(context);
          },
          text: "Pay NGN $args")
    ]);
  }
}

void onCreditCardModelChange(CreditCardModel creditCardModel) {
  //cardNumber = creditCardModel.cardNumber;
  //expiryDate = creditCardModel.expiryDate;
  // cardHolderName = creditCardModel.cardHolderName;
  //  cvvCode = creditCardModel.cvvCode;
  //isCvvFocused = creditCardModel.isCvvFocused;
}

void showPaidDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: true,
    barrierColor: const Color.fromARGB(255, 168, 164, 164).withOpacity(0.7),
    builder: (BuildContext context) {
      return CustomDialog(
        callback: () {
          Get.toNamed(SELLER_HOME_PAGE_ROUTE);
        },
        icon: Icons.check_circle_outline_rounded,
        buttonText: "Start Seling",
        textDetail:
            "You have succesfully subscribed for Basic plan package valid for 1 month ",
        iconColor: blueColor,
      );
    },
  );
}
