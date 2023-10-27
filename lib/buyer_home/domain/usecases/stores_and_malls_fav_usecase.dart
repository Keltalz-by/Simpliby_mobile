import 'package:either_dart/either.dart';
import 'package:simplibuy/buyer_home/domain/repositories/favorite_stores_repository.dart';

import '../../../core/failure/failure.dart';
import '../../../core/result/result.dart';
import '../entities/strore_details.dart';

class StoresAndMallsFavUsecase {
  final FavStoresAndMallsRepository repo;

  StoresAndMallsFavUsecase(this.repo);

  addStoreToFavorite(StoreData storeData) {
    repo.addStoreToFavorite(storeData);
  }

  Future<Either<Failure, Result<List<StoreData>>>>
      getAllFavoriteStoresAndMalls() {
    return repo.getAllFavoriteStoresAndMalls();
  }

  removeStoreFromFavorite(String id) {
    repo.removeStoreFromFavorite(id);
  }
}
