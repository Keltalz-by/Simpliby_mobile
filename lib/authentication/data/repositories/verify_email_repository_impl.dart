import 'dart:convert';

import 'package:either_dart/either.dart';
import 'package:simplibuy/authentication/data/datasources/registration_datasource.dart';
import 'package:simplibuy/core/error_types/error_types.dart';
import 'package:simplibuy/core/failure/failure.dart';
import 'package:simplibuy/core/network/network_info.dart';
import 'package:simplibuy/core/prefs/shared_prefs.dart';
import 'package:simplibuy/core/result/result.dart';

class VerifyEmailRepoImpl {
  final NetworkInfo networkInfo;
  final RegistrationDataSource dataSource;

  VerifyEmailRepoImpl({required this.networkInfo, required this.dataSource});

  Future<Either<Failure, Result<String>>> verifyEmail(
      String userId, String otp) async {
    if (await networkInfo.isConnected) {
      print("UID is $userId");

      try {
        final res = await dataSource.verifyEmail(userId, otp);
        if (res.statusCode == 200) {
          await SharedPrefs.initializeSharedPrefs();
          SharedPrefs.setVerificationStatus(true);
          return Right(Result(value: "Successful"));
        } else {
          final message = json.decode(res.body)['message'];
          return Left(
              Failure.withMessage(error: ServerError(), message: message));
        }
      } on Exception {
        return Left(Failure(error: ServerError()));
      }
    }
    return Left(Failure(error: InternetError()));
  }

  Future<Either<Failure, Result<String>>> resendOtp(
      String userId, String email) async {
    if (await networkInfo.isConnected) {
      try {
        final res = await dataSource.resendOtp(userId, email);
        print("Saved email is $email and id is $userId");
        if (res.statusCode == 200) {
          return Right(Result(value: "Successful"));
        } else {
          final message = json.decode(res.body)['message'];
          return Left(
              Failure.withMessage(error: ServerError(), message: message));
        }
      } on Exception {
        return Left(Failure(error: ServerError()));
      }
    }
    return Left(Failure(error: InternetError()));
  }
}
