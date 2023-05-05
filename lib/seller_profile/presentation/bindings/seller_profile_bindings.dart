import 'package:get/instance_manager.dart';
import 'package:simplibuy/core/network/network_info.dart';
import 'package:simplibuy/seller_profile/domain/repositories/seller_profile_repository.dart';
import 'package:simplibuy/seller_profile/domain/usecases/seller_profile_usecase.dart';
import 'package:simplibuy/seller_profile/presentation/controllers/seller_profile_controller.dart';

class SellerProfileBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SellerProfileRepository>(
        () => SellerProfileRepositoryImpl(Get.find<NetworkInfoImpl>()));
    Get.lazyPut(
        () => SellerProfileUsecase(Get.find<SellerProfileRepository>()));
    Get.lazyPut(() =>
        SellerProfileController(usecase: Get.find<SellerProfileUsecase>()));
  }
}
