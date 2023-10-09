import 'package:get/get.dart';
import 'package:simplibuy/core/state/state.dart';
import 'package:simplibuy/seller_store/data/models/product.dart';
import 'package:simplibuy/seller_store/domain/repo/product_and_category_repository.dart';

class SellerProductsController extends GetxController {
  final ProductAndCategoryRepository repo;
  SellerProductsController({required this.repo});

  @override
  void onInit() {
    super.onInit();
    getSellerProducts();
  }

  final RxList<SingleProduct> _products = (List<SingleProduct>.of([])).obs;

  // ignore: invalid_use_of_protected_member
  List<SingleProduct> get products => _products.value;

  final _state = const State().obs;
  State get state => _state.value;

  getSellerProducts() {
    _state.value = LoadingState();
    repo.getAllProducts().then((value) {
      if (value.isLeft) {
        _state.value = ErrorState(errorType: value.left.error);
      } else {
        _products.value = value.right.value;
        _state.value = FinishedState();
      }
    });
  }
}
