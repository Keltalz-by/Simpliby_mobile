import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:simplibuy/core/local_db/cart_dao.dart';
import 'package:simplibuy/core/local_db/fav_stores_dao.dart';
import 'package:simplibuy/core/local_db/to_buy_dao.dart';
import 'package:simplibuy/core/network/network_info.dart';
import 'core/local_db/app_database.dart';

class MainBinding implements Bindings {
  @override
  Future<void> dependencies() async {
    Get.put<NetworkInfoImpl>(NetworkInfoImpl(InternetConnectionChecker()),
        permanent: true);
    var result = Get.putAsync(
        () async => await AppDatabase.getDb() as Future<AppDatabase>);
    AppDatabase db = await result;
    Get.put<CartDao>(db.cartDao, permanent: true);
    Get.put<FavStoresDao>(db.favDao, permanent: true);
    Get.put<ToBuyModelDao>(db.toBuyDao, permanent: true);
  }
}
