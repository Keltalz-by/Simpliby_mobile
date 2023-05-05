import 'package:either_dart/either.dart';
import 'package:simplibuy/add_new_product/data/models/add_new_product.dart';
import 'package:simplibuy/core/error_types/error_types.dart';
import 'package:simplibuy/core/failure/failure.dart';
import 'package:simplibuy/core/network/network_info.dart';
import 'package:simplibuy/core/result/result.dart';

abstract class AddNewProductRepository {
  Future<Either<Failure, Result<String>>> addNewProduct(AddNewProduct detail);
}

class AddNewProductRepositoryImpl implements AddNewProductRepository {
  final NetworkInfo info;

  AddNewProductRepositoryImpl(this.info);

  @override
  Future<Either<Failure, Result<String>>> addNewProduct(
      AddNewProduct detail) async {
    if (await info.isConnected) {
      try {
        return Right(Result(value: "done"));
      } on Exception {
        return Left(Failure(error: ServerError()));
      }
    }
    return Left(Failure(error: InternetError()));
  }
}
