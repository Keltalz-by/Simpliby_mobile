import 'package:get/instance_manager.dart';
import 'package:simplibuy/core/network/network_info.dart';
import 'package:simplibuy/seller_products/domain/repositories/seller_products_repository.dart';
import 'package:simplibuy/seller_products/domain/usecases/seller_products_usecase.dart';
import 'package:simplibuy/seller_products/presentation/controllers/seller_products_controller.dart';

class SellerProductsBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SellerProductsRepository>(
        () => SellerProductsRepositoryImpl(Get.find<NetworkInfoImpl>()));
    Get.lazyPut(
        () => SellerProductsUsecase(Get.find<SellerProductsRepository>()));
    Get.lazyPut(() =>
        SellerProductsController(usecase: Get.find<SellerProductsUsecase>()));
  }
}
