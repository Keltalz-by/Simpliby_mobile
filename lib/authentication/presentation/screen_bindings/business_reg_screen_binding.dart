import 'package:get/get.dart';
import 'package:simplibuy/authentication/data/datasources/stores_creation_datasource.dart';
import 'package:simplibuy/authentication/data/repositories/business_reg_repository.dart';
import 'package:simplibuy/authentication/domain/usecases/business_reg_usecase.dart';
import 'package:simplibuy/authentication/presentation/screen_model_controllers/business_reg_controller.dart';
import 'package:simplibuy/core/network/network_info.dart';

class BusinessRegScreenBinding implements Bindings {
  @override
  void dependencies() {
    NetworkInfoImpl info = Get.find();
    StoresCreationDataSource dataSource = Get.put(StoresCreationDataSource());
    BusinessRegRepository repository = Get.put(
        BusinessRegRepositoryImpl(networkInfo: info, dataSource: dataSource));
    Get.lazyPut<BusinessRegUsecase>(() => BusinessRegUsecase(repository));
    Get.put<BusinessRegController>(
        BusinessRegController(Get.find<BusinessRegUsecase>()));
  }
}
