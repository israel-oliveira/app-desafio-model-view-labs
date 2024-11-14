import 'package:desafio_modelviewlabs/src/core/helpers/clipboard_helper.dart';
import 'package:desafio_modelviewlabs/src/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:signals_flutter/signals_flutter.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

final class CopyModal {
  static void showClipModal(String message, BuildContext context,
      {String? title, TextStyle? titleStyle}) {
    showModalBottomSheet(
      context: context,
      builder: (_) => BottomSheet(
        onClosing: () {},
        builder: (context) => Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title ?? "Sua senha",
                  style:
                      titleStyle ?? AppTheme.titleStyle.copyWith(fontSize: 25),
                ),
                const SizedBox(
                  height: 14,
                ),
                Text(
                  message,
                  style: const TextStyle(fontSize: 18),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 40,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text("Não copiar"),
                    ),
                    FilledButton(
                      onPressed: () async {
                        await ClipboardHelper.copy(message);
                        if (context.mounted) {
                          showTopSnackBar(
                            Overlay.of(context),
                            const CustomSnackBar.success(
                                message: "Senha copiada"),
                          );
                          Navigator.pop(context);
                        }
                      },
                      child: const Text("Copiar"),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

mixin CopyModalStateMixin {
  final Signal<String?> _pass = signal(null);
  String? get pass => _pass();

  void clearValue() => _pass.value = null;

  void showCopyModal(String value) {
    untracked(() => clearValue());
    _pass.value = value;
  }
}

mixin CopyModalViewMixin<T extends StatefulWidget> on State<T> {
  void modalListener(CopyModalStateMixin state) {
    effect(() {
      if (state.pass != null) {
        CopyModal.showClipModal(state.pass!, context);
      }
    });
  }
}
