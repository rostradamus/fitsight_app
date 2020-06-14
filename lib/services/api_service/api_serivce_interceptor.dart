import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../auth_service.dart';

class ApiServiceInterceptor extends Interceptor {
  final Dio client;

  ApiServiceInterceptor({@required this.client});

  AuthService get authService => GetIt.I.get<AuthService>();

  @override
  Future onRequest(RequestOptions options) async {
    options.headers["Authorization"] =
        GetIt.I.get<AuthService>().authorizationHeader;
    return options;
  }

  @override
  Future onError(DioError err) async {
    if (err.response?.statusCode == 401 &&
        err.request?.path != "/auth/refresh_token") {
      try {
        await authService.refreshToken();

        err.response.request.headers['authorization'] =
            authService.authorizationHeader;
        err.response.request.headers['cookie'] =
            this.client.options.headers['cookie'];
      } catch (e) {
        return e;
      }
      return await this.client.request(
            err.response.request.path,
            data: err.response.request.data,
            options: err.response.request,
          );
    }
    return err;
  }
}
