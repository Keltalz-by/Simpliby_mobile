import 'package:get/get.dart';
import 'package:simplibuy/core/local_db/cart_dao.dart';
import 'package:simplibuy/core/network/network_info.dart';
import 'package:simplibuy/store_and_product/data/datasources/cart_local_data_source.dart';
import 'package:simplibuy/store_and_product/data/repositories/add_to_cart_repo_impl.dart';
import 'package:simplibuy/store_and_product/data/repositories/store_repository_impl.dart';
import 'package:simplibuy/store_and_product/domain/repository/add_to_cart_repo.dart';
import 'package:simplibuy/store_and_product/domain/repository/store_repository.dart';
import 'package:simplibuy/store_and_product/domain/usecases/products_list_usecase.dart';
import 'package:simplibuy/store_and_product/domain/usecases/store_usecase.dart';
import 'package:simplibuy/store_and_product/presentation/controllers/store_detail_controller.dart';

class StoreInfoBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CartLocalDataSource>(
        () => CartLocalDataSource(Get.find<CartDao>()));
    Get.lazyPut<AddToCartRepo>(
        () => AddToCartRepoImpl(Get.find<CartLocalDataSource>()));
    Get.lazyPut<StoreRepository>(
        () => StoreRepositoryImpl(Get.find<NetworkInfoImpl>()));
    Get.lazyPut<StoreUsecase>(() => StoreUsecase(Get.find<StoreRepository>()));
    Get.lazyPut<ProductListUsecase>(() => ProductListUsecase(
        Get.find<StoreRepository>(), Get.find<AddToCartRepo>()));
    Get.lazyPut<StoreDetailController>(() => StoreDetailController(
        Get.find<StoreUsecase>(), Get.find<ProductListUsecase>()));
  }
}
