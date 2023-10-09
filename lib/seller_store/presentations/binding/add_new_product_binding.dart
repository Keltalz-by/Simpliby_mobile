import 'package:get/instance_manager.dart';
import 'package:simplibuy/seller_store/data/datasources/product_and_category_datasource.dart';
import 'package:simplibuy/seller_store/domain/repo/product_and_category_repository.dart';
import 'package:simplibuy/seller_store/domain/usecases/add_new_prduct_usecase.dart';
import 'package:simplibuy/seller_store/presentations/controllers/add_new_product_controller.dart';
import 'package:simplibuy/core/network/network_info.dart';

class AddNewProductBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProductAndCategoryRepository>(() =>
        ProductAndCategoryRepositoryImpl(
            Get.find<NetworkInfoImpl>(), ProductAndCategoryDataSource()));
    Get.lazyPut(
        () => AddNewProductUsecase(Get.find<ProductAndCategoryRepository>()));
    Get.lazyPut<AddNewProductController>(
        () => AddNewProductController(Get.find<AddNewProductUsecase>()));
  }
}
