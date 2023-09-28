import 'package:either_dart/either.dart';
import 'package:simplibuy/core/result/result.dart';
import 'package:simplibuy/store_and_product/domain/entities/store_info.dart';
import 'package:simplibuy/store_and_product/domain/repository/store_repository.dart';

import '../../../core/failure/failure.dart';
import '../entities/store_category.dart';

class StoreUsecase {
  final StoreRepository repo;
  StoreUsecase(this.repo);

  getStoreInfo(
      int id, Function(Either<Failure, Result<StoreInfo>> res) callback) async {
    await repo.getStoreInfo(id).then((value) => callback.call(value));
  }

  getStoreCategories(
      int id,
      Function(Either<Failure, Result<List<StoreCategory>>> res)
          callback) async {
    await repo.getStoreCategories(id).then((value) => callback.call(value));
  }
}
