import 'dart:async';

import 'package:fitsight_app/models/auth.dart';
import 'package:get_it/get_it.dart';

import 'api_service.dart';

class AuthService {
  Auth _auth;

  AuthService() : this._auth = Auth();

  Auth get auth => _auth;
  String get authorizationHeader => "${_auth.type} ${_auth.token}";

  ApiService get _apiService => GetIt.I.get<ApiService>();

  Future<void> login(email, password) async {
    var response = await _apiService.getClient().post('/auth', data: {
      "email": email,
      "password": password,
    });

    Map responseBody = response.data;

    _auth = Auth.fromJson(responseBody);
  }

  Future<void> refreshToken() async {
    var response = await _apiService.getClient().post('/auth/refresh_token');

    Map responseBody = response.data;

    _auth = Auth.fromJson(responseBody);
  }

  Future<void> logout() async {
    await _apiService.getClient().delete('/auth');
    GetIt.I
        .get<ApiService>()
        .getClient()
        .options
        .headers
        .remove('authorization');
  }
}
