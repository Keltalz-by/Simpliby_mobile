import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
                      top: 15.h,
                      right: 15.w,
                      child: Align(
                        alignment: Alignment.center,
                        child: otherOptions(),
                      )),
                  Positioned(
                    bottom: 20.h,
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
              padding: EdgeInsets.only(left: 20.w),
              child: Text(
                controller.sellerProfileDetails.storeName,
                style: TextStyle(
                    color: blackColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 22.sp),
              )),
          SizedBox(
            height: 10.h,
          ),
          Padding(
              padding: EdgeInsets.only(left: 20.w, right: 20.w),
              child:
                  storeDescription(desc: controller.sellerProfileDetails.desc)),
          SizedBox(
            height: 10.h,
          ),
          Padding(
              padding: EdgeInsets.only(left: 20.w, right: 20.w),
              child: storeContactDetails(
                  email: controller.sellerProfileDetails.email,
                  phoneNumber: controller.sellerProfileDetails.number)),
          SizedBox(
            height: 10.h,
          ),
          Padding(
              padding: EdgeInsets.only(left: 20.w),
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
          return Flexible(
              child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
                  child: ListView.separated(
                      shrinkWrap: true,
                      separatorBuilder: (BuildContext context, int pos) {
                        return SizedBox(
                          height: 10.h,
                        );
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
        child: Text(
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
    return ClipRRect(
        borderRadius: BorderRadius.circular(50.r),
        child: FadeInImage.assetNetwork(
            image: controller.sellerProfileDetails.storeLogo,
            width: 100.w,
            height: 100.w,
            fit: BoxFit.cover,
            placeholder: defaultStoreImage,
            imageErrorBuilder: (context, error, stackTrace) {
              return ClipRRect(
                  borderRadius: BorderRadius.circular(50.r),
                  child: Image.asset(
                    defaultStoreImage,
                    width: 100.w,
                    height: 100.h,
                    fit: BoxFit.cover,
                  ));
            }));
  }

  Widget createPromoPost() {
    return Align(
        alignment: Alignment.center,
        child: GestureDetector(
          child: Container(
            padding: EdgeInsets.only(
                left: 45.w, right: 45.w, top: 10.h, bottom: 10.h),
            decoration: BoxDecoration(
                border: Border.all(color: blueColor, width: 2),
                borderRadius: BorderRadius.all(Radius.circular(30.r))),
            child: Text(
              "Create a Promo post",
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
