import 'package:get/get.dart';
import 'package:simplibuy/to_buy_list/data/model/item_to_buy.dart';
import 'package:simplibuy/to_buy_list/domain/usecases/to_buy_usecase.dart';
import '../../../core/state/state.dart';

class ToBuyController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    getToBuyList();
  }

  final _state = const State().obs;
  State get state => _state.value;

  final RxList<ItemToBuy> _details = (List<ItemToBuy>.of([])).obs;

  RxList<ItemToBuy> get details => _details;

  final ToBuyUsecase _usecase;
  ToBuyController(this._usecase);

  void getToBuyList() {
    _state.value = LoadingState();
    _usecase.getAllItemsToBuy((value) {
      if (value.isLeft) {
        _state.value = ErrorState(errorType: value.left.error);
      } else {
        _details.value = value.right.value;
        _state.value = FinishedState();
      }
    });
  }

  void addToList(String item) async {
    ItemToBuy toBuyModel = ItemToBuy(
        id: DateTime.now().millisecondsSinceEpoch, item: item, isBought: false);
    _details.add(toBuyModel);
    _state.refresh();
    await _usecase.addItemToBuy(toBuyModel);
  }

  updateSingleModel(String item, int id) async {
    await _usecase.updateItem(item, id);
    _details.where((p0) => p0.id == id).first.item = item;
    _details.refresh();
  }

  void removeFromList(int index) async {
    int? iid = _details.value[index].id;
    await _usecase.removeItemToBuy(iid);
    _details.removeAt(index);
  }

  changeIsBought(int index) async {
    final valuess = _details[index].isBought;
    _details[index].isBought = !valuess;
    final iid = _details[index].id;
    await _usecase.changeIsBought(iid, !valuess);
    _details.refresh();
  }
}
