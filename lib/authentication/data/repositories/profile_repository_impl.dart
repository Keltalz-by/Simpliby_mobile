import 'package:either_dart/either.dart';
import 'package:simplibuy/authentication/domain/entities/profile_details.dart';
import 'package:simplibuy/authentication/domain/repositories/profile_repository.dart';
import 'package:simplibuy/core/error_types/error_types.dart';
import 'package:simplibuy/core/network/network_info.dart';
import 'package:simplibuy/core/result/result.dart';
import 'package:simplibuy/core/failure/failure.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final NetworkInfo info;

  ProfileRepositoryImpl(this.info);

  @override
  Future<Either<Failure, Result<ProfileDatails>>> getUserDetails() async {
    if (await info.isConnected) {
      try {
        Future.delayed(const Duration(milliseconds: 2000));
        return Right(Result(
            value: ProfileDatails(
                'John Ikenwa',
                'John@gmail.com',
                null,
                null,
                null,
                'https://firebasestorage.googleapis.com/v0/b/fir-chatapp-f1bff.appspot.com/o/images%2FZhMQ0oPjDWTqSIGItRqm9wQkU452?alt=media&token=b203a1c0-1e97-4b59-835c-f9c1baa7c771')));
      } on Exception {
        return Left(Failure(error: ServerError()));
      }
    } else {
      return Left(Failure(error: InternetError()));
    }
  }

  @override
  Future<Either<Failure, Result<String>>> updateUserProfileDetails(
      ProfileDatails details) async {
    if (await info.isConnected) {
      try {
        Future.delayed(const Duration(milliseconds: 2000));
        return Right(Result(value: "Done"));
      } on Exception {
        return Left(Failure(error: ServerError()));
      }
    } else {
      return Left(Failure(error: InternetError()));
    }
  }
}
