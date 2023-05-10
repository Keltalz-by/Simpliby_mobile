import 'package:flutter/material.dart';
import 'package:simplibuy/core/constant.dart';
import 'package:simplibuy/history/domain/entities/history_data.dart';

Widget singleHistoryItem(BuildContext context, HistoryData data) {
  return Container(
    margin: const EdgeInsets.only(bottom: 10),
    padding: const EdgeInsets.all(5),
    decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        border: Border.all(
          color: Colors.grey,
          width: 3,
        )),
    width: MediaQuery.of(context).size.width,
    child: Row(
      children: [
        Container(
          padding: const EdgeInsets.all(5),
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              color: Color.fromARGB(255, 149, 194, 231)),
          child: Image.asset(
            'assets/images/simpliby_logo.png',
            width: 50,
            height: 50,
          ),
        ),
        const Padding(padding: EdgeInsets.only(left: 10)),
        _historyDetails(context, data)
      ],
    ),
  );
}

Widget _historyDetails(BuildContext context, HistoryData data) {
  return Expanded(
      child: Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Purchase ID: ${data.purchaseId}',
            style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: blackColor,
                fontSize: smallTextFontSize),
          ),
          Text(
            data.time,
            style: const TextStyle(
                color: blackColor, fontSize: smallerTextFontSize),
          ),
        ],
      ),
      Text(
        'Status: ${data.status}',
        style: const TextStyle(color: blackColor, fontSize: smallTextFontSize),
      ),
      Text(
        'Total Amount: ${data.amount}',
        style: const TextStyle(color: blackColor, fontSize: smallTextFontSize),
      ),
    ],
  ));
}

Widget emptyHistory(BuildContext context) {
  return Container(
      padding: const EdgeInsets.all(defaultPadding),
      width: MediaQuery.of(context).size.width * 0.5,
      height: MediaQuery.of(context).size.height * 0.5,
      child: Column(children: [
        const Icon(Icons.history, size: 50),
        const Text('Your history is empty', style: TextStyle()),
        const Text('History about your transactions will appear here',
            style: TextStyle())
      ]));
}
