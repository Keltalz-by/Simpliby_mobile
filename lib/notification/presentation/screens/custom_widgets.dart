import 'package:flutter/material.dart';
import 'package:simplibuy/core/constant.dart';
import 'package:simplibuy/notification/domain/entities/notification_data.dart';

Widget NotificationSingleItem(NotificationData data) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: [
      ClipOval(
          child: FadeInImage.assetNetwork(
              width: 45,
              height: 45,
              fit: BoxFit.cover,
              placeholder: 'assets/gifs/simpliby_loading.gif',
              imageErrorBuilder: (context, error, stackTrace) {
                return const Icon(Icons.account_circle);
              },
              image:
                  "https://firebasestorage.googleapis.com/v0/b/fir-chatapp-f1bff.appspot.com/o/images%2FZhMQ0oPjDWTqSIGItRqm9wQkU452?alt=media&token=b203a1c0-1e97-4b59-835c-f9c1baa7c771")),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
              alignment: Alignment.topLeft,
              child: Text(
                data.name,
                textAlign: TextAlign.start,
                style: TextStyle(fontSize: smallTextFontSize),
              )),
          Text(
            data.details,
            style: TextStyle(fontSize: smallTextFontSize),
          )
        ],
      ),
      Text(
        data.date,
        style: TextStyle(fontSize: smallerTextFontSize),
      )
    ],
  );
}
