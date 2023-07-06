import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class BusinessRegDetails extends Equatable {
  final String name;
  final String location;
  // ignore: non_constant_identifier_names
  final String brief_desc;
  final String address;
  final String city;
  final String country;
  final String images;
  final String logo;

  BusinessRegDetails({
    required this.name,
    required this.location,
    required this.brief_desc,
    required this.address,
    required this.city,
    required this.country,
    required this.images,
    required this.logo,
  });

  @override
  List<Object?> get props =>
      [name, location, brief_desc, address, city, country, images, logo];
}
