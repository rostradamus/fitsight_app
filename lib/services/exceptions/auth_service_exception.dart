import 'package:dio/dio.dart';

abstract class AuthServiceException extends DioError {}

class LoginFailedException extends AuthServiceException {}

class LogoutFailedException extends AuthServiceException {}

class RefreshTokenFailedException extends AuthServiceException {}

class SignUpFailedException extends AuthServiceException {}

class UnexpectedAuthException extends AuthServiceException {}
