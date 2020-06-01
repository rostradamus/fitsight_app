import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:wolog_app/models/user.dart';

abstract class AuthState extends Equatable {}

class AuthInitialState extends AuthState {
  @override
  // TODO: implement props
  List<Object> get props => null;
}

class AuthRequestState extends AuthState {
  @override
  // TODO: implement props
  List<Object> get props => null;
}

class LoginSuccessState extends AuthState {
  User user;

  LoginSuccessState({@required this.user});
  @override
  // TODO: implement props
  List<Object> get props => null;
}

class LoginFailureState extends AuthState {
  String message;

  LoginFailureState({@required this.message});
  @override
  // TODO: implement props
  List<Object> get props => null;
}

class LogoutSuccessState extends AuthState {
  @override
  // TODO: implement props
  List<Object> get props => null;
}

class LogoutFailureState extends AuthState {
  String message;

  LogoutFailureState({@required this.message});
  @override
  // TODO: implement props
  List<Object> get props => null;
}

