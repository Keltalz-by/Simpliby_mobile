import 'package:either_dart/either.dart';
import 'package:simplibuy/core/failure/failure.dart';
import 'package:simplibuy/core/result/result.dart';
import 'package:simplibuy/seller_products/data/models/seller_product.dart';
import 'package:simplibuy/seller_products/domain/repositories/seller_products_repository.dart';

class SellerProductsUsecase {
  final SellerProductsRepository repo;

  SellerProductsUsecase(this.repo);

  Future<Either<Failure, Result<List<SellerProduct>>>>
      getSellerProductsFromCategory(String category) {
    return repo.getSellerProductsFromCategory(category);
  }
}
