import 'package:asyncstate/asyncstate.dart';
import 'package:desafio_modelviewlabs/src/core/bindings/app_binding.dart';
import 'package:desafio_modelviewlabs/src/core/helpers/copy_modal.dart';
import 'package:desafio_modelviewlabs/src/core/helpers/messages.dart';
import 'package:desafio_modelviewlabs/src/core/theme/app_theme.dart';
import 'package:desafio_modelviewlabs/src/pages/home/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:signals_flutter/signals_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with MessageViewMixin, CopyModalViewMixin {
  HomeController controller = AppBinding.getIt<HomeController>();
  TextEditingController passwordEC = TextEditingController();
  final passGKey = GlobalKey<FormFieldState>();

  @override
  void initState() {
    messageListener(controller);
    modalListener(controller);
    effect(() {
      if (controller.isValidPassword.value) {
        untracked(() => controller.isValidPassword.value = false);
        Navigator.of(context).pushNamed("/success");
      }

      if (controller.validErrorMessage.value.isNotEmpty) {
        passGKey.currentState?.validate();
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    passwordEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final sizeOf = MediaQuery.sizeOf(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(minHeight: sizeOf.height),
          child: Center(
            child: Container(
              padding: const EdgeInsets.all(20),
              constraints: BoxConstraints(maxWidth: sizeOf.width * 0.9),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Form(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Validador de senha",
                      style: AppTheme.titleStyle,
                    ),
                    const SizedBox(
                      height: 28,
                    ),
                    Watch((_) {
                      return TextFormField(
                        key: passGKey,
                        obscureText: controller.obscurePassword,
                        controller: passwordEC,
                        validator: (value) {
                          if (controller.validErrorMessage.value.isNotEmpty) {
                            return controller.validErrorMessage.value;
                          }
                          return null;
                        },
                        onChanged: (value) => {},
                        decoration: InputDecoration(
                          label: const Text('Nova senha'),
                          suffixIcon: IconButton(
                            onPressed: () => controller.passwordToggle(),
                            icon: controller.obscurePassword
                                ? const Icon(Icons.visibility)
                                : const Icon(Icons.visibility_off),
                          ),
                        ),
                      );
                    }),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: FilledButton(
                            onPressed: () async {
                              await controller
                                  .getRandomPassword()
                                  .asyncLoader();

                              passwordEC.text = controller.password();
                            },
                            child: const Text("Gerar senha"),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () async => await controller
                                .validatePassword(passwordEC.text)
                                .asyncLoader(),
                            child: const Text("Validar senha"),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
