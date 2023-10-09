import 'dart:convert';

import 'package:either_dart/either.dart';
import 'package:simplibuy/seller_store/data/datasources/product_and_category_datasource.dart';
import 'package:simplibuy/seller_store/data/models/category.dart';
import 'package:simplibuy/seller_store/data/models/new_product.dart';
import 'package:simplibuy/core/error_types/error_types.dart';
import 'package:simplibuy/core/failure/failure.dart';
import 'package:simplibuy/core/network/network_info.dart';
import 'package:simplibuy/core/result/result.dart';
import 'package:simplibuy/seller_store/data/models/product.dart';

abstract class ProductAndCategoryRepository {
  Future<Either<Failure, Result<String>>> addNewProduct(AddNewProduct detail);
  Future<Either<Failure, Result<List<SingleProduct>>>> getAllProducts();
  Future<Either<Failure, Result<List<SingleProduct>>>> getProductByCategory(
      String id);
  Future<Either<Failure, Result<List<Category>>>> getAllCategory();
}

class ProductAndCategoryRepositoryImpl implements ProductAndCategoryRepository {
  final NetworkInfo info;
  final ProductAndCategoryDataSource dataSource;

  ProductAndCategoryRepositoryImpl(this.info, this.dataSource);

  @override
  Future<Either<Failure, Result<String>>> addNewProduct(
      AddNewProduct detail) async {
    if (await info.isConnected) {
      try {
        final res = await dataSource.createAProduct(detail);
        final status = json.decode(res.body)['success'];
        if (res.statusCode == 201 && status == true) {
          return Right(Result(value: "Success"));
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

  @override
  Future<Either<Failure, Result<List<Category>>>> getAllCategory() async {
    if (await info.isConnected) {
      try {
        final res = await dataSource.getAllCategory();
        final status = json.decode(res.body)['success'];
        if (res.statusCode == 200 && status == true) {
          final List<dynamic> data = json.decode(res.body)['data'];
          final List<Category> categories =
              data.map((item) => Category.fromJson(item)).toList();
          return Right(Result(value: categories));
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

  @override
  Future<Either<Failure, Result<List<SingleProduct>>>> getAllProducts() async {
    if (await info.isConnected) {
      try {
        final res = await dataSource.getAllProducts();
        final status = json.decode(res.body)['success'];
        if (res.statusCode == 200 && status == true) {
          final List<dynamic> data = json.decode(res.body)['data'];
          final List<SingleProduct> products =
              data.map((item) => SingleProduct.fromJson(item)).toList();
          return Right(Result(value: products));
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

  @override
  Future<Either<Failure, Result<List<SingleProduct>>>> getProductByCategory(
      String id) async {
    if (await info.isConnected) {
      try {
        final res = await dataSource.getProductByCategory(id);
        final status = json.decode(res.body)['success'];
        if (res.statusCode == 200 && status == true) {
          final List<dynamic> data = json.decode(res.body)['data'];
          final List<SingleProduct> products =
              data.map((item) => SingleProduct.fromJson(item)).toList();
          return Right(Result(value: products));
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
