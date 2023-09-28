import 'package:simplibuy/cart/domain/entities/item_cart_detail.dart';
import 'package:simplibuy/core/local_db/cart_dao.dart';

class CartLocalDataSource {
  final CartDao dao;

  CartLocalDataSource(this.dao);

  addItemToCart(ItemCartDetails detail) async {
    await dao.addToCart(detail);
  }
}
