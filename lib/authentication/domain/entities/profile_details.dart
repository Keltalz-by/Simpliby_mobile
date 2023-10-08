import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class ProfileDatails extends Equatable {
  String name;
  String email;
  String? phoneNumber;
  String? location;
  String? occupation;
  String image;

  ProfileDatails(
    this.name,
    this.email,
    this.phoneNumber,
    this.location,
    this.occupation,
    this.image,
  );

  @override
  List<Object?> get props =>
      [name, email, phoneNumber, location, occupation, image];
}
