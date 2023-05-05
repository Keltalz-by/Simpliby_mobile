import 'package:get/get.dart';
import 'package:simplibuy/core/state/state.dart';
import 'package:simplibuy/seller_payments/data/models/payment_orders.dart';
import 'package:simplibuy/seller_payments/domain/usecase/seller_payment_usecase.dart';

class SellerPaymentController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    getPaidOrders();
  }

  final SellerPaymentUsecase usecase;

  SellerPaymentController({required this.usecase});

  final RxBool _isPaid = true.obs;
  bool get isPaid => _isPaid.value;

  final RxList<PaymentOrders> _inOrders = (List<PaymentOrders>.of([])).obs;

  // ignore: invalid_use_of_protected_member
  List<PaymentOrders> get orderList => _inOrders.value;
  // ignore: invalid_use_of_protected_member

  final _state = const State().obs;
  State get state => _state.value;

  void _toggleIsPaid() {
    _isPaid.value = true;
  }

  void _toggleIsUnpaid() {
    _isPaid.value = false;
  }

  void reload() {
    if (_isPaid.isTrue) {
      getPaidOrders();
    } else {
      getUnpaidOrders();
    }
  }

  getPaidOrders() {
    _toggleIsPaid();
    _state.value = LoadingState();
    usecase.getPaidOrders().then((value) {
      if (value.isLeft) {
        _state.value = ErrorState(errorType: value.left.error);
      } else {
        _inOrders.value = value.right.value;
        _state.value = FinishedState();
      }
    });
  }

  getUnpaidOrders() {
    _toggleIsUnpaid();
    _state.value = LoadingState();
    usecase.getUnpaidOrders().then((value) {
      if (value.isLeft) {
        _state.value = ErrorState(errorType: value.left.error);
      } else {
        _inOrders.value = value.right.value;
        _state.value = FinishedState();
      }
    });
  }
}
