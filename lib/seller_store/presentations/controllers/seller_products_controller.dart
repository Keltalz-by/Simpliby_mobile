import 'package:get/get.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:simplibuy/core/state/state.dart';
import 'package:simplibuy/seller_store/data/models/product.dart';
import 'package:simplibuy/seller_store/domain/repo/product_and_category_repository.dart';

class SellerProductsController extends GetxController {
  final ProductAndCategoryRepository repo;
  SellerProductsController({required this.repo});

  final RxList<SingleProduct> _products = (List<SingleProduct>.of([])).obs;

  // ignore: invalid_use_of_protected_member
  List<SingleProduct> get products => _products.value;

  final _state = const State().obs;
  State get state => _state.value;

  getSellerProducts(String id) {
    _state.value = LoadingState();
    repo.getProductByCategory(id).then((value) {
      if (value.isLeft) {
        _state.value = ErrorState(errorType: value.left.error);
        toast(value.left.message);
      } else {
        _products.value = value.right.value;
        _state.value = FinishedState();
      }
    });
  }
}
