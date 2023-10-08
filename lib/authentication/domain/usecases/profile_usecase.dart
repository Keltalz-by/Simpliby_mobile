import 'package:either_dart/either.dart';
import 'package:simplibuy/authentication/domain/entities/profile_details.dart';
import 'package:simplibuy/authentication/domain/repositories/profile_repository.dart';
import '../../../core/failure/failure.dart';
import '../../../core/result/result.dart';

class ProfileUsecase {
  final ProfileRepository repo;

  ProfileUsecase(this.repo);

  Future<Either<Failure, Result<ProfileDatails>>> getUserDetails() async {
    return repo.getUserDetails();
  }

  Future<Either<Failure, Result<String>>> updateUserProfileDetails(
      ProfileDatails details) async {
    return await repo.updateUserProfileDetails(details);
  }
}
