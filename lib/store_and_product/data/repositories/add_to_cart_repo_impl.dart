import 'package:simplibuy/cart/domain/entities/item_cart_detail.dart';
import 'package:simplibuy/store_and_product/data/datasources/cart_local_data_source.dart';
import 'package:simplibuy/store_and_product/domain/entities/product.dart';
import 'package:simplibuy/buyer_home/domain/entities/strore_details.dart';
import 'package:simplibuy/store_and_product/domain/repository/add_to_cart_repo.dart';

class AddToCartRepoImpl extends AddToCartRepo {
  final CartLocalDataSource _source;

  AddToCartRepoImpl(this._source);
  @override
  Future<void> addItemToCart(String storeName, int storeId, Product product) {
    var detail = ItemCartDetails(
        id: product.productId,
        storeName: storeName,
        storeId: storeId,
        itemName: product.productName,
        itemPieces: 1,
        itemPrice: product.productPrice.toDouble());
    return _source.addItemToCart(detail);
  }
}
