import 'package:fitsight_app/services/auth_service.dart';
import 'package:fitsight_app/services/exceptions/auth_service_exception.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:fitsight_app/blocs/auth/auth_event.dart';
import 'package:fitsight_app/blocs/auth/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthService _authService = GetIt.I.get<AuthService>();

  @override
  AuthState get initialState => AuthInitialState();

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    try {
      if (event is AppLoaded) {
        yield AuthRequestState();
        await _authService.refreshToken();
        yield LoginSuccessState(auth: _authService.auth);
      } else if (event is LoginSubmitted) {
        yield AuthRequestState();
        await _authService.login(
          event.email,
          event.password,
        );
        yield LoginSuccessState(auth: _authService.auth);
      } else if (event is LogoutSubmitted) {
        yield AuthRequestState();
        await _authService.logout();
        yield LogoutSuccessState();
      } else if (event is SignUpSubmitted) {
        yield AuthRequestState();
        await _authService.signUp(
          email: event.email,
          password: event.password,
          firstName: event.firstName,
          lastName: event.lastName,
        );
        yield SignUpSuccessState();
      } else {
        throw new Exception('${event.runtimeType} is NOT implemented');
      }
    } on LoginFailedException catch (e) {
      yield LoginFailureState(error: e);
    } on LogoutFailedException catch (e) {
      yield LogoutFailureState(error: e);
    } on RefreshTokenFailedException {
      yield LoginWaitingState();
    } on SignUpFailedException catch (e) {
      yield SignUpFailureState(error: e);
    } on UnexpectedAuthException catch (e) {
      yield UnexpectedFailureState(error: e);
    }
  }
}
