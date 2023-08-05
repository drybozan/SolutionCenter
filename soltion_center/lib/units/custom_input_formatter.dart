import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

class OnlyOneSpaceAllowedAfterEachStringInputFormatter
    extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String formattedText = newValue.text;

    if (formattedText.length >= 2) {
      String lastChar = formattedText.substring(
          formattedText.length - 1, formattedText.length);
      String beforeLastChar = formattedText.substring(
          formattedText.length - 2, formattedText.length - 1);

      debugPrint('last char: $lastChar');
      debugPrint('before last char: $beforeLastChar');
      debugPrint(
          'formatted text: ${formattedText.substring(0, formattedText.length - 1)}');

      if (lastChar == ' ' && beforeLastChar == ' ') {
        formattedText = formattedText.substring(0, formattedText.length - 1);
      }
    }

    return TextEditingValue(
      text: formattedText,
      selection: TextSelection.collapsed(offset: formattedText.length),
    );
  }
}
