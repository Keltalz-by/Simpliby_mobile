import 'package:either_dart/either.dart';
import 'package:simplibuy/add_new_product/data/models/add_new_product.dart';
import 'package:simplibuy/add_new_product/domain/repositories/add_new_product_repository.dart';
import 'package:simplibuy/core/failure/failure.dart';
import 'package:simplibuy/core/result/result.dart';

class AddNewProductUsecase {
  final AddNewProductRepository repo;

  AddNewProductUsecase(this.repo);

  Future<Either<Failure, Result<String>>> addNewProduct(AddNewProduct detail) {
    return repo.addNewProduct(detail);
  }
}
