import 'package:get/get.dart';
import 'package:simplibuy/core/network/network_info.dart';
import 'package:simplibuy/seller_home/presentation/controllers/seller_home_nav_controller.dart';
import 'package:simplibuy/seller_payments/domain/repository/seller_payment_repository.dart';
import 'package:simplibuy/seller_payments/domain/usecase/seller_payment_usecase.dart';
import 'package:simplibuy/seller_payments/presentation/controllers/seller_payment_controller.dart';
import 'package:simplibuy/seller_profile/domain/repositories/seller_profile_repository.dart';
import 'package:simplibuy/seller_profile/domain/usecases/seller_profile_usecase.dart';
import 'package:simplibuy/seller_profile/presentation/controllers/seller_profile_controller.dart';

class SellerHomeBindings implements Bindings {
  @override
  Future<void> dependencies() async {
    Get.lazyPut<SellerHomeNavigationController>(
        () => SellerHomeNavigationController());

    Get.lazyPut<SellerPaymentRepository>(
        () => SellerPaymentRepositoryImpl(Get.find<NetworkInfoImpl>()));
    Get.lazyPut(
        () => SellerPaymentUsecase(Get.find<SellerPaymentRepository>()));
    Get.lazyPut<SellerPaymentController>(() =>
        SellerPaymentController(usecase: Get.find<SellerPaymentUsecase>()));

    Get.lazyPut<SellerProfileRepository>(
        () => SellerProfileRepositoryImpl(Get.find<NetworkInfoImpl>()));
    Get.lazyPut(
        () => SellerProfileUsecase(Get.find<SellerProfileRepository>()));
    Get.lazyPut(() =>
        SellerProfileController(usecase: Get.find<SellerProfileUsecase>()));
  }
}
