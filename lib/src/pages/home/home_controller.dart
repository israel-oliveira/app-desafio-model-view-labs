import 'dart:async';

import 'package:desafio_modelviewlabs/src/core/exceptions/random_exception.dart';
import 'package:desafio_modelviewlabs/src/core/exceptions/validate_exception.dart';
import 'package:desafio_modelviewlabs/src/core/fp/either.dart';
import 'package:desafio_modelviewlabs/src/core/helpers/copy_modal.dart';
import 'package:desafio_modelviewlabs/src/core/helpers/messages.dart';
import 'package:desafio_modelviewlabs/src/repositories/random/random_repository.dart';
import 'package:desafio_modelviewlabs/src/repositories/validate/validate_repository.dart';
import 'package:signals_flutter/signals_flutter.dart';
import 'package:translator/translator.dart';

class HomeController with MessageStateMixin, CopyModalStateMixin {
  final RandomRepository _randomRepository;
  final ValidateRepository _validateRepository;
  final password = signal<String>('');
  final validMessage = signal<String>('');
  final validErrorMessage = signal<String>('');
  final _obscurePassword = signal(true);
  final isValidPassword = signal(false);

  // Variavel para limitar a quantidade de vezes que que a função irá ser chamada recursivamente
  int recursiveCount = 0;

  HomeController(
      {required RandomRepository randomRepository,
      required ValidateRepository validateRepository})
      : _randomRepository = randomRepository,
        _validateRepository = validateRepository;

  Future<void> getRandomPassword() async {
    Either<RandomException, String> randomResult =
        await _randomRepository.getRandomPassword();

    switch (randomResult) {
      case Left(value: RandomError(message: final message)):
        return showError(message);
      case Left(value: RandomUnavailable(message: final message)):
        if (recursiveCount < 2) {
          recursiveCount++;
          await getRandomPassword();
        } else {
          showError(message);
        }
        break;
      case Right(value: final pass):
        recursiveCount = 0;
        showSuccess("Nova senha gerada!");
        scheduleMicrotask(() => showCopyModal(pass));
        password.value = pass;
        break;
    }
  }

  Future<void> validatePassword(String password) async {
    password = password.trim();
    if (password.isEmpty) {
      validErrorMessage.value = "Por favor, digite uma senha";
      return showInfo("Por favor, digite uma senha");
    }

    Either<ValidateException, String> validateResult =
        await _validateRepository.validatePassword(password);

    switch (validateResult) {
      case Left(value: ValidateFailed(:final message)):
        final translator = GoogleTranslator();
        var ptMessage = await translator.translate(message, to: 'pt');
        showError(ptMessage.text);
        validErrorMessage.value = ptMessage.text;
        break;
      case Left(value: ValidateError(:final message)):
        showError(message);
        break;
      case Left(value: EntityValidate(:final message)):
        showError(message);
        break;
      case Right(value: final message):
        showSuccess(message);
        untracked(() => validMessage.value = message);
        scheduleMicrotask(() => isValidPassword.value = true);
    }
  }

  bool get obscurePassword => _obscurePassword();
  void passwordToggle() => _obscurePassword.value = !_obscurePassword.value;
}
