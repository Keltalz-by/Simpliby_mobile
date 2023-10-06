import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simplibuy/core/constant.dart';
import 'package:simplibuy/core/reusable_widgets/reusable_widgets.dart';
import 'package:simplibuy/core/state/state.dart';
import 'package:simplibuy/to_buy_list/presentation/controllers/to_buy_controller.dart';

class ToBuyScreen extends StatelessWidget {
  ToBuyScreen({Key? key}) : super(key: key);

  ToBuyController controller = Get.find<ToBuyController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:
            customAppBar(text: "To-buy list", onPressed: () => {Get.back()}),
        body: Container(
            padding: const EdgeInsets.all(defaultPadding),
            child: Column(
              children: <Widget>[
                Text(
                  "Add the list of item(s) you want to buy, let's help you not to forget",
                  style:
                      TextStyle(color: blackColor, fontSize: smallTextFontSize),
                ),
                const Padding(padding: EdgeInsets.only(top: 30)),
                Text(
                  "What do you want to buy?",
                  style: TextStyle(
                      color: blackColor, fontSize: smallerTextFontSize),
                ),
                Obx(() {
                  if (controller.state is LoadingState) {
                    return const Text("Loading...");
                  } else {
                    return Expanded(
                        child: Column(children: [
                      Expanded(child: Obx(() {
                        return ListView.builder(
                          itemCount: controller.details.length,
                          itemBuilder: (context, index) {
                            return singleTextField(context, index);
                          },
                        );
                      })),
                      defaultButtons(
                          size: mediumWidthButtonSize,
                          text: "Add to List",
                          pressed: () {
                            _showBottomSheet(
                                context,
                                controller.details.isEmpty
                                    ? 0
                                    : controller.details.length - 1);
                          })
                    ]));
                  }
                }),
              ],
            )));
  }

  Widget singleTextField(BuildContext context, int index) {
    return Container(
        padding: const EdgeInsets.only(bottom: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.75,
              child: InkWell(onTap: () {
                controller.changeIsBought(index);
              }, child: Obx(() {
                return Text(
                  controller.details[index].item,
                  style: TextStyle(
                    color: blackColor,
                    fontSize: smallTextFontSize,
                    decoration: controller.details[index].isBought
                        ? TextDecoration.lineThrough
                        : TextDecoration.none,
                  ),
                );
              })),
            ),
            InkWell(
                child: const Icon(Icons.edit, size: 25),
                onTap: () => {_showBottomSheetEdit(context, index)}),
            InkWell(
                child: const Icon(Icons.delete, size: 25),
                onTap: () => {controller.removeFromList(index)}),
          ],
        ));
  }

  void _showBottomSheet(BuildContext context, int index) {
    final tController = TextEditingController();
    showModalBottomSheet(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(25.0))),
        backgroundColor: whiteColor,
        context: context,
        isScrollControlled: true,
        builder: (context) => Container(
              //height: 200,
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                  top: defaultPadding,
                  left: defaultPadding,
                  right: defaultPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  TextField(
                    controller: tController,
                    autofocus: true,
                  ),
                  const Padding(padding: EdgeInsets.only(top: defaultPadding)),
                  Align(
                      alignment: Alignment.center,
                      child: defaultButtons(
                          pressed: () {
                            controller.addToList(tController.text);
                            Navigator.pop(context);
                          },
                          text: "Save",
                          size: const Size(90.0, 40)))
                ],
              ),
            ));
  }

  void _showBottomSheetEdit(BuildContext context, int index) {
    final singleItem = controller.details[index];
    final tController = TextEditingController(text: singleItem.item);
    showModalBottomSheet(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(25.0))),
        backgroundColor: whiteColor,
        context: context,
        isScrollControlled: true,
        builder: (context) => Container(
              //height: 200,
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                  top: defaultPadding,
                  left: defaultPadding,
                  right: defaultPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  TextField(
                    controller: tController,
                    autofocus: true,
                  ),
                  const Padding(padding: EdgeInsets.only(top: defaultPadding)),
                  Align(
                      alignment: Alignment.center,
                      child: defaultButtons(
                          pressed: () {
                            controller.updateSingleModel(
                                tController.text, singleItem.id);
                            Navigator.pop(context);
                          },
                          text: "Save",
                          size: const Size(90.0, 40)))
                ],
              ),
            ));
  }
}
