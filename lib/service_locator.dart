import 'package:get_it/get_it.dart';
import 'package:fitsight_app/services/api_service.dart';

void setupLocator() {
  GetIt.I.registerSingletonAsync<ApiService>(() async {
    final apiService = ApiService();
    await apiService.init();
    return apiService;
  });
}
