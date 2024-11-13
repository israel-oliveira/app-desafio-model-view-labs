import 'package:desafio_modelviewlabs/src/app.dart';
import 'package:desafio_modelviewlabs/src/core/bindings/app_binding.dart';
import 'package:flutter/material.dart';

void main() {
  AppBinding().setupBindings();
  runApp(const App());
}
