import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:simplibuy/buyer_home/presentation/controller/stores_and_malls_controller.dart';
import 'package:simplibuy/core/constant.dart';
import 'package:simplibuy/buyer_home/presentation/screens/custom_widgets.dart';
import 'package:simplibuy/core/constants/route_constants.dart';
import 'package:simplibuy/core/error_types/error_types.dart';
import 'package:simplibuy/core/reusable_widgets/cache_image.dart';
import 'package:simplibuy/core/utils/utils.dart';

import '../../../core/reusable_widgets/reusable_widgets.dart';
import '../../../core/state/state.dart';

// ignore: must_be_immutable
class BuyerHomeScreen extends StatelessWidget {
  BuyerHomeScreen({Key? key}) : super(key: key);

  StoresAndMallsController controller = Get.find<StoresAndMallsController>();

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    controller.getToBuyList();
    return Scaffold(
        key: _scaffoldKey,
        drawer: navDrawer(),
        appBar: homeAppBar(
          text: greeting(),
          name: controller.userName,
          onPressed: () {
            Get.toNamed(NOTIFICATION_SCREEN);
          },
          openDrawer: () {
            _scaffoldKey.currentState?.openDrawer();
          },
        ),
        body: Column(children: [
          _createSearchView(context),
          Container(
              padding: EdgeInsets.only(left: 10.w, right: 10.w),
              child: _toBuyList(context)),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Obx(() {
                return customButtonWithIcon(
                    text: "Stores",
                    iconData: Icons.storefront,
                    onPressed: () {
                      controller.getStores();
                    },
                    side: controller.isStore
                        ? const BorderSide(color: blueColor, width: 2)
                        : null);
              }),
              const Padding(padding: EdgeInsets.only(left: 6.0)),
              Obx(() {
                return customButtonWithIcon(
                    text: "Malls",
                    iconData: Icons.local_mall,
                    onPressed: () {
                      controller.getMalls();
                    },
                    side: controller.isStore
                        ? null
                        : const BorderSide(color: blueColor, width: 2));
              })
            ],
          ),
          Container(
              alignment: Alignment.topRight,
              padding: const EdgeInsets.only(right: 12, bottom: 12),
              child: Obx(() {
                return RichText(
                    text: TextSpan(
                        text: controller.state is ErrorState ? "" : "View all",
                        style: TextStyle(
                            color: blackColor, fontSize: smallerTextFontSize),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            controller.state is ErrorState
                                ? VoidCallback
                                : Get.toNamed(STORES_LIST_ROUTE);
                            Get.toNamed(STORES_LIST_ROUTE);
                          }));
              })),
          Expanded(
            child: _itemsList(context),
          ),
        ]));
  }

  Widget navDrawer() {
    return Drawer(
      child: Container(
        padding: const EdgeInsets.only(bottom: defaultPadding),
        color: whiteColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
                child: ListView(padding: EdgeInsets.zero, children: [
              DrawerHeader(
                decoration: const BoxDecoration(
                  color: lightBlueColor,
                ),
                child: _drawerUserImageAndName(
                    url:
                        "https://firebasestorage.googleapis.com/v0/b/fir-chatapp-f1bff.appspot.com/o/images%2FZhMQ0oPjDWTqSIGItRqm9wQkU452?alt=media&token=b203a1c0-1e97-4b59-835c-f9c1baa7c771",
                    username: "Ikenwa Ebuka"),
              ),
              _titleAndIcon(
                  data: Icons.settings,
                  text: "Settings",
                  onClick: () => Get.toNamed(SETTINGS_SCREEN)),
              _titleAndIcon(
                  data: Icons.person,
                  text: "My Account",
                  onClick: () => Get.toNamed(PROFILE_SCREEN)),
              _titleAndIcon(
                  data: Icons.history,
                  text: "History",
                  onClick: () => Get.toNamed(HISTORY_SCREEN)),
              _titleAndIcon(
                  data: Icons.shopping_cart,
                  text: "Cart",
                  onClick: () => Get.toNamed(CART_LIST_SCREEN)),
              _titleAndIcon(
                  data: Icons.star_rate_sharp, text: "Rate", onClick: () {}),
              _titleAndIcon(data: Icons.report, text: "Report", onClick: () {}),
            ])),
            _logOut()
          ],
        ),
      ),
    );
  }

  Widget _drawerUserImageAndName(
      {required String url, required String username}) {
    return SingleChildScrollView(
        child: Container(
            padding: const EdgeInsets.all(defaultPadding),
            decoration: const BoxDecoration(color: lightBlueColor),
            height: 260,
            width: 140,
            child: Align(
              alignment: Alignment.center,
              child: Column(children: [
                ImageCacheCircle(
                  url,
                  width: 80,
                  height: 80,
                  errorPlaceHolder: "assets/images/test_cht_image.png",
                ),
                Text(
                  username,
                  style:
                      TextStyle(color: whiteColor, fontSize: smallTextFontSize),
                  textAlign: TextAlign.center,
                )
              ]),
            )));
  }

  Widget _titleAndIcon(
      {required IconData data,
      required String text,
      required VoidCallback onClick}) {
    return ListTile(
      leading: Icon(data, color: blueColor),
      title: Text(
        text,
        style: TextStyle(
            color: blackColor,
            fontSize: smallTextFontSize,
            fontWeight: FontWeight.bold),
      ),
      onTap: onClick,
    );
  }

  Widget _toBuyList(BuildContext context) {
    return Obx(() {
      if (controller.stateToBuy is LoadingState) {
        return const Text("Loading...");
      }
      if (controller.stateToBuy is FinishedState) {
        return toBuyListContainer(context);
      }
      return toBuyListEmpty(context);
    });
  }

  Widget toBuyListContainer(BuildContext context) {
    return Stack(children: [
      Container(
        padding: const EdgeInsets.only(top: 10, bottom: 10),
        width: MediaQuery.of(context).size.width,
        height: 120,
        decoration: const BoxDecoration(
            color: lightBlueColor,
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: InkWell(
            child: Column(
              children: [
                Text(
                  "Create a To-buy list",
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: blackColor,
                      fontSize: smallTextFontSize),
                  textAlign: TextAlign.center,
                ),
                Expanded(
                    child: Padding(
                        padding: EdgeInsets.only(left: 15.w),
                        child: ListView.separated(
                          separatorBuilder: (context, index) {
                            return Container(height: 0.5);
                          },
                          itemCount: controller.toBuyModel.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Obx(() {
                              return toBuyListSingleItem(
                                  controller.toBuyModel[index].item,
                                  controller.isBoughtRx[index], () {
                                controller.saveIsBought(index);
                              });
                            });
                          },
                        )))
              ],
            ),
            onTap: () => Get.toNamed(TO_BUY_SCREEN)),
      ),
      Positioned(top: 0, left: 0, child: smallYellowCircle()),
      Positioned(top: 0, right: 0, child: smallYellowCircle()),
      Positioned(bottom: 0, left: 0, child: smallYellowCircle()),
      Positioned(bottom: 0, right: 0, child: smallYellowCircle())
    ]);
  }

  Widget smallYellowCircle() {
    return Container(
      width: 10.w,
      height: 10.h,
      margin: const EdgeInsets.all(6),
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Color.fromRGBO(235, 185, 10, 1),
      ),
    );
  }

  Widget toBuyListEmpty(BuildContext context) {
    return Stack(children: [
      Container(
          padding: const EdgeInsets.only(top: 10, bottom: 10),
          width: MediaQuery.of(context).size.width,
          height: 70.h,
          alignment: Alignment.center,
          decoration: const BoxDecoration(
              color: lightBlueColor,
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: Center(
            // alignment: Alignment.center,
            child: InkWell(
                child: Text(
                  "Create a To-buy list",
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: blackColor,
                      fontSize: smallTextFontSize),
                  textAlign: TextAlign.center,
                ),
                onTap: () => Get.toNamed(TO_BUY_SCREEN)),
          )),
      Positioned(top: 0, left: 0, child: smallYellowCircle()),
      Positioned(top: 0, right: 0, child: smallYellowCircle()),
      Positioned(bottom: 0, left: 0, child: smallYellowCircle()),
      Positioned(bottom: 0, right: 0, child: smallYellowCircle())
    ]);
  }

  Widget _logOut() {
    return Container(
        width: 140,
        decoration: const BoxDecoration(
            color: whiteColor,
            borderRadius: BorderRadius.all(Radius.circular(6))),
        padding: const EdgeInsets.all(20.0),
        child: Row(children: [
          const Icon(Icons.logout, color: blackColor),
          const Padding(padding: EdgeInsets.only(left: 5.0)),
          RichText(
              text: TextSpan(
                  text: "LogOut",
                  style: TextStyle(
                      color: blackColor,
                      fontSize: smallTextFontSize,
                      fontWeight: FontWeight.bold),
                  recognizer: TapGestureRecognizer()..onTap = () {}))
        ]));
  }

  Widget _itemsList(BuildContext context) {
    return Obx(() {
      if (controller.state is LoadingState) {
        return defaultLoading(context);
      }
      if (controller.state == ErrorState(errorType: InternetError())) {
        return noInternet(() {
          controller.reload();
        });
      }

      return GridView.count(
          crossAxisCount: 2,
          physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics()),
          crossAxisSpacing: 4.0,
          mainAxisSpacing: 6.0,
          shrinkWrap: true,
          children: List.generate(
              controller.details.length,
              (index) => Padding(
                  padding: EdgeInsets.only(top: 8.h),
                  child: Center(
                      child: Obx(() => storesGridSingleItem(
                          details: controller.details[index],
                          onPressed: () => Get.toNamed(SINGLE_STORE_ROUTE,
                              arguments: controller.details[index].id),
                          isFav: controller.favStores
                              .contains(controller.details[index]),
                          onFavClicked: () {
                            controller.addToFav(index);
                          },
                          context: context))))));
    });
  }

  Widget _createSearchView(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 10.h, bottom: 10.h),
      child: search(context),
    );
  }

  Widget search(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [searchInputBlue(context), filterOption(() {})],
    );
  }
}
