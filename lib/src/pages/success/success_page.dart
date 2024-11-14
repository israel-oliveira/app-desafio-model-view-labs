import 'package:desafio_modelviewlabs/src/core/bindings/app_binding.dart';
import 'package:desafio_modelviewlabs/src/core/theme/app_theme.dart';
import 'package:desafio_modelviewlabs/src/pages/home/home_controller.dart';
import 'package:flutter/material.dart';

class SuccessPage extends StatefulWidget {
  const SuccessPage({super.key});

  @override
  State<SuccessPage> createState() => _SuccessPageState();
}

class _SuccessPageState extends State<SuccessPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              AppBinding.getIt<HomeController>().validMessage.value,
              style: AppTheme.titleStyle.copyWith(fontSize: 28),
            ),
            const Icon(
              Icons.check,
              size: 60,
              color: AppTheme.blueColor,
            )
          ],
        ),
      ),
    );
  }
}
