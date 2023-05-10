import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:simplibuy/core/constant.dart';
import 'package:simplibuy/core/reusable_widgets/reusable_widgets.dart';

class CreatePromoPostScreen extends StatelessWidget {
  const CreatePromoPostScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: customAppBar(
            text: "Create a post",
            onPressed: () {
              Get.back();
            }),
        body: Container(
          padding: const EdgeInsets.all(defaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              showPostDetails(),
              const Padding(padding: EdgeInsets.only(top: 20)),
              showTextBelow(),
              const Padding(padding: EdgeInsets.only(top: 60)),
              defaultButtons(pressed: () {}, text: "Post")
            ],
          ),
        ));
  }

  Widget showPostDetails() {
    return Stack(children: [
      TextField(
        onChanged: (business) {},
        keyboardType: TextInputType.name,
        maxLines: 5,
        decoration: const InputDecoration(
            filled: true,
            fillColor: Color.fromARGB(255, 233, 231, 231),
            hintText: "What do you want to promote",
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                borderSide:
                    BorderSide(color: Color.fromARGB(255, 233, 231, 231))),
            enabledBorder: OutlineInputBorder(
                borderSide:
                    BorderSide(color: Color.fromARGB(255, 233, 231, 231)),
                borderRadius: BorderRadius.all(Radius.circular(10)))),
      ),
      Positioned(
          bottom: 5,
          left: 5,
          child: Align(
              alignment: Alignment.bottomLeft,
              child: Row(children: const [
                Icon(
                  Icons.gif_box,
                  color: blackColor,
                ),
                Icon(
                  Icons.image,
                  color: blackColor,
                )
              ]))),
    ]);
  }

  Widget showTextBelow() {
    return const Align(
      alignment: Alignment.bottomLeft,
      child: Text(
        "Ensure that the size of your image fits our recommended dimension 8.54 X 3.75 inches",
        style: TextStyle(fontSize: 14),
      ),
    );
  }
}
