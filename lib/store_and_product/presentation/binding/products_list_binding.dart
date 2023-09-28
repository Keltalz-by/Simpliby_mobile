import 'package:get/get.dart';
import 'package:simplibuy/store_and_product/presentation/controllers/product_list_controller.dart';

import '../../domain/repository/add_to_cart_repo.dart';
import '../../domain/repository/store_repository.dart';
import '../../domain/usecases/products_list_usecase.dart';

class ProductListBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProductListUsecase>(() => ProductListUsecase(
        Get.find<StoreRepository>(), Get.find<AddToCartRepo>()));
    Get.lazyPut<ProductListController>(
        () => ProductListController(Get.find<ProductListUsecase>()));
  }
}
