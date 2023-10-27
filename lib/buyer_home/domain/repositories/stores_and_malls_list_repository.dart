import 'dart:convert';

import 'package:either_dart/either.dart';
import 'package:simplibuy/buyer_home/data/datasource/retrieve_stores_datasource.dart';
import 'package:simplibuy/buyer_home/domain/entities/strore_details.dart';
import 'package:simplibuy/core/failure/failure.dart';
import '../../../core/result/result.dart';
import 'package:simplibuy/core/error_types/error_types.dart';
import 'package:simplibuy/core/network/network_info.dart';

abstract class StoresAndMallsRepository {
  Future<Either<Failure, Result<StoreDetails>>> getStores();
  Future<Either<Failure, Result<StoreDetails>>> getMalls();
  Future<Either<Failure, Result<StoreDetails>>> searchStoreOrMall(String query);
}

class StoresAndMallsRepositoryImpl implements StoresAndMallsRepository {
  final NetworkInfo networkInfo;
  final RetrieveStoresDataSource dataSource;

  StoresAndMallsRepositoryImpl(this.networkInfo, this.dataSource);
  @override
  Future<Either<Failure, Result<StoreDetails>>> getMalls() async {
    if (await networkInfo.isConnected) {
      try {
        final res = await dataSource.getStores();
        final status = json.decode(res.body);
        if (res.statusCode == 201 && status == true) {
          return Right(Result(value: StoreDetails.fromJson(status)));
        } else {
          final message = json.decode(res.body)['message'];
          return Left(
              Failure.withMessage(error: ServerError(), message: message));
        }
      } on Exception {
        return Left(Failure(error: ServerError()));
      }
    } else {
      return Left(Failure(error: InternetError()));
    }
  }

  @override
  Future<Either<Failure, Result<StoreDetails>>> getStores() async {
    if (await networkInfo.isConnected) {
      try {
        final res = await dataSource.getStores();
        final status = json.decode(res.body);
        print(status);
        if (res.statusCode == 200 && status["success"] == true) {
          return Right(Result(value: StoreDetails.fromJson(status)));
        } else {
          final message = status['message'];
          return Left(
              Failure.withMessage(error: ServerError(), message: message));
        }
      } on Exception {
        return Left(Failure(error: ServerError()));
      }
    } else {
      return Left(Failure(error: InternetError()));
    }
  }

  @override
  Future<Either<Failure, Result<StoreDetails>>> searchStoreOrMall(
      String query) async {
    if (await networkInfo.isConnected) {
      try {
        final res = await dataSource.searchStores(query);
        final status = json.decode(res.body);
        if (res.statusCode == 200 && status["success"] == true) {
          return Right(Result(value: StoreDetails.fromJson(status)));
        } else {
          final message = status['message'];
          return Left(
              Failure.withMessage(error: ServerError(), message: message));
        }
      } on Exception {
        return Left(Failure(error: ServerError()));
      }
    } else {
      return Left(Failure(error: InternetError()));
    }
  }
}
