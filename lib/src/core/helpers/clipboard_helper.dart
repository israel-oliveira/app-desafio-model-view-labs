import 'package:flutter/services.dart';

class ClipboardHelper {
  ClipboardHelper._();

  static Future<void> copy(String value) async {
    await Clipboard.setData(ClipboardData(text: value));
  }

  static Future<String> paste() async {
    final clipboardData = await Clipboard.getData(Clipboard.kTextPlain);
    return clipboardData?.text ?? '';
  }
}
