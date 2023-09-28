import 'package:either_dart/either.dart';
import 'package:simplibuy/core/failure/failure.dart';
import 'package:simplibuy/core/result/result.dart';
import 'package:simplibuy/store_and_product/domain/entities/product.dart';
import 'package:simplibuy/store_and_product/domain/entities/store_category.dart';
import 'package:simplibuy/store_and_product/domain/entities/store_info.dart';

abstract class StoreRepository {
  Future<Either<Failure, Result<StoreInfo>>> getStoreInfo(int storeId);
  Future<Either<Failure, Result<List<StoreCategory>>>> getStoreCategories(
      int storeId);
  Future<Either<Failure, Result<List<Product>>>> getPopularProducts();
  Future<Either<Failure, Result<List<Product>>>> getProductsFromCategory(
      String category, int storeId);
}
