import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();
  @override
  List<Object> get props => [];
}

class AppLoaded extends AuthEvent {}

class LoginSubmitted extends AuthEvent {
  final String email, password;
  LoginSubmitted({
    @required this.email,
    @required this.password,
  });
  @override
  List<Object> get props => [email, password];
}

class LogoutSubmitted extends AuthEvent {}

class SignUpSubmitted extends AuthEvent {
  final String email, password, firstName, lastName;

  SignUpSubmitted({
    @required this.email,
    @required this.password,
    @required this.firstName,
    @required this.lastName,
  });
  @override
  List<Object> get props => [email, password, firstName, lastName];
}
