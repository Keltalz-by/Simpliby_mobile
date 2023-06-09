import 'package:get/get.dart';
import 'package:simplibuy/buyer_home/domain/entities/strore_details.dart';
import 'package:simplibuy/buyer_home/domain/usecases/stores_and_malls_usecase.dart';
import 'package:simplibuy/core/prefs/shared_prefs.dart';
import 'package:simplibuy/to_buy_list/data/model/item_to_buy.dart';
import 'package:simplibuy/to_buy_list/domain/usecases/to_buy_usecase.dart';
import '../../../core/state/state.dart';
import '../../domain/usecases/stores_and_malls_fav_usecase.dart';

class StoresAndMallsController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    getStores();
    getUserName();
  }

  final StoresAndMallsUsecase usecase;
  // ignore: non_constant_identifier_names
  final StoresAndMallsFavUsecase usecaseFav;
  final ToBuyUsecase usecaseToBuy;

  StoresAndMallsController(
      {required this.usecase,
      required this.usecaseFav,
      required this.usecaseToBuy});

  final RxBool _isStore = true.obs;
  bool get isStore => _isStore.value;

  final RxString _userName = "John Doe".obs;
  String get userName => _userName.value;

  final RxList<StoreDetails> _details = (List<StoreDetails>.of([])).obs;
  final RxList<ItemToBuy> _toBuyModel = (List<ItemToBuy>.of([])).obs;

  // ignore: invalid_use_of_protected_member
  List<StoreDetails> get details => _details.value;
  // ignore: invalid_use_of_protected_member
  List<ItemToBuy> get toBuyModel => _toBuyModel.value;

  final _state = const State().obs;
  State get state => _state.value;

  final _stateToBuy = const State().obs;
  State get stateToBuy => _stateToBuy.value;

  List<RxBool> isBoughtRx = [];

  void _toggleIsStore() {
    _isStore.value = true;
  }

  void _toggleIsMall() {
    _isStore.value = false;
  }

  void reload() {
    if (_isStore.isTrue) {
      getStores();
    } else {
      getMalls();
    }
  }

  searchStore(String query) {
    _state.value = LoadingState();
    usecase.searchStoreOrMall(query).then((value) {
      if (value.isLeft) {
        _state.value = ErrorState(errorType: value.left.error);
      } else {
        _details.value = value.right.value;
        _state.value = FinishedState();
      }
    });
  }

  getStores() {
    _toggleIsStore();
    _state.value = LoadingState();
    usecase.getStores().then((value) {
      if (value.isLeft) {
        _state.value = ErrorState(errorType: value.left.error);
      } else {
        _details.value = value.right.value;
        _state.value = FinishedState();
      }
    });
  }

  getUserName() {
    SharedPrefs.initializeSharedPrefs();
    _userName.value = SharedPrefs.userName();
  }

  addToFav(int position) {
    usecaseFav.addStoreToFavorite(details[position]);
  }

  getMalls() {
    _toggleIsMall();
    _state.value = LoadingState();
    usecase.getMalls().then((value) {
      if (value.isLeft) {
        _state.value = ErrorState(errorType: value.left.error);
      } else {
        _details.value = value.right.value;
        _state.value = FinishedState();
      }
    });
  }

  getToBuyList() async {
    _stateToBuy.value = LoadingState();
    usecaseToBuy.getAllItemsToBuy((result) {
      if (result.isLeft) {
        _stateToBuy.value = ErrorState(errorType: result.left.error);
      } else {
        _toBuyModel.value = result.right.value;
        isBoughtRx = result.right.value.map((e) => RxBool(e.isBought)).toList();
        _stateToBuy.value = FinishedState();
      }
    });
  }

  saveIsBought(int index) async {
    final valuess = isBoughtRx[index];
    final iid = _toBuyModel[index].id;
    await usecaseToBuy.changeIsBought(iid, valuess.value);
  }
}
