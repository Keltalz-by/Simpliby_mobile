// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:simplibuy/buyer_home/presentation/screens/buyer_screen.dart';
import 'package:simplibuy/buyer_home/presentation/screens/fav_stores_screen.dart';
import 'package:simplibuy/cart/presentation/screens/cart_list_screen.dart';
import 'package:simplibuy/core/constant.dart';
import 'package:simplibuy/history/presentation/screens/history_screen.dart';
import '../controller/buyer_home_navigation_controller.dart';

class BuyerBottomNavScreen extends StatelessWidget {
  BuyerBottomNavScreen({Key? key}) : super(key: key);

  BuyerHomeNavigationController controller =
      Get.find<BuyerHomeNavigationController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: bottomNavDrawer(),
        body: SafeArea(
            child: Container(
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(horizontal: 8.w),
                child: Obx(() {
                  if (controller.currentPage == 0) {
                    return BuyerHomeScreen();
                  } else if (controller.currentPage == 1) {
                    return CartList();
                  } else if (controller.currentPage == 2) {
                    return HistoryScreen();
                  }
                  return FavStoresScreen();
                }))));
  }

  Widget bottomNavDrawer() {
    return Obx(() {
      return BottomNavigationBar(
        currentIndex: controller.currentPage,
        items: [
          bottomNavItem(Icons.home, 'Home'),
          bottomNavItem(Icons.shopping_cart, 'Cart'),
          bottomNavItem(Icons.shopping_bag, 'History'),
          bottomNavItem(Icons.favorite_border_rounded, 'Favorites'),
        ],
        unselectedItemColor: Colors.grey,
        backgroundColor: whiteColor,
        selectedItemColor: blueColor,
        onTap: (value) {
          controller.changePage(value);
        },
        type: BottomNavigationBarType.fixed,
      );
    });
  }
}

BottomNavigationBarItem bottomNavItem(IconData data, String label) {
  return BottomNavigationBarItem(
    icon: Icon(data),
    label: label,
  );
}
