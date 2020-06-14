import 'package:equatable/equatable.dart';

import 'package:fitsight_app/models/auth.dart';
import 'package:fitsight_app/services/exceptions/auth_service_exception.dart';
import 'package:meta/meta.dart';

abstract class AuthState extends Equatable {
  @override
  List<Object> get props => [];
}

class AuthInitialState extends AuthState {}

class AuthRequestState extends AuthState {}

class RefreshTokenSuccessState extends AuthState {}

class RefreshTokenFailureState extends AuthState {}

class LoginWaitingState extends AuthState {}

class LoginSuccessState extends AuthState {
  final Auth auth;

  LoginSuccessState({@required this.auth});

  @override
  List<Object> get props => [auth];
}

class LoginFailureState extends AuthState {
  final AuthServiceException error;

  LoginFailureState({@required this.error});

  @override
  List<Object> get props => [error];
}

class LogoutRequestState extends AuthState {}

class LogoutSuccessState extends AuthState {}

class LogoutFailureState extends AuthState {
  final AuthServiceException error;

  LogoutFailureState({@required this.error});

  @override
  List<Object> get props => [error];
}

class SignUpWaitingState extends AuthState {}

class SignUpRequestState extends AuthState {}

class SignUpSuccessState extends AuthState {}

class SignUpFailureState extends AuthState {
  final AuthServiceException error;

  SignUpFailureState({@required this.error});

  @override
  List<Object> get props => [error];
}

class UnexpectedFailureState extends AuthState {
  final AuthServiceException error;

  UnexpectedFailureState({@required this.error});

  @override
  List<Object> get props => [error];
}
