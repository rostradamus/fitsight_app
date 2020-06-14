import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:fitsight_app/models/auth.dart';
import 'package:fitsight_app/services/exceptions/auth_service_exception.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';

import 'api_service.dart';

class AuthService {
  Auth _auth;

  AuthService() : this._auth = Auth();

  Auth get auth => _auth;
  String get authorizationHeader => "${_auth?.type} ${_auth?.token}";

  bool hasAuth() {
    return _auth != null;
  }

  ApiService get _apiService => GetIt.I.get<ApiService>();

  Future<void> login(email, password) async {
    try {
      var response = await _apiService.getClient().post('/auth', data: {
        "email": email,
        "password": password,
      });
      _auth = Auth.fromJson(response.data);
    } on DioError catch (e) {
      if (e.response?.statusCode == HttpStatus.unauthorized)
        throw LoginFailedException();
      throw UnexpectedAuthException();
    }
  }

  Future<void> refreshToken() async {
    try {
      var response = await _apiService.getClient().post('/auth/refresh_token');
      _auth = Auth.fromJson(response.data);
    } on DioError catch (e) {
      if (e.response?.statusCode == HttpStatus.unauthorized) {
        throw RefreshTokenFailedException();
      }

      throw UnexpectedAuthException();
    }
  }

  Future<void> logout() async {
    try {
      await _apiService.getClient().delete('/auth');
      _auth = null;
    } catch (e) {
      throw LogoutFailedException();
    }
  }

  Future<void> signUp({
    @required email,
    @required password,
    @required firstName,
    @required lastName,
  }) async {
    try {
      await _apiService.getClient().post('/auth/signup', data: {
        "email": email,
        "password": password,
        "firstName": firstName,
        "lastName": lastName,
      });
    } on DioError catch (e) {
      if (e.response?.statusCode == HttpStatus.unprocessableEntity)
        throw SignUpFailedException();
      throw UnexpectedAuthException();
    }
  }
}
