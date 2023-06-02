import 'package:get/get.dart';
import 'package:simplibuy/authentication/data/datasources/registration_datasource.dart';
import 'package:simplibuy/authentication/data/repositories/forgot_password_repository_impl.dart';
import 'package:simplibuy/authentication/domain/usecases/forgot_password_usecase.dart';
import 'package:simplibuy/authentication/presentation/screen_model_controllers/forgot_password_controller.dart';
import 'package:simplibuy/core/network/network_info.dart';

class ForgotPasswordBinding implements Bindings {
  @override
  void dependencies() {
    NetworkInfoImpl info = Get.find();
    RegistrationDataSource dataSource = Get.put(RegistrationDataSource());
    ForgotPasswordRepoImpl repository = Get.put(
        ForgotPasswordRepoImpl(networkInfo: info, dataSource: dataSource));
    ForgotPasswordUsecase usecase = Get.put(ForgotPasswordUsecase(repository));
    Get.put<ForgotPasswordController>(ForgotPasswordController(usecase));
  }
}
