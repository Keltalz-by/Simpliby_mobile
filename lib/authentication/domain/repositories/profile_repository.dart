import 'package:either_dart/either.dart';
import 'package:simplibuy/authentication/domain/entities/profile_details.dart';
import 'package:simplibuy/core/failure/failure.dart';
import 'package:simplibuy/core/result/result.dart';

abstract class ProfileRepository {
  Future<Either<Failure, Result<ProfileDatails>>> getUserDetails();
  Future<Either<Failure, Result<String>>> updateUserProfileDetails(
      ProfileDatails details);
}
