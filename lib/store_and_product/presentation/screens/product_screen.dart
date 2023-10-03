import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simplibuy/core/reusable_widgets/reusable_widgets.dart';
import 'package:simplibuy/store_and_product/presentation/controllers/product_controller.dart';
import 'package:simplibuy/store_and_product/presentation/screens/custom_widgets.dart';

import '../../../core/constant.dart';
import '../../../core/constants/route_constants.dart';
import '../../../core/error_types/error_types.dart';
import '../../../core/state/state.dart';
import '../../domain/entities/product.dart';

// ignore: must_be_immutable
class ProductScreen extends StatelessWidget {
  ProductScreen({Key? key}) : super(key: key);

  final ProductController _controller = Get.find<ProductController>();
  var args = Get.arguments;
  @override
  Widget build(BuildContext context) {
    _controller.getProduct(args[0]);
    return Scaffold(body: Obx(() {
      if (_controller.state == ErrorState(errorType: InternetError())) {
        return noInternetConnection(context);
      }
      if (_controller.state is FinishedState) {
        return _body(context, _controller.product);
      }
      return defaultLoading(context);
    }));
  }

  Widget _body(BuildContext context, Product product) {
    return SingleChildScrollView(
        child: Column(
      children: [
         //ImageSliderWithIndicator(imageUrls: product.productImage),
        Container(
          padding: const EdgeInsets.all(defaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Padding(padding: EdgeInsets.only(top: 30)),
              Text(product.productName,
                  style: const TextStyle(
                      color: blackColor,
                      fontSize: 23,
                      fontWeight: FontWeight.bold)),
              const Padding(padding: EdgeInsets.only(top: 10)),
              Text(product.productDescription,
                  style: const TextStyle(
                      color: blackColor,
                      fontSize: 18,
                      fontWeight: FontWeight.normal)),
              const Padding(padding: EdgeInsets.only(top: 20)),
              Text('Price: ${product.productPrice}',
                  style: const TextStyle(color: blackColor, fontSize: 20)),
              const Padding(padding: EdgeInsets.only(top: 10)),
              Text('Shelf details: ${product.shelfDetails}',
                  style: const TextStyle(color: blackColor, fontSize: 20)),
              const Padding(padding: EdgeInsets.only(top: 20)),
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                defaultButtons(
                    pressed: () {
                      Get.toNamed(RESERVE_SCREEN);
                    },
                    text: 'Reserve',
                    size: mediumWidthButtonSize),
                iconAsBtn(() {
                  _controller.addProductToCart(args[1], args[2]);
                  ScaffoldMessenger.of(context).showSnackBar(snackAdded);
                })
              ])
            ],
          ),
        )
      ],
    ));
  }
}
