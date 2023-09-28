import 'package:either_dart/either.dart';
import 'package:simplibuy/store_and_product/domain/entities/product.dart';

import '../../../core/failure/failure.dart';
import '../../../core/result/result.dart';

abstract class ProductRepo {
  Future<Either<Failure, Result<Product>>> getProductInfo(int productId);
}
