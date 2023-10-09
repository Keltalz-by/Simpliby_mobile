import 'dart:convert';

import 'package:either_dart/either.dart';
import 'package:simplibuy/authentication/data/datasources/registration_datasource.dart';
import 'package:simplibuy/authentication/data/datasources/stores_creation_datasource.dart';
import 'package:simplibuy/authentication/data/models/business_reg_details.dart';
import 'package:simplibuy/core/error_types/error_types.dart';
import 'package:simplibuy/core/failure/failure.dart';
import 'package:simplibuy/core/network/network_info.dart';
import 'package:simplibuy/core/result/result.dart';

abstract class BusinessRegRepository {
  Future<Either<Failure, Result<String>>> sendBusinessDetails(
      BusinessRegDetails details);
}

class BusinessRegRepositoryImpl implements BusinessRegRepository {
  final NetworkInfo networkInfo;
  final StoresCreationDataSource dataSource;

  BusinessRegRepositoryImpl(
      {required this.networkInfo, required this.dataSource});
  @override
  Future<Either<Failure, Result<String>>> sendBusinessDetails(
      BusinessRegDetails details) async {
    if (await networkInfo.isConnected) {
      try {
        final res = await dataSource.createStore(details);
        final message = json.decode(res.body)['message'];
        if (res.statusCode == 201) {
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
}
