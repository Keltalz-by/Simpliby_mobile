import 'package:get/instance_manager.dart';
import 'package:simplibuy/add_new_product/domain/repositories/add_new_product_repository.dart';
import 'package:simplibuy/add_new_product/domain/usecases/add_new_prduct_usecase.dart';
import 'package:simplibuy/add_new_product/presentation/controllers/add_new_product_controller.dart';
import 'package:simplibuy/core/network/network_info.dart';

class AddNewProductBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddNewProductRepository>(
        () => AddNewProductRepositoryImpl(Get.find<NetworkInfoImpl>()));
    Get.lazyPut(
        () => AddNewProductUsecase(Get.find<AddNewProductRepository>()));
    Get.lazyPut<AddNewProductController>(
        () => AddNewProductController(Get.find<AddNewProductUsecase>()));
  }
}
