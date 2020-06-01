import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class AuthEvent extends Equatable {}

class LoginSubmittedEvent extends AuthEvent {
  final String email, password;
  LoginSubmittedEvent({@required this.email, @required this.password});
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class LogoutSubmittedEvent extends AuthEvent {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}
