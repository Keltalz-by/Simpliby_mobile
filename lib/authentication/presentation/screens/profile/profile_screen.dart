import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simplibuy/core/constant.dart';
import 'package:simplibuy/core/error_types/error_types.dart';
import 'package:simplibuy/core/reusable_widgets/reusable_widgets.dart';
import 'package:simplibuy/core/state/state.dart';
import 'package:simplibuy/authentication/presentation/screen_model_controllers/profile_screen_controller.dart';

// ignore: must_be_immutable
class ProfileScreen extends StatelessWidget {
  ProfileScreenController controller = Get.find<ProfileScreenController>();

  ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
          text: "Account",
          onPressed: () {
            Get.back();
          },
          actions: [options()]),
      body: Container(
        padding: const EdgeInsets.all(defaultPadding),
        child: Obx(() {
          if (controller.state == ErrorState(errorType: InternetError())) {
            return noInternetConnection(context);
          }
          if (controller.state is FinishedState) {
            return SingleChildScrollView(
                child: Column(
              children: [
                Obx(() => ClipOval(
                      child: GestureDetector(
                          onTap: () {
                            controller.isEditable ? _showDialog(context) : null;
                          },
                          child: !controller.isFile
                              ? FadeInImage.assetNetwork(
                                  width: 80,
                                  height: 80,
                                  fit: BoxFit.cover,
                                  placeholder:
                                      'assets/gifs/simpliby_loading.gif',
                                  imageErrorBuilder:
                                      (context, error, stackTrace) {
                                    return const Icon(
                                      Icons.account_circle,
                                      size: 80,
                                    );
                                  },
                                  image: controller.details.image)
                              : Image.file(
                                  controller.localImage,
                                  width: 80,
                                  height: 80,
                                )),
                    )),
                Obx(() => controller.isEditable
                    ? padding
                    : defaultButtons(
                        pressed: () {},
                        text: '1k Following',
                        size: const Size(140, 40))),
                inputFieldProfileName(),
                padding,
                inputFieldProfileLocation(),
                padding,
                inputFieldProfilePhone(),
                padding,
                inputFieldProfileEmail(),
                padding,
                inputFieldProfileOccupation(),
                padding,
                Obx(() {
                  if (controller.isEditable) {
                    return defaultButtons(
                        pressed: () {
                          controller.onSubmit();
                        },
                        text: 'Save');
                  }
                  return padding;
                })
              ],
            ));
          }
          return defaultLoading(context);
        }),
      ),
    );
  }

  Widget inputFieldProfileName() {
    return Column(children: [
      inputTitle('Name'),
      Obx(() {
        return TextFormField(
            initialValue: controller.details.name,
            readOnly: !controller.isEditable,
            onChanged: (data) => controller.addName(data),
            keyboardType: TextInputType.name,
            decoration:
                customInputDecoration(hint: 'John Doe', errorText: null));
      })
    ]);
  }

  Widget inputFieldProfileLocation() {
    return Column(children: [
      inputTitle('Location'),
      Obx(() {
        return TextFormField(
            initialValue: controller.details.location,
            readOnly: !controller.isEditable,
            onChanged: (data) => controller.addLocation(data),
            keyboardType: TextInputType.text,
            decoration:
                customInputDecoration(hint: 'Nigeria', errorText: null));
      })
    ]);
  }

  Widget inputFieldProfilePhone() {
    return Column(children: [
      inputTitle('Phone Number'),
      Obx(() {
        return TextFormField(
            initialValue: controller.details.phoneNumber,
            readOnly: !controller.isEditable,
            onChanged: (data) => controller.addPhoneNumber(data),
            keyboardType: TextInputType.phone,
            decoration: customInputDecoration(hint: null, errorText: null));
      })
    ]);
  }

  Widget inputFieldProfileEmail() {
    return Column(children: [
      inputTitle('Email'),
      Obx(() {
        return TextFormField(
            initialValue: controller.details.email,
            readOnly: true,
            onChanged: (data) => controller.addEmail(data),
            keyboardType: TextInputType.emailAddress,
            decoration: customInputDecoration(
                hint: 'example@email.com', errorText: null));
      })
    ]);
  }

  Widget inputFieldProfileOccupation() {
    return Column(children: [
      inputTitle('Ocuupation'),
      Obx(() {
        return TextFormField(
            initialValue: controller.details.occupation,
            readOnly: !controller.isEditable,
            onChanged: (data) => controller.addOccupation(data),
            keyboardType: TextInputType.text,
            decoration: customInputDecoration(hint: null, errorText: null));
      })
    ]);
  }

  Widget inputTitle(String title) {
    return Align(
      alignment: Alignment.bottomLeft,
      child: Text(title,
          style: TextStyle(color: blackColor, fontSize: smallerTextFontSize)),
    );
  }

  Widget options() {
    return PopupMenuButton(
      itemBuilder: (context) {
        return [
          const PopupMenuItem<int>(
            value: 0,
            child: Text("Edit Profile"),
          ),
          const PopupMenuItem<int>(
            value: 1,
            child: Text("Log out"),
          )
        ];
      },
      onSelected: (value) {
        if (value == 0) {
          controller.makeEditable();
        } else if (value == 1) {
          print("Settings menu is selected.");
        }
      },
      icon: const Icon(
        Icons.more_vert,
        color: blackColor,
      ),
    );
  }

  static const Widget padding =
      Padding(padding: EdgeInsets.only(top: defaultPadding));

  Future<void> _showDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Choose one!'),
            content: SingleChildScrollView(
                child: ListBody(
              children: [
                GestureDetector(
                  child: Text(
                    'Camera',
                    style: TextStyle(fontSize: smallTextFontSize),
                  ),
                  onTap: () {
                    controller.loadImageFromCamera();
                  },
                ),
                padding,
                GestureDetector(
                  child: Text(
                    'Gallery',
                    style: TextStyle(fontSize: smallTextFontSize),
                  ),
                  onTap: () {
                    controller.loadImageFromGallery();
                  },
                )
              ],
            )),
          );
        });
  }
}
