import 'package:either_dart/either.dart';
import 'package:simplibuy/store_and_product/domain/repository/add_to_cart_repo.dart';
import 'package:simplibuy/store_and_product/domain/repository/store_repository.dart';

import '../../../core/failure/failure.dart';
import '../../../core/result/result.dart';
import '../entities/product.dart';

class ProductListUsecase {
  final StoreRepository _storeRepo;
  final AddToCartRepo _addToCartRepo;

  ProductListUsecase(this._storeRepo, this._addToCartRepo);

  getPopularProducts(
      Function(Either<Failure, Result<List<Product>>> res) callback) async {
    await _storeRepo.getPopularProducts().then((value) => callback(value));
  }

  getProductsFromCategory(String category, int storeId,
      Function(Either<Failure, Result<List<Product>>> res) callback) async {
    await _storeRepo
        .getProductsFromCategory(category, storeId)
        .then((value) => callback(value));
  }

  Future<void> addItemToCart(String storeName, int storeId, Product product) {
    return _addToCartRepo.addItemToCart(storeName, storeId, product);
  }
}
