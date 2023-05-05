import 'package:get/state_manager.dart';
import 'package:simplibuy/core/state/state.dart';
import 'package:simplibuy/seller_profile/data/models/seller_profile_details.dart';
import 'package:simplibuy/seller_profile/domain/usecases/seller_profile_usecase.dart';

class SellerProfileController extends GetxController {
  final SellerProfileUsecase usecase;

  SellerProfileController({required this.usecase});

  @override
  void onInit() {
    super.onInit();
    getPromoPosts();
    getSellerProfile();
  }

  final RxList<SellerSinglePromoPost> _promoPosts =
      (List<SellerSinglePromoPost>.of([])).obs;

  final Rx<SellerProfileDetails> _sellerProfileDetails =
      SellerProfileDetails.demo().obs;

  // ignore: invalid_use_of_protected_member
  List<SellerSinglePromoPost> get promoPosts => _promoPosts.value;
  // ignore: invalid_use_of_protected_member
  SellerProfileDetails get sellerProfileDetails => _sellerProfileDetails.value;

  final _state = const State().obs;
  State get state => _state.value;

  final _statePosts = const State().obs;
  State get statePosts => _statePosts.value;

  getPromoPosts() {
    _statePosts.value = LoadingState();
    usecase.getPromoPosts().then((value) {
      if (value.isLeft) {
        _statePosts.value = ErrorState(errorType: value.left.error);
      } else {
        _promoPosts.value = value.right.value;
        _statePosts.value = FinishedState();
      }
    });
  }

  getSellerProfile() {
    _state.value = LoadingState();
    usecase.getSellerProfile().then((value) {
      if (value.isLeft) {
        _state.value = ErrorState(errorType: value.left.error);
      } else {
        _sellerProfileDetails.value = value.right.value;
        _state.value = FinishedState();
      }
    });
  }
}
