import 'package:get/get.dart';
import 'package:simplibuy/store_and_product/domain/usecases/products_list_usecase.dart';

import '../../../core/state/state.dart';
import '../../domain/entities/product.dart';

class ProductListController {
  final ProductListUsecase _usecase;
  ProductListController(this._usecase);
  final RxList<Product> _product = (List<Product>.of([])).obs;
  // ignore: invalid_use_of_protected_member
  List<Product> get product => _product.value;

  final _state = const State().obs;
  State get state => _state.value;

  getProductsFromCategory(String category, int id) {
    _state.value = LoadingState();
    _usecase.getProductsFromCategory("category", 0, (value) {
      if (value.isLeft) {
        _state.value = ErrorState(errorType: value.left.error);
      } else {
        _product.value = value.right.value;
        _state.value = FinishedState();
      }
    });
  }

  addProductToCart(int position, String storeName, int storeId) {
    _usecase.addItemToCart(storeName, storeId, _product[position]);
  }
}
