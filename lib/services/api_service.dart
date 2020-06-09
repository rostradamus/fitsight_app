import 'dart:async';
import 'dart:io';

import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:path_provider/path_provider.dart';
import 'package:fitsight_app/models/auth.dart';
import 'package:fitsight_app/services/exceptions/unsupported_os_exception.dart';

class ApiService {
  final Dio _client = new Dio();
  CookieJar _cookieJar;

  ApiService() {
    if (Platform.isAndroid)
      _client.options.baseUrl = "http://10.0.2.2:8080/api";
    else if (Platform.isIOS)
      _client.options.baseUrl = "http://localhost:8080/api";
    else
      throw new UnsupportedOSException(Platform.operatingSystem);

    _client.options.connectTimeout = 5000;
    _client.options.receiveTimeout = 5000;
    _client.options.headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };
  }

  Future<void> init() async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    _cookieJar = PersistCookieJar(
      dir: appDocDir.path + "/.cookies/",
    );
    _client.interceptors.add(CookieManager(
      _cookieJar,
    ));
  }

  Dio getClient() {
    return this._client;
  }

  CookieJar getCookieJar() {
    return this._cookieJar;
  }

  Future<Auth> login(email, password) async {
    var response = await _client.post('/auth', data: {
      "email": email,
      "password": password,
    });

    Map responseBody = response.data;

    _client.options.headers['authorization'] =
        "${responseBody['type']} ${responseBody['token']}";
    return Auth.fromJson(responseBody);
  }

  Future<Auth> refreshToken() async {
    var response = await _client.post('/auth/refresh_token');

    Map responseBody = response.data;

    _client.options.headers['authorization'] =
        "${responseBody['type']} ${responseBody['token']}";
    return Auth.fromJson(responseBody);
  }

  Future<void> logout() async {
    await _client.delete('/auth');
    _client.options.headers.remove('authorization');
  }
}
