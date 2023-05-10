import 'package:get/get.dart';
import 'package:simplibuy/core/state/state.dart';
import 'package:simplibuy/store_and_product/domain/entities/product.dart';
import 'package:simplibuy/store_and_product/domain/entities/store_category.dart';
import 'package:simplibuy/store_and_product/domain/entities/store_info.dart';
import 'package:simplibuy/store_and_product/domain/usecases/products_list_usecase.dart';
import 'package:simplibuy/store_and_product/domain/usecases/store_usecase.dart';

class StoreDetailController extends GetxController {
  final StoreUsecase _storeUsecase;
  final ProductListUsecase _productListUsecase;

  StoreDetailController(this._storeUsecase, this._productListUsecase);

  final RxList<Product> _product = (List<Product>.of([])).obs;
  // ignore: invalid_use_of_protected_member
  List<Product> get product => _product.value;

  final RxList<StoreCategory> _categories = (List<StoreCategory>.of([])).obs;
  // ignore: invalid_use_of_protected_member
  List<StoreCategory> get categories => _categories.value;

  final Rx<StoreInfo> _store = StoreInfo(0, "name", "address", "logo", "about",
          "phoneNumber", "email", 111, 2, "")
      .obs;
  // ignore: invalid_use_of_protected_member
  StoreInfo get store => _store.value;

  final _state = const State().obs;
  State get state => _state.value;

  final _popstate = const State().obs;
  State get popstate => _state.value;

  final _catstate = const State().obs;
  State get catstate => _state.value;

  _getCategories(int id) {
    _catstate.value = LoadingState();
    _storeUsecase.getStoreCategories(id, (result) {
      if (result.isLeft) {
        _catstate.value = ErrorState(errorType: result.left.error);
      } else {
        _categories.value = result.right.value;
        _catstate.value = FinishedState();
      }
    });
  }

  _getPopularProducts() {
    _popstate.value = LoadingState();
    _productListUsecase.getPopularProducts((value) {
      if (value.isLeft) {
        _popstate.value = ErrorState(errorType: value.left.error);
      } else {
        _product.value = value.right.value;
        _popstate.value = FinishedState();
      }
    });
  }

  _getStoreInfo(int id) {
    _state.value = LoadingState();
    _storeUsecase.getStoreInfo(id, (result) {
      if (result.isLeft) {
        _state.value = ErrorState(errorType: result.left.error);
      } else {
        _store.value = result.right.value;
        _state.value = FinishedState();
      }
    });
  }

  start(int id) {
    _getStoreInfo(id);
    _getCategories(id);
    _getPopularProducts();
  }

  addProductToCart(int position) {
    _productListUsecase.addItemToCart(
        _store.value.name, _store.value.storeId, _product[position]);
  }
}
