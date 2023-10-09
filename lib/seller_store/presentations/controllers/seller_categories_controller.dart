import 'package:get/get.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:simplibuy/core/state/state.dart';
import 'package:simplibuy/seller_store/data/models/category.dart';
import 'package:simplibuy/seller_store/domain/repo/product_and_category_repository.dart';

class SellerCategoriesController extends GetxController {
  final ProductAndCategoryRepository repo;
  SellerCategoriesController({required this.repo});

  @override
  void onInit() {
    super.onInit();
    getSellerCategories();
  }

  final RxList<Category> _categories = (List<Category>.of([])).obs;

  List<Category> get categories => _categories.value;

  final _state = const State().obs;
  State get state => _state.value;

  getSellerCategories() {
    _state.value = LoadingState();
    repo.getAllCategory().then((value) {
      if (value.isLeft) {
        _state.value = ErrorState(errorType: value.left.error);
        toast(value.left.message);
      } else {
        _categories.value = value.right.value;
        _state.value = FinishedState();
      }
    });
  }
}
