import 'dart:async';
import 'dart:developer';

import 'package:desafio_modelviewlabs/src/app.dart';
import 'package:desafio_modelviewlabs/src/core/bindings/app_binding.dart';
import 'package:flutter/material.dart';

void main() {
  AppBinding().setupBindings();

  runZonedGuarded(() {
    runApp(const App());
  }, (error, stack) {
    log("Erro não tratado", error: error, stackTrace: stack);
    throw error;
  });
}
