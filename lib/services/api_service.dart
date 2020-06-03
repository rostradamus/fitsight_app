import 'dart:io';

import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:path_provider/path_provider.dart';
import 'package:wolog_app/models/user.dart';

class ApiService {
  final Dio _client = new Dio();
  CookieJar _cookieJar;

  ApiService() {
    _client.options.baseUrl = "http://localhost:8080/api";
    _client.options.connectTimeout = 5000;
    _client.options.receiveTimeout = 5000;
    _client.options.headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };
  }

  Future<void> init() async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    _cookieJar = PersistCookieJar(dir: appDocDir.path + "/.cookies/");
    _client.interceptors.add(CookieManager(_cookieJar));
  }

  Dio getConnection() {
    return this._client;
  }

  CookieJar getCookieJar() {
    return this._cookieJar;
  }

  Future<User> login(email, password) async {
    var response = await _client
        .post('/auth', data: {"email": email, "password": password});

    Map responseBody = response.data;
    Set<String> roles = List<String>.from(responseBody['roles']).toSet();

    _client.options.headers['authorization'] =
        "${responseBody['type']} ${responseBody['token']}";
    return User(responseBody['email'], roles);
  }

  Future<void> logout() async {
    _client.options.headers.remove('authorization');
  }
}
