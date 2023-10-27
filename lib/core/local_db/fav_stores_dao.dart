import 'package:floor/floor.dart';
import '../../buyer_home/data/models/fav_stores_model.dart';

@dao
abstract class FavStoresDao {
  @Query('SELECT * FROM FavStoresModel')
  Stream<List<FavStoresModel>> getAllFavStores();

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> addToFavorite(FavStoresModel item);

  @Query('DELETE FROM FavStoresModel WHERE id = :id')
  Future<void> removeFromFav(String id);
}
