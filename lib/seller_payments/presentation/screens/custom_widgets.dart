import 'package:flutter/material.dart';
import 'package:simplibuy/core/constant.dart';
import 'package:simplibuy/seller_payments/data/models/payment_orders.dart';

Widget singleTransaction(
    BuildContext context, PaymentOrders orders, Color color) {
  return Container(
    width: MediaQuery.of(context).size.width,
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
        border: Border.all(
          width: 2,
          color: Colors.grey,
        ),
        borderRadius: const BorderRadius.all(Radius.circular(7))),
    child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                orders.name,
                style: TextStyle(fontSize: smallTextFontSize),
              ),
              Text(
                orders.bankName,
                style: TextStyle(fontSize: smallTextFontSize),
              ),
              Text(
                orders.date,
                style: TextStyle(fontSize: smallerTextFontSize),
              ),
            ],
          ),
          Text(
            "N${orders.amount}",
            style: TextStyle(color: color, fontSize: 20),
          )
        ]),
  );
}
