import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:simplibuy/core/constant.dart';
import 'package:simplibuy/core/error_types/error_types.dart';
import 'package:simplibuy/core/reusable_widgets/reusable_widgets.dart';
import 'package:simplibuy/core/state/state.dart';
import 'package:simplibuy/store_and_product/presentation/controllers/store_detail_controller.dart';
import 'package:simplibuy/store_and_product/presentation/screens/custom_widgets.dart';

import '../../../core/constants/route_constants.dart';

// ignore: must_be_immutable
class StoreInfoScreen extends StatelessWidget {
  StoreInfoScreen({Key? key}) : super(key: key);

  final StoreDetailController _controller = Get.find<StoreDetailController>();
  final int id = Get.arguments;

  @override
  Widget build(BuildContext context) {
    _controller.start(id);
    return Scaffold(body: Obx(() {
      if (_controller.state == ErrorState(errorType: InternetError())) {
        return noInternetConnection(context);
      }
      if (_controller.state is FinishedState) {
        return _body(context);
      }
      return defaultLoading(context);
    }));
  }

  Widget _body(BuildContext context) {
    return CustomScrollView(physics: const BouncingScrollPhysics(), slivers: [
      SliverAppBar(
        expandedHeight: 550.h,
        pinned: false,
        iconTheme: const IconThemeData(color: Colors.white),
        stretch: true,
        scrolledUnderElevation: 0,
        elevation: 0,
        actions: [
          Padding(
              padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
              child: searchInput(() {}))
        ],
        backgroundColor: Colors.transparent,
        flexibleSpace: FlexibleSpaceBar(
            stretchModes: const [
              StretchMode.zoomBackground,
            ],
            collapseMode: CollapseMode.parallax,
            background: Column(children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  SellerProfileImage(context, _controller.store.storeImages),
                  Positioned(
                    bottom: -20,
                    child: storeNameAndAddress(
                        context: context,
                        storeImage: _controller.store.storeImages,
                        storeName: _controller.store.name,
                        storeAddress: _controller.store.address),
                  ),
                ],
              ),
            ])),
        bottom: PreferredSize(
            preferredSize: const Size(double.maxFinite, 260),
            child: Column(children: [
              Padding(padding: EdgeInsets.only(top: 25.h)),
              Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: storeDescription(desc: _controller.store.about)),
              Padding(padding: EdgeInsets.only(top: 15.h)),
              Padding(
                  padding: EdgeInsets.only(left: 10.w, right: 10.w),
                  child: storeContactDetails(
                      email: _controller.store.email,
                      phoneNumber: _controller.store.phoneNumber)),
              Align(
                alignment: Alignment.topLeft,
                child: storeFollowers(followers: 1000),
              ),
              Padding(padding: EdgeInsets.only(top: 5.h)),
              followAndChat(),
              Padding(padding: EdgeInsets.only(top: 15.h)),
              storeRating(rating: 4),
              Padding(padding: EdgeInsets.only(top: 15.h)),
            ])),
      ),
      SliverToBoxAdapter(
          child: Column(children: [
        _controller.catstate is FinishedState ? showCategories() : Container(),
        Padding(padding: EdgeInsets.only(top: 8.h)),
        showCategoriesList(context),
        Padding(padding: EdgeInsets.only(top: 15.h)),
        _controller.popstate is FinishedState ? showPopular() : Container(),
        Padding(padding: EdgeInsets.only(top: 8.h)),
        popularProducts(context),
        const Padding(
            padding: EdgeInsets.all(10),
            child: Text(
                "Didn't find what you intend to buy? Click here to chat with the seller")),
        chatToReserveItem(context),
        const Padding(padding: EdgeInsets.only(top: 10)),
      ])),
    ]);
  }

  Widget popularProducts(BuildContext context) {
    return Obx(() {
      if (_controller.popstate is LoadingState) {
        return defaultLoading(context);
      }
      if (_controller.popstate is FinishedState) {
        return Padding(
            padding: EdgeInsets.only(left: 12.w),
            child: GridView.count(
                crossAxisCount: 3,
                scrollDirection: Axis.vertical,
                physics: const BouncingScrollPhysics(),
                crossAxisSpacing: 15.w,
                shrinkWrap: true,
                mainAxisSpacing: 15.h,
                children: List.generate(
                    _controller.product.length,
                    (index) => Obx(() => singleProductItem(
                            context,
                            _controller.product[index],
                            () => Get.toNamed(PRODUCT_SCREEN, arguments: [
                                  _controller.product[index].productId,
                                  _controller.store.name,
                                  id
                                ]), () {
                          _controller.addProductToCart(index);
                          snackAdded;
                        })))));
      }
      return Container();
    });
  }

  Widget showCategories() {
    return Container(
        padding: EdgeInsets.only(left: 10.w, right: 10.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Categories',
              style: TextStyle(color: blackColor, fontSize: smallTextFontSize),
            ),
            Text(
              'view all',
              style:
                  TextStyle(color: blackColor, fontSize: smallerTextFontSize),
            )
          ],
        ));
  }

  Widget showPopular() {
    return Container(
        padding: EdgeInsets.only(left: 10.w, right: 10.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Popular',
              style: TextStyle(color: blackColor, fontSize: smallTextFontSize),
            ),
            GestureDetector(
              child: Text(
                'view all',
                style:
                    TextStyle(color: blackColor, fontSize: smallerTextFontSize),
              ),
              onTap: () {
                Get.toNamed(PRODUCTS_LIST_SCREEN,
                    arguments: [id, _controller.store.name, 'Popular']);
              },
            )
          ],
        ));
  }

  Widget showCategoriesList(BuildContext context) {
    return Obx(() {
      if (_controller.popstate is LoadingState) {
        return defaultLoading(context);
      }
      if (_controller.popstate is FinishedState) {
        return Container(
            height: 120.h,
            padding: EdgeInsets.only(left: 10.w, right: 10.w),
            child: ListView.separated(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                separatorBuilder: (context, index) => const SizedBox(width: 8),
                itemCount: _controller.categories.length,
                itemBuilder: (context, position) {
                  return singleCategoryItem(
                      _controller.categories[position],
                      () => Get.toNamed(PRODUCTS_LIST_SCREEN, arguments: [
                            id,
                            _controller.store.name,
                            _controller.categories[position].categoryName
                          ]));
                }));
      }
      return Container();
    });
  }
}
