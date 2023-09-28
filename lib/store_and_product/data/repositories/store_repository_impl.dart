import 'package:either_dart/either.dart';
import 'package:simplibuy/core/network/network_info.dart';
import 'package:simplibuy/store_and_product/domain/entities/store_info.dart';
import 'package:simplibuy/store_and_product/domain/entities/store_category.dart';
import 'package:simplibuy/store_and_product/domain/entities/product.dart';
import 'package:simplibuy/core/result/result.dart';
import 'package:simplibuy/core/failure/failure.dart';
import 'package:simplibuy/store_and_product/domain/repository/store_repository.dart';
import '../../../core/error_types/error_types.dart';

class StoreRepositoryImpl implements StoreRepository {
  final NetworkInfo _networkInfo;

  StoreRepositoryImpl(this._networkInfo);
  @override
  Future<Either<Failure, Result<List<Product>>>> getPopularProducts() async {
    if (await _networkInfo.isConnected) {
      try {
        if (products.isEmpty) {
          return Left(Failure(error: EmptyListError()));
        }
        return Right(Result(value: products));
      } on Exception {
        return Left(Failure(error: ServerError()));
      }
    } else {
      return Left(Failure(error: InternetError()));
    }
  }

  @override
  Future<Either<Failure, Result<List<StoreCategory>>>> getStoreCategories(
      int storeId) async {
    if (await _networkInfo.isConnected) {
      try {
        if (categories.isEmpty) {
          return Left(Failure(error: EmptyListError()));
        }
        return Right(Result(value: categories));
      } on Exception {
        return Left(Failure(error: ServerError()));
      }
    } else {
      return Left(Failure(error: InternetError()));
    }
  }

  @override
  Future<Either<Failure, Result<StoreInfo>>> getStoreInfo(int storeId) async {
    if (await _networkInfo.isConnected) {
      try {
        return Right(Result(
            value: StoreInfo(
                2,
                "Shop rite",
                "32, Olorunsogo stret, Ejigbo, Lagos",
                "logo",
                "This store is the best store in the country with over 40 years of existence",
                "09028901282",
                "ebukaikenwa6419@gmail.com",
                1000,
                4,
                "")));
      } on Exception {
        return Left(Failure(error: ServerError()));
      }
    } else {
      return Left(Failure(error: InternetError()));
    }
  }

  var products = [
    Product(0, "Milk Milk", "sdan", "",
        ["https://lormfickr.com/g/320/240/paris,girl/all"], 400),
    Product(1, "Ofada rice", "sdan", "",
        ["https://loremfickr.com/g/320/240/paris,girl/all"], 40),
    Product(2, "Soldering Iron", "sdan", "",
        ["https:/loremflikr.com/g/320/240/paris,girl/all"], 40),
    Product(3, "Rice and Beans", "sdan", "",
        ["https:/loremflicr.com/g/320/240/paris,girl/all"], 40),
    Product(4, "Sofa chair", "sdan", "",
        ["https://lremflickr.com/g/320/240/paris,girl/all"], 400),
    Product(5, "Curtains", "sdan", "",
        ["https://oremflickr.com/g/320/240/paris,girl/all"], 400),
    Product(6, "Milk", "sdan", "",
        ["https://lremflickr.com/g/320/240/paris,girl/all"], 400),
    Product(7, "Milk Milk", "sdan", "",
        ["https://lormfickr.com/g/320/240/paris,girl/all"], 400),
    Product(8, "Milk", "sdan", "",
        ["https://loremfickr.com/g/320/240/paris,girl/all"], 400),
    Product(9, "Milk", "sdan", "",
        ["https:/loremflikr.com/g/320/240/paris,girl/all"], 400),
    Product(10, "Milk", "sdan", "",
        ["https:/loremflicr.com/g/320/240/paris,girl/all"], 400),
    Product(12, "Milk", "sdan", "",
        ["https://lremflickr.com/g/320/240/paris,girl/all"], 400),
    Product(13, "Milk", "sdan", "",
        ["https://oremflickr.com/g/320/240/paris,girl/all"], 400),
    Product(14, "Milk", "sdan", "",
        ["https://lremflickr.com/g/320/240/paris,girl/all"], 400)
  ];

  var categories = [
    StoreCategory(
        2, 'Cosmetics', 'https://lorflickr.com/g/320/240/paris,girl/all'),
    StoreCategory(2, 'Foods', 'https://lorflickr.com/g/320/240/paris,girl/all'),
    StoreCategory(
        2, 'Cutleries', 'https://lorflickr.com/g/320/240/paris,girl/all'),
    StoreCategory(
        2, 'Clothing', 'https://lorflickr.com/g/320/240/paris,girl/all'),
    StoreCategory(
        2, 'Jewelries', 'https://lorflickr.com/g/320/240/paris,girl/all'),
    StoreCategory(
        2, 'Frames', 'https://lorflickr.com/g/320/240/paris,girl/all'),
    StoreCategory(
        2, 'Electricity', 'https://loremickr.com/g/320/240/paris,girl/all'),
    StoreCategory(
        2, 'Electronics', 'https://loremflkr.com/g/320/240/paris,girl/all')
  ];

  @override
  Future<Either<Failure, Result<List<Product>>>> getProductsFromCategory(
      String category, int storeId) async {
    if (await _networkInfo.isConnected) {
      try {
        if (products.isEmpty) {
          return Left(Failure(error: EmptyListError()));
        }
        return Right(Result(value: products));
      } on Exception {
        return Left(Failure(error: ServerError()));
      }
    } else {
      return Left(Failure(error: InternetError()));
    }
  }
}
