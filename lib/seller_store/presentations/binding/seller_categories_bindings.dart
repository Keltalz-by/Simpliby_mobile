import 'package:get/instance_manager.dart';
import 'package:simplibuy/core/network/network_info.dart';
import 'package:simplibuy/seller_store/data/datasources/product_and_category_datasource.dart';
import 'package:simplibuy/seller_store/domain/repo/product_and_category_repository.dart';
import 'package:simplibuy/seller_store/presentations/controllers/seller_categories_controller.dart';

class SellerCategoriesBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProductAndCategoryRepository>(() =>
        ProductAndCategoryRepositoryImpl(
            Get.find<NetworkInfoImpl>(), ProductAndCategoryDataSource()));

    Get.lazyPut(() => SellerCategoriesController(
        repo: Get.find<ProductAndCategoryRepository>()));
  }
}
