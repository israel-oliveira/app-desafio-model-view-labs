import 'package:desafio_modelviewlabs/src/core/env.dart';
import 'package:desafio_modelviewlabs/src/core/restClient/rest_client.dart';
import 'package:desafio_modelviewlabs/src/pages/home/home_controller.dart';
import 'package:desafio_modelviewlabs/src/repositories/random/dio_random_repository.dart';
import 'package:desafio_modelviewlabs/src/repositories/validate/dio_validate_repository.dart';
// import 'package:desafio_modelviewlabs/src/repositories/random/http_random_repository.dart';
import 'package:get_it/get_it.dart';

class AppBinding {
  static GetIt getIt = GetIt.I;

  void setupBindings() {
    getIt.registerLazySingleton(() => RestClient(Env.baseUrl));
    getIt.registerLazySingleton(
        () => DioRandomRepository(restClient: getIt<RestClient>()));
    getIt.registerLazySingleton(
        () => DioValidateRepository(restClient: getIt<RestClient>()));
    getIt.registerLazySingleton(
      () => HomeController(
        randomRepository: getIt<DioRandomRepository>(),
        validateRepository: getIt<DioValidateRepository>(),
      ),
    );
  }
}
