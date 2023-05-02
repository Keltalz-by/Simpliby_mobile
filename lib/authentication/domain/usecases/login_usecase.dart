import 'package:either_dart/either.dart';
import 'package:simplibuy/authentication/data/models/login_details.dart';
import 'package:simplibuy/authentication/domain/repositories/auth_repository.dart';
import '../../../core/failure/failure.dart';
import '../../../core/result/result.dart';

class LoginUsecase {
  final AuthRepository repository;
  LoginUsecase(this.repository);

  Future<Either<Failure, Result<String>>> authenticateWithFacebook() async {
    return repository.authenticateWithFacebook();
  }

  Future<Either<Failure, Result<String>>> sendAuthDetails(
      LoginDetail detail) async {
    return repository.sendAuthDetails(detail);
  }

  Future<Either<Failure, Result<String>>> authenticateWithGoogle() async {
    return repository.authenticateWithGoogle();
  }
}
