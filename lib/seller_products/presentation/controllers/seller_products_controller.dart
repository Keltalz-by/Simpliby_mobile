import 'package:get/get.dart';
import 'package:simplibuy/core/state/state.dart';
import 'package:simplibuy/seller_products/data/models/seller_product.dart';
import 'package:simplibuy/seller_products/domain/usecases/seller_products_usecase.dart';

class SellerProductsController extends GetxController {
  final SellerProductsUsecase usecase;

  SellerProductsController({required this.usecase});

  @override
  void onInit() {
    super.onInit();
    getSellerProducts();
  }

  final RxList<SellerProduct> _products = (List<SellerProduct>.of([])).obs;

  // ignore: invalid_use_of_protected_member
  List<SellerProduct> get products => _products.value;

  final _state = const State().obs;
  State get state => _state.value;

  getSellerProducts() {
    _state.value = LoadingState();
    usecase.getSellerProductsFromCategory("").then((value) {
      if (value.isLeft) {
        _state.value = ErrorState(errorType: value.left.error);
      } else {
        _products.value = value.right.value;
        _state.value = FinishedState();
      }
    });
  }
}
