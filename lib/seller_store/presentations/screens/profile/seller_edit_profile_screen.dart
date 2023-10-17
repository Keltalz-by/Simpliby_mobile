import 'package:flutter/material.dart';
import 'package:simplibuy/authentication/presentation/screens/business_details/custom_widgets.dart';
import 'package:simplibuy/core/constant.dart';
import 'package:simplibuy/core/constants/string_constants.dart';
import 'package:simplibuy/core/reusable_widgets/cache_image.dart';
import 'package:simplibuy/core/reusable_widgets/reusable_widgets.dart';

class SellerEditProfileScreen extends StatelessWidget {
  const SellerEditProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 245, 243, 243),
        body: SingleChildScrollView(
            child: Column(children: [
          SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.35,
              child: Stack(
                alignment: Alignment.topCenter,
                clipBehavior: Clip.none,
                children: [
                  storeImage(context),
                  Positioned(
                    bottom: -10,
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: storeLogo(context),
                    ),
                  ),
                  Positioned(
                      child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      "+ Add store image",
                      style: TextStyle(
                          color: whiteColor,
                          fontSize: smallTextFontSize,
                          fontWeight: FontWeight.bold),
                    ),
                  )),
                ],
              )),
          /*  Padding(
              padding: const EdgeInsets.all(10),
              child: textFieldWithHeader(
                  errorText: null,
                  hintText: "eg. Simbi's enterprice",
                  title: "Business Name",
                  isReq: false,
                  onChanged: (value) {})),
          Padding(
              padding: EdgeInsets.all(10),
              child: textFieldWithHeader(
                  errorText: null,
                  hintText: "eg. Enugu Nigeria",
                  title: "Location",
                  isReq: false,
                  onChanged: (value) {})),
          Padding(
              padding: EdgeInsets.all(10),
              child: textFieldWithHeader(
                  errorText: null,
                  hintText: "eg. 09017362923",
                  title: "Phone",
                  isReq: false,
                  onChanged: (value) {})),
          Padding(
              padding: EdgeInsets.all(10),
              child: textFieldWithHeader(
                  errorText: null,
                  hintText: "eg. simbi@gmail.com",
                  title: "Email",
                  isReq: false,
                  onChanged: (value) {})),
          Padding(
              padding: EdgeInsets.all(10),
              child: textFieldWithHeader(
                  errorText: null,
                  hintText: "eg. simbi.com",
                  title: "Website",
                  isReq: false,
                  onChanged: (value) {})),
          Padding(
              padding: EdgeInsets.all(10),
              child: textFieldWithHeader(
                  errorText: null,
                  hintText: "eg. simbi@gmail.com",
                  title: "Business Hours",
                  isReq: false,
                  onChanged: (value) {})),
          Padding(
              padding: EdgeInsets.all(10),
              child: defaultButtons(pressed: () {}, text: "Save")),*/
        ])));
  }

  Widget storeLogo(BuildContext context) {
    return Stack(
      children: [
        ClipOval(
            child: ColorFiltered(
                colorFilter: ColorFilter.mode(
                    Color.fromARGB(255, 44, 44, 44).withOpacity(0.5),
                    BlendMode.darken),
                child: const ImageCacheCircle(
                  "",
                  width: 100,
                  height: 100,
                  errorPlaceHolder: defaultStoreImage,
                ))),
        const Positioned(
          left: 0,
          right: 0,
          top: 0,
          bottom: 0,
          child: Icon(Icons.camera_front, color: Colors.white, size: 25),
        ),
      ],
    );
  }

  Widget storeImage(BuildContext context) {
    return ColorFiltered(
        colorFilter: ColorFilter.mode(
            Color.fromARGB(255, 36, 35, 35).withOpacity(0.5), BlendMode.darken),
        child: FadeInImage.assetNetwork(
            image: "",
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.3,
            fit: BoxFit.cover,
            placeholder: defaultProductImage,
            imageErrorBuilder: (context, error, stackTrace) {
              return ColorFiltered(
                  colorFilter: ColorFilter.mode(
                      Color.fromARGB(255, 53, 51, 51).withOpacity(0.5),
                      BlendMode.darken),
                  child: ImageCacheR(
                    "",
                    errorPlaceHolder: defaultProductImage,
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.3,
                  ));
            }));
  }
}
