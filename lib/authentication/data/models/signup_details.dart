import 'package:equatable/equatable.dart';

class SignupDetail extends Equatable {
  final String email;
  final String password;
  final String name;

  SignupDetail(
      {required this.email, required this.password, required this.name});

  @override
  List<Object?> get props => [name, email, password];
}
