import 'package:either_dart/either.dart';
import 'package:simplibuy/authentication/data/repositories/verify_email_repository_impl.dart';
import '../../../core/failure/failure.dart';
import '../../../core/result/result.dart';

class VerifyEmailUsecase {
  final VerifyEmailRepoImpl repository;
  VerifyEmailUsecase(this.repository);

  Future<Either<Failure, Result<String>>> verifyEmail(
      String userId, String otp) async {
    return repository.verifyEmail(userId, otp);
  }

  Future<Either<Failure, Result<String>>> resendOtp(
      String userId, String email) async {
    return repository.resendOtp(userId, email);
  }
}
