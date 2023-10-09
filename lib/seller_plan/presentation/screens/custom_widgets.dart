import 'package:flutter/material.dart';
import 'package:simplibuy_seller/core/constant.dart';

Widget planType(Color colorPlan, String planType) {
  return Container(
    width: 60,
    height: 60,
    padding: const EdgeInsets.all(5),
    decoration: BoxDecoration(
        color: colorPlan,
        borderRadius: const BorderRadius.all(Radius.circular(8))),
    child: Column(
      children: [
        Text(
          planType.toUpperCase(),
          style: const TextStyle(
              color: whiteColor, fontSize: 14, fontWeight: FontWeight.bold),
        ),
        const Text(
          "plan",
          style: TextStyle(color: whiteColor, fontSize: 13),
        )
      ],
    ),
  );
}

Widget freePlanDetails() {
  return SizedBox(
      width: 80,
      child: ListView(
        children: const [
          ListTile(
            leading: Icon(Icons.circle),
            title: Text('Max of 30 buyers per week'),
          ),
          ListTile(
            leading: Icon(Icons.circle),
            title: Text('Free'),
          )
        ],
      ));
}

Widget paidPlanDetails() {
  return SizedBox(
      width: 80,
      child: ListView(
        children: const [
          ListTile(
            leading: Icon(Icons.circle),
            title: Text('Unlimited number of buyers'),
          ),
          ListTile(
            leading: Icon(Icons.circle),
            title: Text('Initiate chat with buyers'),
          ),
          ListTile(
            leading: Icon(Icons.circle),
            title: Text('Advertise products'),
          ),
          ListTile(
            leading: Icon(Icons.circle),
            title: Text('N5000 Monthly'),
          ),
        ],
      ));
}

Widget freePlanOption(BuildContext context) {
  return Container(
    width: MediaQuery.of(context).size.width,
    height: 120,
    decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        border: Border.all(color: blueColor)),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [planType(blueColor, "free"), freePlanDetails()],
    ),
  );
}

Widget paidPlanOption(BuildContext context) {
  return Container(
    width: MediaQuery.of(context).size.width,
    height: 120,
    decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        border: Border.all(color: Colors.red)),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [planType(Colors.red, "paid"), paidPlanDetails()],
    ),
  );
}
