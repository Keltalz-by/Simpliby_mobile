import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class LoginDetail extends Equatable {
  final String email;
  final String password;

  LoginDetail({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}
