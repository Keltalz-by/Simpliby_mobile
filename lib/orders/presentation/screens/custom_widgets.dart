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
            size: Size(300.w, 48.h))
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

Widget incomingOrdersBottomSheet(
    VoidCallback onAccept, VoidCallback onReject, BuildContext context) {
  return SingleChildScrollView(
      child: Container(
    padding: EdgeInsets.only(left: 40.w, right: 40.w, top: 10.h, bottom: 40.h),
    decoration: BoxDecoration(
      color: whiteColor,
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.3),
          blurRadius: 3.0,
          offset: const Offset(0, 2),
        ),
      ],
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25.r), topRight: Radius.circular(25.r)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Align(
            alignment: Alignment.center,
            child: Container(
              width: 80.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: Colors.grey.withAlpha(100),
                borderRadius: BorderRadius.all(Radius.circular(25.r)),
              ),
            )),
        padding,
        padding,
        personHeader(),
        padding,
        padding,
        Text(
          "Items",
          style: TextStyle(color: Colors.grey, fontSize: 18.sp),
        ),
        singleItemList("50ml Nivea Rolon", "30"),
        padding,
        singleItemList("Smart Collection Perfume", "30"),
        padding,
        singleItemList("Paracetamol Antedote", "30"),
        padding,
        singleItemList("Pears powder and body cream", "30"),
        padding,
        Text(
          "Amount",
          style: TextStyle(color: Colors.grey, fontSize: 18.sp),
        ),
        Text(
          "\$180",
          style: TextStyle(color: blackColor, fontSize: smallTextFontSize),
        ),
        padding,
        Text(
          "Status",
          style: TextStyle(color: Colors.grey, fontSize: 18.sp),
        ),
        Text(
          "Paid",
          style: TextStyle(color: blackColor, fontSize: smallTextFontSize),
        ),
        padding,
        Text(
          "Ticket ID",
          style: TextStyle(color: Colors.grey, fontSize: 18.sp),
        ),
        Text(
          "KNS684B234HK",
          style: TextStyle(color: blackColor, fontSize: smallTextFontSize),
        ),
        padding,
        Text(
          "Pickup time",
          style: TextStyle(color: Colors.grey, fontSize: 18.sp),
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
                pressed: onAccept,
                text: "Accept",
                size: Size(MediaQuery.of(context).size.width * 0.39, 45.h)),
            defaultButtons(
                pressed: onReject,
                text: "Reject",
                size: Size(MediaQuery.of(context).size.width * 0.39, 45.h))
          ],
        )
      ],
    ),
  ));
}

const padding = Padding(padding: EdgeInsets.only(top: 6));

Widget singleItemList(String name, String price) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    crossAxisAlignment: CrossAxisAlignment.start,
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
                size: 60,
              );
            },
            image: "")),
    SizedBox(width: 8.w),
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

  return SingleChildScrollView(
      child: Container(
          padding: const EdgeInsets.all(35),
          alignment: Alignment.topCenter,
          decoration: BoxDecoration(
            color: whiteColor,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                blurRadius: 3.0,
                offset: const Offset(0, 2),
              ),
            ],
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25.r),
                topRight: Radius.circular(25.r)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 80.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: Colors.grey.withAlpha(100),
                  borderRadius: BorderRadius.all(Radius.circular(25.r)),
                ),
              ),
              padding,
              padding,
              Text(
                "Why do you want to cancel this order?",
                style:
                    TextStyle(color: blackColor, fontSize: smallTextFontSize),
              ),
              padding,
              padding,
              Autocomplete<String>(
                optionsBuilder: (TextEditingValue textEditingValue) {
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
                },
                onSelected: (String selection) {
                  print('You just selected $selection');
                },
                fieldViewBuilder: (BuildContext context,
                    TextEditingController textEditingController,
                    FocusNode focusNode,
                    VoidCallback onFieldSubmitted) {
                  return TextField(
                    decoration: customInputDecoration(),
                    controller: textEditingController,
                    focusNode: focusNode,
                    onSubmitted: (value) {
                      onFieldSubmitted();
                    },
                  );
                },
              ),
              SizedBox(
                height: 200.h,
              ),
              defaultButtons(pressed: onCancel, text: "Cancel Order")
            ],
          )));
}
