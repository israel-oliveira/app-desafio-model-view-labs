import 'package:desafio_modelviewlabs/src/core/exceptions/validate_exception.dart';
import 'package:desafio_modelviewlabs/src/core/fp/either.dart';

abstract interface class ValidateRepository {
  Future<Either<ValidateException, String>> validatePassword(String password);
}