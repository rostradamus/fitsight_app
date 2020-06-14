import 'dart:async';
import 'dart:io';

import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:fitsight_app/services/api_service/api_serivce_interceptor.dart';
import 'package:path_provider/path_provider.dart';
import 'package:fitsight_app/services/exceptions/unsupported_os_exception.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class ApiService {
  final Dio _client = new Dio();
  CookieJar _cookieJar;

  ApiService() {
    if (Platform.isAndroid)
      _client.options.baseUrl = "http://10.0.2.2:8080/api";
    else if (Platform.isIOS)
      _client.options.baseUrl = "http://localhost:8080/api";
    else
      throw UnsupportedOSException(Platform.operatingSystem);

    _client.options.connectTimeout = 5000;
    _client.options.receiveTimeout = 5000;
    _client.options.headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };
  }

  Future<Dio> init() async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    _cookieJar = PersistCookieJar(
      dir: appDocDir.path + "/.cookies/",
    );
    return _client
      ..interceptors.addAll(
        [
          CookieManager(
            _cookieJar,
          ),
          PrettyDioLogger(
            requestHeader: true,
            requestBody: true,
            responseBody: true,
            responseHeader: false,
            error: true,
            compact: true,
            maxWidth: 90,
          ),
          ApiServiceInterceptor(client: _client),
        ],
      );
  }

  Dio getClient() {
    return this._client;
  }

  CookieJar getCookieJar() {
    return this._cookieJar;
  }
}
