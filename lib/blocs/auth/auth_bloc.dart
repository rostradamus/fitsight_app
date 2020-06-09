import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:fitsight_app/blocs/auth/auth_event.dart';
import 'package:fitsight_app/blocs/auth/auth_state.dart';
import 'package:fitsight_app/models/auth.dart';
import 'package:fitsight_app/services/api_service.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  @override
  AuthState get initialState => AuthInitialState();

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    final ApiService _apiService = GetIt.I.get<ApiService>();

    if (event is LoginPageLoadedEvent) {
      yield AuthRequestState();
      try {
        Auth auth = await _apiService.refreshToken();
        yield LoginSuccessState(auth: auth);
      } on DioError catch (e) {
        if (e.type == DioErrorType.RESPONSE &&
            e.response.statusCode == HttpStatus.unauthorized) {
          yield LoginWaitingState();
        } else {
          yield LoginFailureState(
            type: e.type,
            message: e.message,
          );
        }
      }
    } else if (event is LoginSubmittedEvent) {
      yield AuthRequestState();
      try {
        Auth auth = await _apiService.login(
          event.email,
          event.password,
        );
        yield LoginSuccessState(auth: auth);
      } on DioError catch (e) {
        if (e.type == DioErrorType.RESPONSE) {
          yield LoginFailureState(
            type: e.type,
            statusCode: e.response.statusCode,
            message: e.message,
          );
        } else {
          yield LoginFailureState(
            type: e.type,
            message: e.message,
          );
        }
      }
    } else if (event is LogoutSubmittedEvent) {
      yield LogoutRequestState();
      try {
        await _apiService.logout();
        yield LogoutSuccessState();
      } on DioError catch (e) {
        if (e.type == DioErrorType.RESPONSE) {
          yield LogoutFailureState(
            type: e.type,
            statusCode: e.response.statusCode,
            message: e.message,
          );
        } else {
          yield LogoutFailureState(
            type: e.type,
            message: e.message,
          );
        }
      }
    } else if (event is SignUpPageOpenEvent) {
      yield SignUpWaitingState();
    } else if (event is SignUpBackButtonPressedEvent) {
      yield LoginWaitingState();
    } else if (event is SignUpSubmittedEvent) {
      yield SignUpRequestState();
      try {
        await _apiService.getClient().post('/auth/signup', data: {
          "email": event.email,
          "password": event.password,
          "firstName": event.firstName,
          "lastName": event.lastName,
        });
        yield SignUpSuccessState();
      } on DioError catch (e) {
        if (e.type == DioErrorType.RESPONSE) {
          yield SignUpFailureState(
            type: e.type,
            statusCode: e.response.statusCode,
            message: e.message,
          );
        } else {
          yield SignUpFailureState(
            type: e.type,
            message: e.message,
          );
        }
      }
    } else {
      throw new Exception('${event.runtimeType} is NOT implemented');
    }
  }
}
