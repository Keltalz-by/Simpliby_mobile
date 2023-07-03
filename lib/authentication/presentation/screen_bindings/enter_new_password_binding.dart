import 'package:get/get.dart';
import 'package:simplibuy/authentication/data/datasources/registration_datasource.dart';
import 'package:simplibuy/authentication/data/repositories/enter_new_password_repository_impl.dart';
import 'package:simplibuy/authentication/domain/usecases/enter_new_password_usecase.dart';
import 'package:simplibuy/authentication/presentation/screen_model_controllers/enter_new_password_controller.dart';
import 'package:simplibuy/core/network/network_info.dart';

class EnterNewPasswordBinding implements Bindings {
  @override
  void dependencies() {
    NetworkInfoImpl info = Get.find();
    RegistrationDataSource dataSource = Get.put(RegistrationDataSource());
    EnterNewPasswordRepoIml repository = Get.put(
        EnterNewPasswordRepoIml(networkInfo: info, dataSource: dataSource));
    EnterNewPasswordUsecase usecase =
        Get.put(EnterNewPasswordUsecase(repository));
    Get.put<EnterNewPasswordController>(EnterNewPasswordController(usecase));
  }
}
