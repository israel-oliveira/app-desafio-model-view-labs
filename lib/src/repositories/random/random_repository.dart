import 'package:desafio_modelviewlabs/src/core/exceptions/random_exception.dart';
import 'package:desafio_modelviewlabs/src/core/fp/either.dart';

abstract interface class RandomRepository {
  Future<Either<RandomException, String>> getRandomPassword();
}
