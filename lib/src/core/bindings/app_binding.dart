import 'package:desafio_modelviewlabs/src/pages/home/home_controller.dart';
import 'package:desafio_modelviewlabs/src/repositories/random/http_random_repository.dart';
import 'package:get_it/get_it.dart';

class AppBinding {
  final GetIt getIt = GetIt.I;

  void setupBindings() {
    getIt.registerLazySingleton(() => HttpRandomRepository());
    getIt.registerLazySingleton(
      () => HomeController(
        randomRepository: getIt<HttpRandomRepository>(),
      ),
    );
  }
}
