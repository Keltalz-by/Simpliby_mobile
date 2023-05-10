import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simplibuy/core/error_types/error_types.dart';
import 'package:simplibuy/core/reusable_widgets/reusable_widgets.dart';
import 'package:simplibuy/core/state/state.dart';
import 'package:simplibuy/store_and_product/presentation/controllers/product_list_controller.dart';
import 'package:simplibuy/store_and_product/presentation/screens/custom_widgets.dart';

import '../../../core/constants/route_constants.dart';

// ignore: must_be_immutable
class ProductsListScreen extends StatelessWidget {
  ProductsListScreen({Key? key}) : super(key: key);

  final ProductListController _controller = Get.find<ProductListController>();
  var args = Get.arguments;

  @override
  Widget build(BuildContext context) {
    _controller.getProductsFromCategory(args[1], args[0]);
    return Scaffold(
        appBar: customAppBar(text: args[2], onPressed: () => Get.back()),
        body: Obx(() {
          if (_controller.state == ErrorState(errorType: InternetError())) {
            return noInternetConnection(context);
          }

          if (_controller.state is FinishedState) {
            return Container(
                padding: const EdgeInsets.all(10),
                child: Flexible(
                    child: GridView.count(
                        shrinkWrap: true,
                        crossAxisCount: 2,
                        physics: const ScrollPhysics(),
                        crossAxisSpacing: 8.0,
                        mainAxisSpacing: 8.0,
                        children: List.generate(
                            _controller.product.length,
                            (index) => Center(
                                child: productListContainer(
                                    context: context,
                                    product: _controller.product[index],
                                    onProductClick: () =>
                                        Get.toNamed(PRODUCT_SCREEN, arguments: [
                                          _controller.product[index].productId,
                                          args[1],
                                          args[0]
                                        ]),
                                    onAddBtnClicked: () {
                                      _controller.addProductToCart(
                                          index, args[1], args[0]);
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(snackAdded);
                                    }))))));
          }
          return defaultLoading(context);
        }));
  }
}
