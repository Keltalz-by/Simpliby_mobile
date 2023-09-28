import 'package:get/state_manager.dart';
import 'package:simplibuy/store_and_product/domain/usecases/product_usecase.dart';

import '../../../core/state/state.dart';
import '../../domain/entities/product.dart';

class ProductController extends GetxController {
  final ProductUsecase _usecase;

  ProductController(this._usecase);
  final Rx<Product> _product = (Product.empty()).obs;
  // ignore: invalid_use_of_protected_member
  Product get product => _product.value;

  final _state = const State().obs;
  State get state => _state.value;

  getProduct(int id) {
    _state.value = LoadingState();
    _usecase.getProductInfo(id, (value) {
      if (value.isLeft) {
        _state.value = ErrorState(errorType: value.left.error);
      } else {
        _product.value = value.right.value;
        _state.value = FinishedState();
      }
    });
  }

  addProductToCart(String storeName, int storeId) {
    _usecase.addProductToCart(storeName, storeId, _product.value);
  }
}
