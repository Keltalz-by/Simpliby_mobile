import 'dart:convert';

import 'package:either_dart/either.dart';
import 'package:get/get.dart';
import 'package:simplibuy/authentication/data/datasources/registration_datasource.dart';
import 'package:simplibuy/authentication/data/models/login_details.dart';
import 'package:simplibuy/authentication/domain/repositories/auth_repository.dart';
import 'package:simplibuy/core/error_types/error_types.dart';
import 'package:simplibuy/core/failure/failure.dart';
import 'package:simplibuy/core/prefs/shared_prefs.dart';
import 'package:simplibuy/core/result/result.dart';
import '../../../core/network/network_info.dart';

typedef _TestResult = Future<Result<LoginDetail>> Function();

class LoginRepositoryImpl implements AuthRepository<LoginDetail> {
  final NetworkInfo networkInfo;
  final RegistrationDataSource dataSource;

  LoginRepositoryImpl({required this.networkInfo, required this.dataSource});

  @override
  Future<Either<Failure, Result<String>>> sendAuthDetails(
      LoginDetail detail) async {
    if (await networkInfo.isConnected) {
      try {
        final res = await dataSource.loginUser(detail);
        final message = json.decode(res.body)['message'];

        if (res.statusCode == 200) {
          final userId = json.decode(res.body)['data']['_id'];
          final userEmail = json.decode(res.body)['data']['email'];
          final userName = json.decode(res.body)['data']['name'];
          storeUserDetails(userId, userEmail, userName);

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
        res;
        return Right(Result(value: ""));
      } on Exception {
        return Left(Failure(error: ServerError()));
      }
    }
    return Left(Failure(error: InternetError()));
  }

  storeUserDetails(String id, String email, String name) async {
    await SharedPrefs.initializeSharedPrefs();
    SharedPrefs.setUserId(id);
    SharedPrefs.setUserEmail(email);
    SharedPrefs.setUserName(name);
    SharedPrefs.setVerificationStatus(true);
  }
}
