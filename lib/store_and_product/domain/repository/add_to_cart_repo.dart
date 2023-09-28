import 'package:simplibuy/buyer_home/domain/entities/strore_details.dart';
import 'package:simplibuy/store_and_product/domain/entities/product.dart';

abstract class AddToCartRepo {
  Future<void> addItemToCart(String storeName, int storeId, Product product);
}
