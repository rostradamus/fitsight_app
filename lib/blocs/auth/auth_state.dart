import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:wolog_app/models/user.dart';

abstract class AuthState extends Equatable {}

class AuthInitialState extends AuthState {
  @override
  List<Object> get props => null;
}

class AuthRequestState extends AuthState {
  @override
  List<Object> get props => null;
}

class LoginSuccessState extends AuthState {
  final User user;

  LoginSuccessState({@required this.user});
  @override
  List<Object> get props => null;
}

class LoginFailureState extends AuthState {
  final int statusCode;
  final String message;

  LoginFailureState({@required this.statusCode, @required this.message});
  @override
  List<Object> get props => null;
}

class LogoutSuccessState extends AuthState {
  @override
  List<Object> get props => null;
}

class LogoutFailureState extends AuthState {
  final int statusCode;
  final String message;

  LogoutFailureState({@required this.statusCode, @required this.message});
  @override
  List<Object> get props => null;
}
