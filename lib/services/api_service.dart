import 'package:dio/dio.dart';
import 'package:wolog_app/models/user.dart';

class ApiService {
  final Dio _client = new Dio();

  ApiService() {
    _client.options.baseUrl = "http://localhost:8080/api";
    _client.options.connectTimeout=5000;
    _client.options.receiveTimeout=5000;
    _client.options.headers = {
      'Content-type' : 'application/json',
      'Accept': 'application/json',
    };
  }

  Dio getConnection() {
    return this._client;
  }

  Future<User> login(email, password) async {
    var response = await _client.post('/auth', data: {
      "email": email,
      "password": password
    });

    Map responseBody = response.data;
    Set<String> roles = List<String>.from(responseBody['roles']).toSet();

    _client.options.headers['authorization'] = "${responseBody['type']} ${responseBody['token']}";
    return User(responseBody['email'], roles);
  }

  Future<void> logout() async {
    _client.options.headers.remove('authorization');
  }
}
