import 'package:asyncstate/asyncstate.dart';
import 'package:desafio_modelviewlabs/src/core/theme/app_theme.dart';
import 'package:desafio_modelviewlabs/src/loader/app_loader.dart';
import 'package:desafio_modelviewlabs/src/pages/home/home_page.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return AsyncStateBuilder(
      loader: AppLoader(),
      builder: (navigatorObserver) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          navigatorObservers: [navigatorObserver],
          title: 'Flutter Demo',
          theme: AppTheme.ligthTheme,
          home: const HomePage(),
        );
      },
    );
  }
}
