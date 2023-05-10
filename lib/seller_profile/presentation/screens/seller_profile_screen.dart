import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simplibuy/core/constant.dart';
import 'package:simplibuy/core/constants/route_constants.dart';
import 'package:simplibuy/core/constants/string_constants.dart';
import 'package:simplibuy/core/error_types/error_types.dart';
import 'package:simplibuy/core/reusable_widgets/reusable_widgets.dart';
import 'package:simplibuy/core/state/state.dart';
import 'package:simplibuy/seller_profile/presentation/controllers/seller_profile_controller.dart';
import 'package:simplibuy/seller_profile/presentation/screens/custom_widgets.dart';
import 'package:simplibuy/store_and_product/presentation/screens/custom_widgets.dart';

// ignore: must_be_immutable
class SellerProfileScreen extends StatelessWidget {
  SellerProfileScreen({Key? key}) : super(key: key);

  SellerProfileController controller = Get.find<SellerProfileController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 245, 243, 243),
        body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          SizedBox(
              height: MediaQuery.of(context).size.height * 0.4,
              child: Stack(
                alignment: Alignment.topCenter,
                clipBehavior: Clip.hardEdge,
                children: [
                  SellerProfileImage(
                      context, controller.sellerProfileDetails.storeImages),
                  Positioned(
                      top: 20,
                      right: 20,
                      child: Align(
                        alignment: Alignment.center,
                        child: otherOptions(),
                      )),
                  Positioned(
                    bottom: 20,
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: storeLogo(context),
                    ),
                  ),
                  Positioned(
                    bottom: 20,
                    right: 10,
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: editProfileButton(),
                    ),
                  )
                ],
              )),
          Padding(
              padding: const EdgeInsets.only(left: defaultPadding),
              child: Text(
                controller.sellerProfileDetails.storeName,
                style: const TextStyle(
                    color: blackColor,
                    fontWeight: FontWeight.bold,
                    fontSize: smallTextFontSize),
              )),
          Padding(
              padding: const EdgeInsets.only(
                  left: defaultPadding, right: defaultPadding),
              child:
                  storeDescription(desc: controller.sellerProfileDetails.desc)),
          Padding(
              padding: const EdgeInsets.only(
                  left: defaultPadding, right: defaultPadding),
              child: storeContactDetails(
                  email: controller.sellerProfileDetails.email,
                  phoneNumber: controller.sellerProfileDetails.number)),
          Padding(
              padding: const EdgeInsets.only(left: defaultPadding),
              child: Row(children: [
                const Icon(
                  Icons.location_on,
                  color: blackColor,
                  size: 13,
                ),
                Text(
                  controller.sellerProfileDetails.address,
                  style: const TextStyle(
                    color: blackColor,
                    fontSize: 15,
                  ),
                )
              ])),
          const Padding(padding: EdgeInsets.only(top: 10)),
          Align(
            alignment: Alignment.center,
            child: storeFollowers(
                followers: controller.sellerProfileDetails.followers.toInt(),
                color: whiteColor,
                decoration: const BoxDecoration(
                    color: blueColor,
                    borderRadius: BorderRadius.all(Radius.circular(30)))),
          ),
          const Padding(padding: EdgeInsets.only(top: 20)),
          createPromoPost(),
          showPromoPosts(context)
        ]));
  }

  Widget showPromoPosts(BuildContext context) {
    return Obx(
      () {
        if (controller.statePosts is LoadingState) {
          return defaultLoading(context);
        }
        if (controller.statePosts is FinishedState) {
          return Expanded(
              child: Container(
                  padding: const EdgeInsets.all(10),
                  child: ListView.separated(
                      separatorBuilder: (BuildContext context, int pos) {
                        return const Padding(padding: EdgeInsets.only(top: 10));
                      },
                      itemCount: controller.promoPosts.length,
                      itemBuilder: (BuildContext context, int position) {
                        return singlePromo(
                            context, controller.promoPosts[position]);
                      })));
        }
        if (controller.state == ErrorState(errorType: InternetError())) {
          return noInternetConnection(context);
        } else {
          return Container();
        }
      },
    );
  }

  Widget editProfileButton() {
    return GestureDetector(
      child: Container(
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
            border: Border.all(color: blueColor, width: 2),
            borderRadius: const BorderRadius.all(Radius.circular(30))),
        child: const Text(
          "Edit Profile",
          style: TextStyle(fontSize: smallTextFontSize, color: blackColor),
        ),
      ),
      onTap: () {
        Get.toNamed(SELLER_EDIT_PROFILE_SCREEN);
      },
    );
  }

  Widget storeLogo(BuildContext context) {
    return ClipOval(
        child: FadeInImage.assetNetwork(
            image: controller.sellerProfileDetails.storeLogo,
            width: 100,
            height: 100,
            fit: BoxFit.cover,
            placeholder: defaultStoreImage,
            imageErrorBuilder: (context, error, stackTrace) {
              return ClipOval(
                  child: Image.asset(
                defaultStoreImage,
                width: 100,
                height: 100,
                fit: BoxFit.cover,
              ));
            }));
  }

  Widget createPromoPost() {
    return Align(
        alignment: Alignment.center,
        child: GestureDetector(
          child: Container(
            padding:
                const EdgeInsets.only(left: 25, right: 25, top: 10, bottom: 10),
            decoration: BoxDecoration(
                border: Border.all(color: blueColor, width: 2),
                borderRadius: const BorderRadius.all(Radius.circular(30))),
            child: const Text(
              "Create Promo post",
              style: TextStyle(fontSize: smallTextFontSize, color: blackColor),
            ),
          ),
          onTap: () {
            Get.toNamed(CREATE_PROMO_POST_SCREEN);
          },
        ));
  }

  Widget otherOptions() {
    final actions = [
      const PopupMenuItem(
        value: 'Edit',
        child: Text('Edit Profile'),
      ),
      const PopupMenuItem(
        value: 'Share',
        child: Text('Share'),
      ),
      const PopupMenuItem(
        value: 'logout',
        child: Text('Log out'),
      ),
    ];
    return PopupMenuButton<String>(
      icon: const Icon(Icons.more_vert, color: whiteColor),
      itemBuilder: (BuildContext context) {
        return actions;
      },
      onSelected: (value) {
        if (value == "Edit") {
          Get.toNamed(SELLER_EDIT_PROFILE_SCREEN);
        }
      },
    );
  }
}
