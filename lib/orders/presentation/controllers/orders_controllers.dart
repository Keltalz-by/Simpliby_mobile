import 'package:get/get.dart';
import 'package:simplibuy/core/state/state.dart';
import 'package:simplibuy/orders/data/models/accepted_order_details.dart';
import 'package:simplibuy/orders/data/models/accepted_orders.dart';
import 'package:simplibuy/orders/data/models/incoming_orders.dart';
import 'package:simplibuy/orders/domain/usecases/orders_usecase.dart';

class OrdersController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    getIncomingOrders();
  }

  final OrdersUsecase usecase;

  OrdersController({required this.usecase});

  final RxBool _isIncoming = true.obs;
  bool get isIncoming => _isIncoming.value;

  final RxList<IncomingOrder> _inOrders = (List<IncomingOrder>.of([])).obs;
  final RxList<AcceptedOrder> _accOrders = (List<AcceptedOrder>.of([])).obs;

  final Rx<AcceptedOrderDetail> _incomOrderDet =
      AcceptedOrderDetail.empty().obs;

  // ignore: invalid_use_of_protected_member
  List<IncomingOrder> get incomingOrdersList => _inOrders.value;
  // ignore: invalid_use_of_protected_member
  List<AcceptedOrder> get acceptedOrdersList => _accOrders.value;
  AcceptedOrderDetail get incomOrderDet => _incomOrderDet.value;

  final _state = const State().obs;
  State get state => _state.value;

  final _stateOrderDetails = const State().obs;
  State get stateOrderDetails => _stateOrderDetails.value;

  void _toggleIsIncoming() {
    _isIncoming.value = true;
  }

  void _toggleIsAccepted() {
    _isIncoming.value = false;
  }

  void reload() {
    if (_isIncoming.isTrue) {
      getIncomingOrders();
    } else {
      getAcceptedOrders();
    }
  }

  getIncomingOrders() {
    _toggleIsIncoming();
    _state.value = LoadingState();
    usecase.getIncomingOrders().then((value) {
      if (value.isLeft) {
        _state.value = ErrorState(errorType: value.left.error);
      } else {
        _inOrders.value = value.right.value;
        _state.value = FinishedState();
      }
    });
  }

  getAcceptedOrders() {
    _toggleIsAccepted();
    _state.value = LoadingState();
    usecase.getAcceptedOrders().then((value) {
      if (value.isLeft) {
        _state.value = ErrorState(errorType: value.left.error);
      } else {
        _accOrders.value = value.right.value;
        _state.value = FinishedState();
      }
    });
  }

  getInOrderDetails() {
    _stateOrderDetails.value = LoadingState();
    usecase.getSingleOrder(2).then((value) {
      if (value.isLeft) {
        _state.value = ErrorState(errorType: value.left.error);
      } else {
        _incomOrderDet.value = value.right.value;
        _stateOrderDetails.value = FinishedState();
      }
    });
  }
}
