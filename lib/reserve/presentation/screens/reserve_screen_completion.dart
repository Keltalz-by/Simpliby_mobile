// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_credit_card/credit_card_form.dart';
import 'package:flutter_credit_card/credit_card_model.dart';
import 'package:get/get.dart';
import 'package:simplibuy/core/constant.dart';
import 'package:simplibuy/core/reusable_widgets/reusable_widgets.dart';
import 'package:simplibuy/reserve/presentation/controllers/reserve_controller.dart';

class ReserveScreenCompletion extends StatelessWidget {
  ReserveScreenCompletion({Key? key}) : super(key: key);

  ReserveController controller = Get.find<ReserveController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: customAppBar(text: "Reserve", onPressed: () {}),
        body: SingleChildScrollView(
          child: Container(
              padding: const EdgeInsets.all(10),
              child:
                  Column(mainAxisAlignment: MainAxisAlignment.start, children: [
                const Text(
                  'Preferred means of payment',
                  style: TextStyle(color: lightBlueColor, fontSize: 14),
                ),
                Obx(() {
                  return RadioListTile(
                    value: 1,
                    groupValue: controller.selectedRadio,
                    title: const Text(
                      'Pay now',
                      style: TextStyle(fontSize: smallTextFontSize),
                    ),
                    onChanged: (val) =>
                        controller.changeSelectedRadio(val as int),
                  );
                }),
                Obx(() {
                  return RadioListTile(
                    value: 2,
                    groupValue: controller.selectedRadio,
                    title: const Text(
                      'Pay on arrival',
                      style: TextStyle(fontSize: smallTextFontSize),
                    ),
                    onChanged: (val) =>
                        controller.changeSelectedRadio(val as int),
                  );
                }),
                const Padding(padding: EdgeInsets.only(top: defaultPadding)),
                Obx(() {
                  return Opacity(
                      opacity: controller.selectedRadio == 1 ? 1 : 0.5,
                      child: Container(
                          padding: const EdgeInsets.all(5),
                          decoration: const BoxDecoration(
                              color: Color.fromARGB(255, 224, 221, 221),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8))),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                cardIcon(),
                                CreditCardForm(
                                  onCreditCardModelChange:
                                      onCreditCardModelChange,
                                  cardHolderName: '',
                                  cardNumberDecoration: customInputDecoration(
                                      hint: "XXXX XXXX XXXX XXXX",
                                      label: "Card Number"),
                                  cvvCodeDecoration: customInputDecoration(
                                      hint: "XXX", label: "CVV"),
                                  expiryDateDecoration: customInputDecoration(
                                      hint: "MM/YY", label: "Expired date"),
                                  cardHolderDecoration: customInputDecoration(
                                      label: "Card holder"),
                                  formKey: GlobalKey(),
                                  cvvCode: "",
                                  themeColor: lightBlueColor,
                                  cardNumber: "",
                                  expiryDate: '',
                                )
                              ])));
                }),
                Obx(() {
                  return Opacity(
                      opacity: controller.selectedRadio == 1 ? 1 : 0.5,
                      child: Row(
                        children: [
                          Switch(
                            value: false,
                            onChanged: (bool newValue) {},
                          ),
                          Text(
                            'Remember this card next time',
                            style: TextStyle(fontSize: smallTextFontSize),
                          ),
                        ],
                      ));
                }),
                paddingOnly(top: 10),
                defaultButtons(pressed: () {}, text: "Proceed")
              ])),
        ));
  }

  Widget cardIcon() {
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

  void onCreditCardModelChange(CreditCardModel creditCardModel) {
    //cardNumber = creditCardModel.cardNumber;
    //expiryDate = creditCardModel.expiryDate;
    // cardHolderName = creditCardModel.cardHolderName;
    //  cvvCode = creditCardModel.cvvCode;
    //isCvvFocused = creditCardModel.isCvvFocused;
  }
}
