import 'package:get/instance_manager.dart';
import 'package:simplibuy/core/network/network_info.dart';
import 'package:simplibuy/seller_payments/domain/repository/seller_payment_repository.dart';
import 'package:simplibuy/seller_payments/domain/usecase/seller_payment_usecase.dart';
import 'package:simplibuy/seller_payments/presentation/controllers/seller_payment_controller.dart';

class SellerPaymentsBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SellerPaymentRepository>(
        () => SellerPaymentRepositoryImpl(Get.find<NetworkInfoImpl>()));
    Get.lazyPut(
        () => SellerPaymentUsecase(Get.find<SellerPaymentRepository>()));
    Get.lazyPut<SellerPaymentController>(() =>
        SellerPaymentController(usecase: Get.find<SellerPaymentUsecase>()));
  }
}
