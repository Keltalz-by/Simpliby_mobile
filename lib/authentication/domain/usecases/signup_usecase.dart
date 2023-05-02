import 'package:either_dart/either.dart';
import 'package:simplibuy/authentication/data/models/signup_details.dart';
import 'package:simplibuy/authentication/domain/repositories/auth_repository.dart';
import '../../../core/failure/failure.dart';
import '../../../core/result/result.dart';

class SignupUsecase {
  final AuthRepository repository;
  SignupUsecase(this.repository);

  Future<Either<Failure, Result<String>>> authenticateWithFacebook() async {
    return repository.authenticateWithFacebook();
  }

  Future<Either<Failure, Result<String>>> sendAuthDetails(
      SignupDetail detail) async {
    return repository.sendAuthDetails(detail);
  }

  Future<Either<Failure, Result<String>>> authenticateWithGoogle() async {
    return repository.authenticateWithGoogle();
  }
}
