import 'package:either_dart/either.dart';
import 'package:simplibuy/buyer_home/domain/entities/strore_details.dart';

import '../../../core/error_types/error_types.dart';
import '../../../core/failure/failure.dart';
import '../../../core/local_db/fav_stores_dao.dart';
import '../../../core/result/result.dart';
import '../../data/models/fav_stores_model.dart';

abstract class FavStoresAndMallsRepository {
  addStoreToFavorite(StoreData storeDetails);
  Future<Either<Failure, Result<List<StoreData>>>>
      getAllFavoriteStoresAndMalls();
  removeStoreFromFavorite(String id);
}

class FavStoresRepoImpl implements FavStoresAndMallsRepository {
  final FavStoresDao dao;
  FavStoresRepoImpl({required this.dao});

  @override
  addStoreToFavorite(StoreData storeDetails) async {
    await dao.addToFavorite(_convertToFavStoreModel(storeDetails));
  }

  @override
  removeStoreFromFavorite(String id) async {
    await dao.removeFromFav(id);
  }

  @override
  Future<Either<Failure, Result<List<StoreData>>>>
      getAllFavoriteStoresAndMalls() async {
    final res = await dao.getAllFavStores().first;
    if (res.isEmpty) {
      return Left(Failure(error: EmptyListError()));
    } else {
      return Right(Result(value: _convertFavList(res)));
    }
  }

  FavStoresModel _convertToFavStoreModel(StoreData details) {
    return FavStoresModel(
        id: details.id,
        storeName: details.businessName,
        location: details.businessLocation,
        imageLogo: details.logo.url,
        storeAddress: details.address,
        rating: 2);
  }

  StoreData _convertToStoreDetails(FavStoresModel details) {
    return StoreData.part(
        id: details.id,
        businessName: details.storeName,
        businessLocation: details.location,
        logoUrl: details.imageLogo,
        address: details.storeAddress,
        rating: details.rating);
  }

  List<StoreData> _convertFavList(List<FavStoresModel> details) {
    return details.map((e) => _convertToStoreDetails(e)).toList();
  }
}
