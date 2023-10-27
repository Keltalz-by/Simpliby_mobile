import 'package:either_dart/either.dart';
import 'package:simplibuy/buyer_home/domain/repositories/stores_and_malls_list_repository.dart';
import 'package:simplibuy/core/failure/failure.dart';
import '../../../core/result/result.dart';
import '../entities/strore_details.dart';

class StoresAndMallsUsecase {
  final StoresAndMallsRepository repository;

  StoresAndMallsUsecase({required this.repository});

  Future<Either<Failure, Result<StoreDetails>>> getStores() async {
    return repository.getStores();
  }

  Future<Either<Failure, Result<StoreDetails>>> getMalls() async {
    return repository.getMalls();
  }

  Future<Either<Failure, Result<StoreDetails>>> searchStoreOrMall(
      String query) async {
    return repository.searchStoreOrMall(query);
  }
}
