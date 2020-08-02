import 'package:dio/dio.dart';
import 'package:fitsight_app/models/user.dart';
import 'package:get_it/get_it.dart';

import 'api_service.dart';
import 'exceptions/common_http_exception.dart';

class FriendsService {
  ApiService get _apiService => GetIt.I.get<ApiService>();

  Future<List<User>> fetchUsers() async {
    try {
      var response = await _apiService.getClient().get('/users');
      return List.from(List<Map>.from(response.data)
          .map((Map model) => User.fromJson(model)));
    } on DioError catch (e) {
      if (e.response != null) throw FetchFailedException();
      throw UnexpectedFriendsException();
    }
  }
}

class UnexpectedFriendsException extends DioError {}
