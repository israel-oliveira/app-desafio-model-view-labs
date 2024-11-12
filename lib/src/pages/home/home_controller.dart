import 'package:desafio_modelviewlabs/src/core/exceptions/random_exception.dart';
import 'package:desafio_modelviewlabs/src/core/fp/either.dart';
import 'package:desafio_modelviewlabs/src/core/helpers/messages.dart';
import 'package:desafio_modelviewlabs/src/repositories/random/random_repository.dart';
import 'package:signals_flutter/signals_flutter.dart';

class HomeController with MessageStateMixin {
  final RandomRepository _randomRepository;
  final password = signal<String>('');

  HomeController({required RandomRepository randomRepository})
      : _randomRepository = randomRepository;

  Future<void> getRandomPassword() async {
    Either<RandomException, String> randomResult =
        await _randomRepository.getRandomPassword();

    switch (randomResult) {
      case Left(value: RandomError(message: final message)):
        return showError(message);
      case Left(value: RandomUnavailable()):
        getRandomPassword();
        break;
      case Right(value: final pass):
        password.value = pass;
        break;
    }
  }
}
