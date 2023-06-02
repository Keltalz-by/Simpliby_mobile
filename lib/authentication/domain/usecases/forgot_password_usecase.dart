import 'package:either_dart/either.dart';
import 'package:simplibuy/authentication/data/repositories/forgot_password_repository_impl.dart';
import '../../../core/failure/failure.dart';
import '../../../core/result/result.dart';

class ForgotPasswordUsecase {
  final ForgotPasswordRepoImpl repository;
  ForgotPasswordUsecase(this.repository);

  Future<Either<Failure, Result<String>>> sendPaswordResetCode(String email) {
    return repository.sendPaswordResetCode(email);
  }
}
