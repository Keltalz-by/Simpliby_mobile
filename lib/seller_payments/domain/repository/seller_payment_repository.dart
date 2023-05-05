import 'package:either_dart/either.dart';
import 'package:simplibuy/core/failure/failure.dart';
import 'package:simplibuy/core/error_types/error_types.dart';
import 'package:simplibuy/core/network/network_info.dart';
import 'package:simplibuy/core/result/result.dart';
import 'package:simplibuy/seller_payments/data/models/payment_orders.dart';

abstract class SellerPaymentRepository {
  Future<Either<Failure, Result<List<PaymentOrders>>>> getPaidOrders();
  Future<Either<Failure, Result<List<PaymentOrders>>>> getUnpaidOrders();
}

class SellerPaymentRepositoryImpl implements SellerPaymentRepository {
  final NetworkInfo networkInfo;

  SellerPaymentRepositoryImpl(this.networkInfo);

  @override
  Future<Either<Failure, Result<List<PaymentOrders>>>> getPaidOrders() async {
    if (await networkInfo.isConnected) {
      try {
        if (ord.isEmpty) {
          return Left(Failure(error: EmptyListError()));
        } else {
          return Right(Result(value: ord));
        }
      } on Exception {
        return Left(Failure(error: ServerError()));
      }
    } else {
      return Left(Failure(error: InternetError()));
    }
  }

  @override
  Future<Either<Failure, Result<List<PaymentOrders>>>> getUnpaidOrders() async {
    if (await networkInfo.isConnected) {
      try {
        if (ord.isEmpty) {
          return Left(Failure(error: EmptyListError()));
        } else {
          return Right(Result(value: ord));
        }
      } on Exception {
        return Left(Failure(error: ServerError()));
      }
    } else {
      return Left(Failure(error: InternetError()));
    }
  }

  final List<PaymentOrders> ord = [
    PaymentOrders("Ikenwa John", "ACCESS BANK", "20thJuly, 2000", "100"),
    PaymentOrders("Ikenwa John", "ACCESS BANK", "20thJuly, 2000", "100"),
    PaymentOrders("Ikenwa John", "ACCESS BANK", "20thJuly, 2000", "100"),
    PaymentOrders("Ikenwa John", "ACCESS BANK", "20thJuly, 2000", "100"),
    PaymentOrders("Ikenwa John", "ACCESS BANK", "20thJuly, 2000", "100"),
    PaymentOrders("Ikenwa John", "ACCESS BANK", "20thJuly, 2000", "100"),
  ];
}
