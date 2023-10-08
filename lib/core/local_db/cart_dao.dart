import 'package:floor/floor.dart';
import '../../cart/domain/entities/item_cart_detail.dart';

@dao
abstract class CartDao {
  @Query('SELECT  SUM(totalPrice) FROM ItemCartDetails')
  Future<double?> totalResults();

  @Query('SELECT * FROM ItemCartDetails')
  Stream<List<ItemCartDetails>> getAllCartItems();

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> addToCart(ItemCartDetails item);

  @Query('DELETE FROM ItemCartDetails WHERE id = :id')
  Future<void> removeFromCart(int id);

  @Query('UPDATE ItemCartDetails SET itemPieces = :number WHERE id = :id')
  Future<void> updateNumberOfItems(int number, int id);
}
