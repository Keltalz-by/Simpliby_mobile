import 'dart:convert';

import 'package:either_dart/either.dart';
import 'package:simplibuy/buyer_home/data/datasource/retrieve_stores_datasource.dart';
import 'package:simplibuy/buyer_home/domain/entities/strore_details.dart';
import 'package:simplibuy/core/failure/failure.dart';
import '../../../core/result/result.dart';
import 'package:simplibuy/core/error_types/error_types.dart';
import 'package:simplibuy/core/network/network_info.dart';

abstract class StoresAndMallsRepository {
  Future<Either<Failure, Result<List<StoreDetails>>>> getStores();
  Future<Either<Failure, Result<List<StoreDetails>>>> getMalls();
  Future<Either<Failure, Result<List<StoreDetails>>>> searchStoreOrMall(
      String query);
}

class StoresAndMallsRepositoryImpl implements StoresAndMallsRepository {
  final NetworkInfo networkInfo;
  final RetrieveStoresDataSource dataSource;

  StoresAndMallsRepositoryImpl(this.networkInfo, this.dataSource);
  @override
  Future<Either<Failure, Result<List<StoreDetails>>>> getMalls() async {
    if (await networkInfo.isConnected) {
      try {
        return Right(Result(value: malls));
      } on Exception {
        return Left(Failure(error: ServerError()));
      }
    } else {
      return Left(Failure(error: InternetError()));
    }
  }

  List<StoreDetails> stores = const <StoreDetails>[
    StoreDetails(
        id: 0,
        name: 'Stores Stores Stores Stores',
        location: "New Haven, Enugu"),
    StoreDetails(id: 1, name: 'Roban Stores', location: "Old Haven, Enugu"),
    StoreDetails(id: 3, name: 'Spar Stores', location: "New Haven, Enugu"),
    StoreDetails(id: 5, name: 'Shoprite Stores', location: "New Haven, Enugu"),
    StoreDetails(id: 6, name: 'Shoprite Stores', location: "New Haven, Enugu"),
    StoreDetails(
        id: 7, name: 'Home stores StoresStoresStores', location: "Perfect"),
    StoreDetails(id: 8, name: 'Home', location: "Perfect"),
    StoreDetails(id: 9, name: 'Home', location: "Perfect"),
  ];

  List<StoreDetails> malls = const <StoreDetails>[
    StoreDetails(id: 12, name: 'Shoprite Mall', location: "New Haven, Enugu"),
    StoreDetails(id: 13, name: 'Roban Mall', location: "Old Haven, Enugu"),
    StoreDetails(id: 15, name: 'Spar mall', location: "New Haven, Enugu"),
    StoreDetails(id: 16, name: 'Shoprite Mall', location: "New Haven, Enugu"),
    StoreDetails(id: 17, name: 'Shoprite Mall', location: "New Haven, Enugu"),
    StoreDetails(id: 19, name: 'Home', location: "Perfect"),
    StoreDetails(id: 20, name: 'Home', location: "Perfect"),
    StoreDetails(id: 30, name: 'Home', location: "Perfect"),
  ];

  @override
  Future<Either<Failure, Result<List<StoreDetails>>>> getStores() async {
    if (await networkInfo.isConnected) {
      try {
        return Right(Result(value: stores));
      } on Exception {
        return Left(Failure(error: ServerError()));
      }
    } else {
      return Left(Failure(error: InternetError()));
    }
  }

  @override
  Future<Either<Failure, Result<List<StoreDetails>>>> searchStoreOrMall(
      String query) async {
    if (await networkInfo.isConnected) {
      try {
        final res = await dataSource.searchStores(query);
        final message = json.decode(res.body)['message'];

        if (res.statusCode == 200) {
          return Right(Result(value: []));
        } else {
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
