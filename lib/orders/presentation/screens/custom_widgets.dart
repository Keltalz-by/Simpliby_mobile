import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:simplibuy/core/constant.dart';
import 'package:simplibuy/core/reusable_widgets/reusable_widgets.dart';
import 'package:simplibuy/orders/data/models/accepted_orders.dart';
import 'package:simplibuy/orders/data/models/incoming_orders.dart';

Widget singleIncomingOrder(
    BuildContext context, IncomingOrder order, VoidCallback onOrderClicked) {
  return Container(
    width: MediaQuery.of(context).size.width,
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: whiteColor,
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.3),
          blurRadius: 3.0,
          offset: const Offset(0, 2),
        ),
      ],
      borderRadius: const BorderRadius.all(Radius.circular(8)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(60),
                child: FadeInImage.assetNetwork(
                    width: 60.w,
                    height: 60.h,
                    fit: BoxFit.cover,
                    placeholder: 'assets/gifs/simpliby_loading.gif',
                    imageErrorBuilder: (context, error, stackTrace) {
                      return const Icon(
                        Icons.account_circle,
                        size: 60,
                      );
                    },
                    image: order.image)),
            SizedBox(
              width: 20.w,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  order.name,
                  style: TextStyle(
                      color: blackColor,
                      fontSize: smallTextFontSize,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  "Item ID: ${order.itemId}",
                  style: TextStyle(
                      color: blackColor,
                      fontSize: smallTextFontSize,
                      fontWeight: FontWeight.normal),
                ),
                Text(
                  "Time: ${order.time}",
                  style: TextStyle(
                      color: blackColor,
                      fontSize: smallTextFontSize,
                      fontWeight: FontWeight.normal),
                )
              ],
            )
          ],
        ),
        const Padding(padding: EdgeInsets.only(top: 10)),
        defaultButtons(
            pressed: onOrderClicked,
            text: "View Details",
            size: Size(300.w, 37.h))
      ],
    ),
  );
}

Widget singleAcceptedOrder(
    BuildContext context, AcceptedOrder order, VoidCallback onOrderClicked) {
  return Container(
    width: MediaQuery.of(context).size.width,
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: whiteColor,
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.3),
          blurRadius: 3.0,
          offset: const Offset(0, 2),
        ),
      ],
      borderRadius: const BorderRadius.all(Radius.circular(8)),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(60),
                child: FadeInImage.assetNetwork(
                    width: 60.w,
                    height: 60.h,
                    fit: BoxFit.cover,
                    placeholder: 'assets/gifs/simpliby_loading.gif',
                    imageErrorBuilder: (context, error, stackTrace) {
                      return const Icon(
                        Icons.account_circle,
                        size: 60,
                      );
                    },
                    image: order.image)),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  order.name,
                  style: TextStyle(
                      color: blackColor,
                      fontSize: smallTextFontSize,
                      fontWeight: FontWeight.bold),
                ),
                Padding(padding: EdgeInsets.only(top: 6.h)),
                Text(
                  "Ticket ID: ${order.ticketId}",
                  style: TextStyle(
                      color: blackColor,
                      fontSize: smallTextFontSize,
                      fontWeight: FontWeight.normal),
                ),
                Padding(padding: EdgeInsets.only(top: 6.h)),
                Text(
                  "Status: ${order.status}",
                  style: TextStyle(
                      color: blackColor,
                      fontSize: smallTextFontSize,
                      fontWeight: FontWeight.normal),
                )
              ],
            )
          ],
        ),
        Padding(padding: EdgeInsets.only(top: 10.h)),
        defaultButtons(
            pressed: onOrderClicked, text: "Cancel", size: const Size(100, 30))
      ],
    ),
  );
}

Widget emptyOrder() {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Image.asset('assets/images/no_network.png'),
      const Padding(padding: EdgeInsets.only(top: 10)),
      const Text(
        'You do not have ny order, your first order will appear here.',
        style: TextStyle(color: blackColor, fontSize: 15),
      ),
    ],
  );
}

Widget incomingOrdersBottomSheet(VoidCallback onAccept, VoidCallback onReject) {
  return SingleChildScrollView(
      child: Container(
    padding: const EdgeInsets.all(35),
    decoration: BoxDecoration(
      color: whiteColor,
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.3),
          blurRadius: 3.0,
          offset: const Offset(0, 2),
        ),
      ],
      borderRadius: const BorderRadius.all(Radius.circular(8)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        personHeader(),
        padding,
        padding,
        Text(
          "Items",
          style: TextStyle(color: Colors.grey, fontSize: 15),
        ),
        singleItemList("Rolon", "30"),
        singleItemList("Rolon", "30"),
        singleItemList("Rolon", "30"),
        singleItemList("Rolon", "30"),
        singleItemList("Rolon", "30"),
        padding,
        Text(
          "Amount",
          style: TextStyle(color: Colors.grey, fontSize: 15),
        ),
        Text(
          "\$180",
          style: TextStyle(color: blackColor, fontSize: smallTextFontSize),
        ),
        padding,
        Text(
          "Status",
          style: TextStyle(color: Colors.grey, fontSize: 15),
        ),
        Text(
          "Paid",
          style: TextStyle(color: blackColor, fontSize: smallTextFontSize),
        ),
        padding,
        Text(
          "Ticket ID",
          style: TextStyle(color: Colors.grey, fontSize: 15),
        ),
        Text(
          "KNS684B234HK",
          style: TextStyle(color: blackColor, fontSize: smallTextFontSize),
        ),
        padding,
        Text(
          "Pickup time",
          style: TextStyle(color: Colors.grey, fontSize: 15),
        ),
        Text(
          "Monday 25th July, 2020",
          style: TextStyle(color: blackColor, fontSize: smallTextFontSize),
        ),
        padding,
        padding,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            defaultButtons(
                pressed: onAccept, text: "Accept", size: Size(130, 50)),
            defaultButtons(
                pressed: onReject, text: "Reject", size: Size(130, 50))
          ],
        )
      ],
    ),
  ));
}

const padding = Padding(padding: EdgeInsets.only(top: 6));

Widget singleItemList(String name, String price) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      Text(
        name,
        style: TextStyle(fontSize: smallTextFontSize),
      ),
      padding,
      Text(
        "\$$price",
        style: TextStyle(fontSize: smallTextFontSize),
      )
    ],
  );
}

Widget personHeader() {
  return Row(children: [
    ClipRRect(
        borderRadius: BorderRadius.circular(60),
        child: FadeInImage.assetNetwork(
            width: 60,
            height: 60,
            fit: BoxFit.cover,
            placeholder: 'assets/gifs/simpliby_loading.gif',
            imageErrorBuilder: (context, error, stackTrace) {
              return const Icon(
                Icons.account_circle,
                size: 35,
              );
            },
            image: "")),
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Ikenwa John",
          style: TextStyle(
              color: blackColor,
              fontSize: smallTextFontSize,
              fontWeight: FontWeight.bold),
        ),
        Text(
          "09027901278",
          style: TextStyle(
              color: blackColor,
              fontSize: smallTextFontSize,
              fontWeight: FontWeight.normal),
        ),
      ],
    )
  ]);
}

Widget acceptedOrdersBottomSheet(VoidCallback onCancel) {
  final List<String> suggestions = [
    "I ran out of Stock",
    "The order has been overdue",
    "A change in price occured",
    "Closed for the week"
  ];

  return Container(
      padding: const EdgeInsets.all(35),
      decoration: BoxDecoration(
        color: whiteColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 3.0,
            offset: const Offset(0, 2),
          ),
        ],
        borderRadius: const BorderRadius.all(Radius.circular(8)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Autocomplete(optionsBuilder: (TextEditingValue textEditingValue) {
            if (textEditingValue.text == '') {
              return const Iterable<String>.empty();
            } else {
              List<String> matches = <String>[];
              matches.addAll(suggestions);

              matches.retainWhere((s) {
                return s
                    .toLowerCase()
                    .contains(textEditingValue.text.toLowerCase());
              });
              return matches;
            }
          }, onSelected: (String selection) {
            print('You just selected $selection');
          }),
          defaultButtons(pressed: onCancel, text: "Cancel Order")
        ],
      ));
}
