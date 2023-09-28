import 'package:simplibuy/store_and_product/domain/repository/product_repo.dart';
import 'package:get/get.dart';

import '../../../core/network/network_info.dart';
import '../../data/repositories/product_repo_impl.dart';
import '../../domain/repository/add_to_cart_repo.dart';
import '../../domain/usecases/product_usecase.dart';
import '../controllers/product_controller.dart';

class ProductBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProductRepo>(
        () => ProductRepoImpl(Get.find<NetworkInfoImpl>()));
    Get.lazyPut<ProductUsecase>(() =>
        ProductUsecase(Get.find<ProductRepo>(), Get.find<AddToCartRepo>()));
    Get.lazyPut<ProductController>(
        () => ProductController(Get.find<ProductUsecase>()));
  }
}
