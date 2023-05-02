import 'package:get/get.dart';
import 'package:simplibuy/authentication/data/datasources/registration_datasource.dart';
import 'package:simplibuy/authentication/data/repositories/login_repository.dart';
import 'package:simplibuy/authentication/data/repositories/verify_email_repository_impl.dart';
import 'package:simplibuy/authentication/domain/usecases/login_usecase.dart';
import 'package:simplibuy/authentication/domain/usecases/resend_otp_usecase.dart';
import 'package:simplibuy/authentication/presentation/screen_model_controllers/login_screen_controller.dart';
import 'package:simplibuy/core/network/network_info.dart';

class LoginScreenBinding implements Bindings {
  @override
  void dependencies() {
    NetworkInfoImpl info = Get.find();
    RegistrationDataSource dataSource = Get.put(RegistrationDataSource());
    LoginRepositoryImpl repository =
        Get.put(LoginRepositoryImpl(networkInfo: info, dataSource: dataSource));
    Get.lazyPut<VerifyEmailRepoImpl>(
        () => VerifyEmailRepoImpl(networkInfo: info, dataSource: dataSource));
    Get.lazyPut<LoginUsecase>(() => LoginUsecase(repository));
    ResendOtpUsecase usecaseOtp =
        Get.put(ResendOtpUsecase(Get.find<VerifyEmailRepoImpl>()));
    Get.put<LoginScreenController>(
        LoginScreenController(Get.find<LoginUsecase>(), usecaseOtp));
  }
}
