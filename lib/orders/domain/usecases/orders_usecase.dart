import 'package:either_dart/either.dart';
import 'package:simplibuy/core/failure/failure.dart';
import 'package:simplibuy/core/result/result.dart';
import 'package:simplibuy/orders/data/models/accepted_order_details.dart';
import 'package:simplibuy/orders/data/models/accepted_orders.dart';
import 'package:simplibuy/orders/data/models/incoming_orders.dart';
import 'package:simplibuy/orders/domain/repositories/orders_repository.dart';

class OrdersUsecase {
  final OrdersRepository repo;

  OrdersUsecase(this.repo);

  Future<Either<Failure, Result<List<AcceptedOrder>>>>
      getAcceptedOrders() async {
    return repo.getAcceptedOrders();
  }

  Future<Either<Failure, Result<List<IncomingOrder>>>>
      getIncomingOrders() async {
    return repo.getIncomingOrders();
  }

  Future<Either<Failure, Result<AcceptedOrderDetail>>> getSingleOrder(
      int id) async {
    return repo.getOrderDetails(id);
  }
}
