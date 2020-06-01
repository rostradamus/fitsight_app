import 'package:get_it/get_it.dart';
import 'package:wolog_app/services/api_service.dart';

void setupLocators() {
  GetIt.instance.registerLazySingleton(() => ApiService());
}
