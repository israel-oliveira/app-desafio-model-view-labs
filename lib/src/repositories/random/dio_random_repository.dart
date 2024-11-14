import 'dart:developer';
import 'dart:io';

import 'package:desafio_modelviewlabs/src/core/exceptions/random_exception.dart';
import 'package:desafio_modelviewlabs/src/core/fp/either.dart';
import 'package:desafio_modelviewlabs/src/core/restClient/rest_client.dart';
import 'package:desafio_modelviewlabs/src/repositories/random/random_repository.dart';
import 'package:dio/dio.dart';

class DioRandomRepository implements RandomRepository {
  final RestClient restClient;

  DioRandomRepository({required this.restClient});

  @override
  Future<Either<RandomException, String>> getRandomPassword() async {
    try {
      final Response(data: {'password': password}) =
          await restClient.get('/random');

      return Right(password);
    } on DioException catch (e, s) {
      log("Erro ao buscar a senha: ", error: e, stackTrace: s);
      return switch (e) {
        DioException(
          response: Response(statusCode: HttpStatus.serviceUnavailable)?
        ) =>
          Left(RandomUnavailable(
              message: "Houve um problema, tente novamente mais tarde!")),
        _ => Left(RandomError(message: "Erro, por favor, contate o suporte"))
      };
    }
  }
}
