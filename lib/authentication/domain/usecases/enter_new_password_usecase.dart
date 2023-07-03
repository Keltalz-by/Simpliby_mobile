import 'package:either_dart/either.dart';
import 'package:simplibuy/authentication/data/repositories/enter_new_password_repository_impl.dart';
import '../../../core/failure/failure.dart';
import '../../../core/result/result.dart';

class EnterNewPasswordUsecase {
  final EnterNewPasswordRepoIml repository;
  EnterNewPasswordUsecase(this.repository);

  Future<Either<Failure, Result<String>>> resetPassword(
      String password, String passwordConfirm) {
    return repository.resetPassword(password, passwordConfirm);
  }
}
