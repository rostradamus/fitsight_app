import 'package:fitsight_app/services/auth_service.dart';
import 'package:get_it/get_it.dart';
import 'package:fitsight_app/services/api_service.dart';

void setupLocator() {
  GetIt.I.registerSingletonAsync<ApiService>(() async {
    final apiService = ApiService();
    return apiService.init();
  });
  GetIt.I.registerSingleton<AuthService>(AuthService());
}
