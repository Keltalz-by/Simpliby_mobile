import 'package:either_dart/either.dart';
import 'package:simplibuy/store_and_product/data/repositories/add_to_cart_repo_impl.dart';
import 'package:simplibuy/store_and_product/data/repositories/product_repo_impl.dart';

import '../../../core/failure/failure.dart';
import '../../../core/result/result.dart';
import '../entities/product.dart';
import '../repository/add_to_cart_repo.dart';
import '../repository/product_repo.dart';

class ProductUsecase {
  final ProductRepo _repo;
  final AddToCartRepo _addToCartRepoImpl;

  ProductUsecase(this._repo, this._addToCartRepoImpl);

  getProductInfo(int productId,
      Function(Either<Failure, Result<Product>> res) callback) async {
    await _repo.getProductInfo(productId).then((value) => callback.call(value));
  }

  addProductToCart(String storeName, int storeId, Product product) async {
    await _addToCartRepoImpl.addItemToCart(storeName, storeId, product);
  }
}
