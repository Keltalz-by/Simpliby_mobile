import 'dart:convert';

import 'package:either_dart/either.dart';
import 'package:simplibuy/authentication/data/datasources/registration_datasource.dart';
import 'package:simplibuy/core/error_types/error_types.dart';
import 'package:simplibuy/core/failure/failure.dart';
import 'package:simplibuy/core/network/network_info.dart';
import 'package:simplibuy/core/result/result.dart';

class ForgotPasswordRepoImpl {
  final NetworkInfo networkInfo;
  final RegistrationDataSource dataSource;

  ForgotPasswordRepoImpl({required this.networkInfo, required this.dataSource});

  Future<Either<Failure, Result<String>>> sendPaswordResetCode(
      String email) async {
    if (await networkInfo.isConnected) {
      try {
        final res = await dataSource.sendCodePasswordReset(email);
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

  Future<Either<Failure, Result<String>>> resendOtp(
      String userId, String email) async {
    if (await networkInfo.isConnected) {
      try {
        final res = await dataSource.resendOtp(userId, email);
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
