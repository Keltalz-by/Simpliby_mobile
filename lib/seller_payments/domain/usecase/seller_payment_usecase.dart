import 'package:either_dart/either.dart';
import 'package:simplibuy/core/result/result.dart';
import 'package:simplibuy/seller_payments/data/models/payment_orders.dart';
import 'package:simplibuy/seller_payments/domain/repository/seller_payment_repository.dart';

import '../../../core/failure/failure.dart';

class SellerPaymentUsecase {
  final SellerPaymentRepository repo;

  SellerPaymentUsecase(this.repo);

  Future<Either<Failure, Result<List<PaymentOrders>>>> getPaidOrders() {
    return repo.getPaidOrders();
  }

  Future<Either<Failure, Result<List<PaymentOrders>>>> getUnpaidOrders() {
    return repo.getUnpaidOrders();
  }
}
