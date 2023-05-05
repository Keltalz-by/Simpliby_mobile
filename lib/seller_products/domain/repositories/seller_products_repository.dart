import 'package:either_dart/either.dart';
import 'package:simplibuy/core/error_types/error_types.dart';
import 'package:simplibuy/core/failure/failure.dart';
import 'package:simplibuy/core/network/network_info.dart';
import 'package:simplibuy/core/result/result.dart';
import 'package:simplibuy/seller_products/data/models/seller_product.dart';

abstract class SellerProductsRepository {
  Future<Either<Failure, Result<List<SellerProduct>>>>
      getSellerProductsFromCategory(String category);
}

class SellerProductsRepositoryImpl implements SellerProductsRepository {
  final NetworkInfo info;

  SellerProductsRepositoryImpl(this.info);

  @override
  Future<Either<Failure, Result<List<SellerProduct>>>>
      getSellerProductsFromCategory(String category) async {
    if (await info.isConnected) {
      try {
        return Right(Result(value: products));
      } on Exception {
        return Left(Failure(error: ServerError()));
      }
    } else {
      return Left(Failure(error: InternetError()));
    }
  }

  final List<SellerProduct> products = [
    SellerProduct(name: "Apple Headset", img: "", id: "1"),
    SellerProduct(name: "Apple Headset", img: "", id: "1"),
    SellerProduct(name: "Apple Headset", img: "", id: "1"),
    SellerProduct(name: "Apple Headset", img: "", id: "1"),
    SellerProduct(name: "Apple Headset", img: "", id: "1"),
    SellerProduct(name: "Apple Headset", img: "", id: "1"),
    SellerProduct(name: "Apple Headset", img: "", id: "1"),
    SellerProduct(name: "Apple Headset", img: "", id: "1"),
    SellerProduct(name: "Apple Headset", img: "", id: "1"),
    SellerProduct(name: "Apple Headset", img: "", id: "1"),
    SellerProduct(name: "Apple Headset", img: "", id: "1"),
    SellerProduct(name: "Apple Headset", img: "", id: "1"),
  ];
}
