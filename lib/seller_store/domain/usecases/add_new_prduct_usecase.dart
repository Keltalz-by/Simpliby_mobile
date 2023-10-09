import 'package:either_dart/either.dart';
import 'package:simplibuy/seller_store/data/models/new_product.dart';
import 'package:simplibuy/seller_store/domain/repo/product_and_category_repository.dart';
import 'package:simplibuy/core/failure/failure.dart';
import 'package:simplibuy/core/result/result.dart';

class AddNewProductUsecase {
  final ProductAndCategoryRepository repo;

  AddNewProductUsecase(this.repo);

  Future<Either<Failure, Result<String>>> addNewProduct(AddNewProduct detail) {
    return repo.addNewProduct(detail);
  }
}
