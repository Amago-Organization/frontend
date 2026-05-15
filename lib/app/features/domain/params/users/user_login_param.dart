import 'package:equatable/equatable.dart';

class UserLoginParam extends Equatable {
  final String email;
  final String password;
  const UserLoginParam({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}
