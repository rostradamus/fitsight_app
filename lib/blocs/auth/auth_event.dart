import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class AuthEvent extends Equatable {}

class LoginSubmittedEvent extends AuthEvent {
  final String email, password;
  LoginSubmittedEvent({@required this.email, @required this.password});
  @override
  List<Object> get props => null;
}

class LogoutSubmittedEvent extends AuthEvent {
  @override
  List<Object> get props => null;
}
