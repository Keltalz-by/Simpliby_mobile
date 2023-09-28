import 'package:equatable/equatable.dart';

class StoreInfo extends Equatable {
  final int storeId;
  final String name;
  final String address;
  final String logo;
  final String about;
  final String phoneNumber;
  final String email;
  final int followers;
  final int rating;
  final String storeImages;

  StoreInfo(
      this.storeId,
      this.name,
      this.address,
      this.logo,
      this.about,
      this.phoneNumber,
      this.email,
      this.followers,
      this.rating,
      this.storeImages);

  @override
  List<Object?> get props => [
        storeId,
        name,
        address,
        logo,
        about,
        phoneNumber,
        email,
        followers,
        rating,
        storeImages
      ];
}
