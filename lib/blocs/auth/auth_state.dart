import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:fitsight_app/models/auth.dart';

abstract class AuthState extends Equatable {}

class AuthInitialState extends AuthState {
  @override
  List<Object> get props => null;
}

class AuthRequestState extends AuthState {
  @override
  List<Object> get props => null;
}

class RefreshTokenSuccessState extends AuthState {
  @override
  List<Object> get props => null;
}

class RefreshTokenFailureState extends AuthState {
  @override
  List<Object> get props => null;
}

class LoginWaitingState extends AuthState {
  @override
  List<Object> get props => null;
}

class LoginSuccessState extends AuthState {
  final Auth auth;

  LoginSuccessState({@required this.auth});
  @override
  List<Object> get props => null;
}

class LoginFailureState extends AuthState {
  final DioErrorType type;
  final int statusCode;
  final String message;

  LoginFailureState({this.type, this.statusCode, @required this.message});
  @override
  List<Object> get props => null;
}

class LogoutRequestState extends AuthState {
  @override
  List<Object> get props => null;
}

class LogoutSuccessState extends AuthState {
  @override
  List<Object> get props => null;
}

class LogoutFailureState extends AuthState {
  final DioErrorType type;
  final int statusCode;
  final String message;

  LogoutFailureState({this.type, this.statusCode, @required this.message});
  @override
  List<Object> get props => null;
}

class SignUpWaitingState extends AuthState {
  @override
  List<Object> get props => null;
}

class SignUpRequestState extends AuthState {
  @override
  List<Object> get props => null;
}

class SignUpSuccessState extends AuthState {
  @override
  List<Object> get props => null;
}

class SignUpFailureState extends AuthState {
  final DioErrorType type;
  final int statusCode;
  final String message;
  SignUpFailureState({
    this.type,
    this.statusCode,
    @required this.message,
  });
  @override
  List<Object> get props => null;
}
