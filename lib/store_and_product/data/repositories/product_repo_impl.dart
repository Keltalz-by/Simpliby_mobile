import 'package:either_dart/either.dart';
import 'package:simplibuy/core/network/network_info.dart';

import '../../../core/error_types/error_types.dart';
import '../../../core/failure/failure.dart';
import '../../../core/result/result.dart';
import '../../domain/entities/product.dart';
import '../../domain/repository/product_repo.dart';

class ProductRepoImpl implements ProductRepo {
  final NetworkInfo _networkInfo;

  ProductRepoImpl(this._networkInfo);
  @override
  Future<Either<Failure, Result<Product>>> getProductInfo(int productId) async {
    if (await _networkInfo.isConnected) {
      try {
        return Right(Result(value: product));
      } on Exception {
        return Left(Failure(error: ServerError()));
      }
    } else {
      return Left(Failure(error: InternetError()));
    }
  }

  var product = Product(
      4,
      "Tin Peak milk",
      "ine 2A Rack 36",
      "Fried rice and chicken cooked with nice palm oil and fresh water to serve you until youre filled to the brim. Specially made for gluttons",
      [
        "https://lremflickr.com/g/320/240/paris,girl/all",
        "https://lremflickr.com/g/320/240/paris,girl/all",
        "https://lremflickr.com/g/320/240/paris,girl/all",
        "https://lremflickr.com/g/320/240/paris,girl/all"
      ],
      400);
}
