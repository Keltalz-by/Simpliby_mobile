import 'dart:convert';

import 'package:either_dart/either.dart';
import 'package:get/get.dart';
import 'package:simplibuy/authentication/data/datasources/registration_datasource.dart';
import 'package:simplibuy/authentication/data/models/signup_details.dart';
import 'package:simplibuy/authentication/domain/repositories/auth_repository.dart';
import 'package:simplibuy/core/error_types/error_types.dart';
import 'package:simplibuy/core/failure/failure.dart';
import 'package:simplibuy/core/prefs/shared_prefs.dart';
import 'package:simplibuy/core/result/result.dart';
import '../../../core/network/network_info.dart';

typedef _TestResult = Future<Result<SignupDetail>> Function();

class SignupRepositoryImpl implements AuthRepository<SignupDetail> {
  final NetworkInfo networkInfo;
  final RegistrationDataSource dataSource;

  SignupRepositoryImpl({required this.networkInfo, required this.dataSource});

  @override
  Future<Either<Failure, Result<String>>> sendAuthDetails(
      SignupDetail detail) async {
    if (await networkInfo.isConnected) {
      try {
        final res = await dataSource.registerUser(detail);
        final message = json.decode(res.body)['message'];
        if (res.statusCode == 201) {
          final userId = json.decode(res.body)['data'];
          print(userId);
          storeUserId(userId);
          return Right(Result(value: message));
        } else {
          return Left(
              Failure.withMessage(error: ServerError(), message: message));
        }
      } on Exception {
        return Left(Failure(error: ServerError()));
      }
    }
    return Left(Failure(error: InternetError()));
  }

  @override
  Future<Either<Failure, Result<String>>> authenticateWithFacebook() async {
    return await _doTask(() {
      return Future.delayed(1000.milliseconds);
    });
  }

  @override
  Future<Either<Failure, Result<String>>> authenticateWithGoogle() async {
    return await _doTask(() {
      return Future.delayed(1000.milliseconds);
    });
  }

  Future<Either<Failure, Result<String>>> _doTask(
    _TestResult res,
  ) async {
    if (await networkInfo.isConnected) {
      try {
        final res = dataSource;
        return Right(Result(value: ""));
      } on Exception {
        return Left(Failure(error: ServerError()));
      }
    }
    return Left(Failure(error: InternetError()));
  }

  storeUserId(String id) async {
    await SharedPrefs.initializeSharedPrefs();
    SharedPrefs.setUserId(id);
  }
}
