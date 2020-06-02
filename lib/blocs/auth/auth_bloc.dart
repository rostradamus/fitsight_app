
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:wolog_app/blocs/auth/auth_event.dart';
import 'package:wolog_app/blocs/auth/auth_state.dart';
import 'package:wolog_app/models/user.dart';
import 'package:wolog_app/services/api_service.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {


  @override
  AuthState get initialState => AuthInitialState();

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    final ApiService _apiService = GetIt.I.get<ApiService>();
    if (event is LoginSubmittedEvent) {
      yield AuthRequestState();
      try {
        User user = await _apiService.login(event.email, event.password);
        yield LoginSuccessState(user: user);
      } on DioError catch (e) {
        yield LoginFailureState(message: e.message);
      }

    } else if (event is LogoutSubmittedEvent) {
      yield AuthRequestState();
      try {
        await _apiService.logout();
        yield LogoutSuccessState();
      } on DioError catch (e) {
        yield LogoutFailureState(message: e.message);
      }
    } else {
      throw new Exception('${event.runtimeType} is NOT implemented');
    }

  }
}
