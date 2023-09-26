import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simplibuy/buyer_home/presentation/controller/stores_and_malls_controller.dart';
import 'package:simplibuy/buyer_home/presentation/screens/custom_widgets.dart';
import 'package:simplibuy/core/error_types/error_types.dart';
import 'package:simplibuy/core/state/state.dart';

import '../../../core/constant.dart';
import '../../../core/constants/route_constants.dart';
import '../../../core/reusable_widgets/reusable_widgets.dart';
import '../controller/buyer_home_navigation_controller.dart';

// ignore: must_be_immutable
class FavStoresScreen extends StatelessWidget {
  FavStoresScreen({Key? key}) : super(key: key);

  StoresAndMallsController controller = Get.find<StoresAndMallsController>();

  BuyerHomeNavigationController navController =
      Get.find<BuyerHomeNavigationController>();

  @override
  Widget build(BuildContext context) {
    controller.getFavStores();
    return Scaffold(
        appBar: customAppBar(
          text: "My Favorites",
          onPressed: () => navController.changePage(0),
        ),
        body: Obx((() {
          if (controller.stateFav == ErrorState(errorType: EmptyListError())) {
            return showEmptyFavorites(context);
          }
          return Container(
            padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
            child: Column(
              children: [
                const Padding(padding: EdgeInsets.only(top: defaultPadding)),
                Expanded(child: favList())
              ],
            ),
          );
        })));
  }

  Widget favList() {
    return ListView.builder(
        itemCount: controller.favStores.length,
        itemBuilder: (context, position) {
          return Dismissible(
              key: UniqueKey(),
              onDismissed: (direction) {
                controller.removeFromFav(position);
              },
              background: Container(color: Colors.red),
              child: Obx(() => storesListSingleItem(
                  onFavClicked: null,
                  details: controller.favStores[position],
                  onClick: () => Get.toNamed(SINGLE_STORE_ROUTE,
                      arguments: controller.favStores[position].id))));
        });
  }
}
