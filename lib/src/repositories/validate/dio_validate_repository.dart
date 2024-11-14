import 'dart:developer';
import 'dart:io';

import 'package:desafio_modelviewlabs/src/core/exceptions/validate_exception.dart';
import 'package:desafio_modelviewlabs/src/core/fp/either.dart';
import 'package:desafio_modelviewlabs/src/core/restClient/rest_client.dart';
import 'package:desafio_modelviewlabs/src/repositories/validate/validate_repository.dart';
import 'package:dio/dio.dart';

class DioValidateRepository implements ValidateRepository {
  final RestClient restClient;

  DioValidateRepository({required this.restClient});

  @override
  Future<Either<ValidateException, String>> validatePassword(
      String password) async {
    try {
      final Response(data: {'message': message}) =
          await restClient.post('/validate', data: {"password": password});

      return Right(message);
    } on DioException catch (e, s) {
      log("Erro ao validar a senha: ", error: e, stackTrace: s);
      return switch (e) {
        DioException(
          response: Response(
            statusCode: HttpStatus.badRequest,
            data: {'errors': final error}
          )?
        ) =>
          Left(ValidateFailed(message: error[0])),
        DioException(
          response: Response(statusCode: HttpStatus.methodNotAllowed)?
        ) =>
          Left(ValidateError(message: 'Metodo não permitido')),
        DioException(
          response: Response(statusCode: HttpStatus.serviceUnavailable)?
        ) =>
          Left(ValidateError(message: 'Hoube um problema, tente novamente')),
        DioException(
          response: Response(
            statusCode: HttpStatus.unprocessableEntity,
            data: {'message': final message}
          )?
        ) =>
          Left(EntityValidate(message: message)),
        _ => Left(ValidateError(message: "Erro, por favor, contate o suporte"))
      };
    }
  }
}
