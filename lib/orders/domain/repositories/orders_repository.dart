import 'package:either_dart/either.dart';
import 'package:simplibuy/core/failure/failure.dart';
import 'package:simplibuy/core/error_types/error_types.dart';
import 'package:simplibuy/core/network/network_info.dart';
import 'package:simplibuy/core/result/result.dart';
import 'package:simplibuy/orders/data/models/accepted_order_details.dart';
import 'package:simplibuy/orders/data/models/accepted_orders.dart';
import 'package:simplibuy/orders/data/models/incoming_orders.dart';

abstract class OrdersRepository {
  Future<Either<Failure, Result<List<AcceptedOrder>>>> getAcceptedOrders();
  Future<Either<Failure, Result<List<IncomingOrder>>>> getIncomingOrders();
  Future<Either<Failure, Result<AcceptedOrderDetail>>> getOrderDetails(int id);
}

class OrdersRepositoryImpl implements OrdersRepository {
  final NetworkInfo networkInfo;

  OrdersRepositoryImpl(this.networkInfo);

  @override
  Future<Either<Failure, Result<List<AcceptedOrder>>>>
      getAcceptedOrders() async {
    if (await networkInfo.isConnected) {
      try {
        final res = ordersA;
        if (res.isEmpty) {
          return Left(Failure(error: EmptyListError()));
        } else {
          return Right(Result(value: res));
        }
      } on Exception {
        return Left(Failure(error: ServerError()));
      }
    } else {
      return Left(Failure(error: InternetError()));
    }
  }

  @override
  Future<Either<Failure, Result<List<IncomingOrder>>>>
      getIncomingOrders() async {
    if (await networkInfo.isConnected) {
      try {
        final res = orders;
        if (res.isEmpty) {
          return Left(Failure(error: EmptyListError()));
        } else {
          return Right(Result(value: res));
        }
      } on Exception {
        return Left(Failure(error: ServerError()));
      }
    } else {
      return Left(Failure(error: InternetError()));
    }
  }

  @override
  Future<Either<Failure, Result<AcceptedOrderDetail>>> getOrderDetails(
      int id) async {
    if (await networkInfo.isConnected) {
      try {
        return Right(Result(
            value: AcceptedOrderDetail("", "Ikenwa John", "sab27t3h814", "Paid",
                "09013724133", "200", "Sunday, 21st April", [
          ItemNameAndPrice("Laptop", "800"),
          ItemNameAndPrice("Laptop", "800"),
          ItemNameAndPrice("Laptop", "800")
        ])));
      } on Exception {
        return Left(Failure(error: ServerError()));
      }
    } else {
      return Left(Failure(error: InternetError()));
    }
  }
}
