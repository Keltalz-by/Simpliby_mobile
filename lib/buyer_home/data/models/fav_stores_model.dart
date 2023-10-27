import 'package:floor/floor.dart';

@entity
class FavStoresModel {
  @PrimaryKey(autoGenerate: false)
  final String id;
  final String storeName;
  final String location;
  final String storeAddress;
  final String imageLogo;
  final int rating;

  FavStoresModel(
      {required this.id,
      required this.storeName,
      required this.imageLogo,
      required this.location,
      required this.storeAddress,
      required this.rating});
}
