import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class AuthEvent extends Equatable {}

class LoginPageLoadedEvent extends AuthEvent {
  @override
  List<Object> get props => null;
}

class LoginSubmittedEvent extends AuthEvent {
  final String email, password;
  LoginSubmittedEvent({
    @required this.email,
    @required this.password,
  });
  @override
  List<Object> get props => null;
}

class LogoutSubmittedEvent extends AuthEvent {
  @override
  List<Object> get props => null;
}

class SignUpPageOpenEvent extends AuthEvent {
  @override
  List<Object> get props => null;
}

class SignUpBackButtonPressedEvent extends AuthEvent {
  @override
  List<Object> get props => null;
}

class SignUpSubmittedEvent extends AuthEvent {
  final String email, password, firstName, lastName;

  SignUpSubmittedEvent({
    @required this.email,
    @required this.password,
    @required this.firstName,
    @required this.lastName,
  });
  @override
  List<Object> get props => null;
}
