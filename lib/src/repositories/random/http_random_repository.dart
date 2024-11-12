import 'dart:convert';
import 'dart:developer';

import 'package:desafio_modelviewlabs/src/core/env.dart';
import 'package:desafio_modelviewlabs/src/core/exceptions/random_exception.dart';
import 'package:desafio_modelviewlabs/src/core/fp/either.dart';
import 'package:desafio_modelviewlabs/src/repositories/random/random_repository.dart';
import 'package:http/http.dart' show get, Response;

class HttpRandomRepository implements RandomRepository {
  @override
  Future<Either<RandomException, String>> getRandomPassword() async {
    String stringUrl = "${Env.baseUrl}/random";
    log(stringUrl);

    Uri url = Uri.parse(stringUrl);
    final Response(body: body, statusCode: status) = await get(url);
    log(body);
    log(status.toString());

    return switch (status) {
      200 => Right(jsonDecode(body)["password"]),
      503 => Left(RandomUnavailable(
          message: "Servidor impossibilitado de processar essa solicitação")),
      _ => Left(RandomError(message: "Erro ao realizar requisição"))
    };
  }
}
