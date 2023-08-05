import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:soltion_center/units/custom_input_formatter.dart';

//Padding

const double defaultPaddingVertical = 16;
const double defaultPaddingValue = 16;
const double defaultPaddingHorizontal = 32;
const EdgeInsetsGeometry defaultPaddingSymmetric =
    EdgeInsets.symmetric(vertical: 16, horizontal: 32);
const EdgeInsetsGeometry buttonPaddingSymmetric =
    EdgeInsets.symmetric(vertical: 12, horizontal: 24);
const EdgeInsetsGeometry defaultPaddingAll = EdgeInsets.all(16.0);

//Sizes
const double defaultIconSize = 24;
SizedBox spacing(
    {bool? hasHeight, bool? hasWidth, double? height, double? width}) {
  return SizedBox(
      height: height ?? (hasHeight != null ? 24 : null),
      width: width ?? (hasWidth != null ? 24 : null));
}

//TextInputFormatters
final inputFormatters = {
  'denySpace': FilteringTextInputFormatter.deny(RegExp('[ ]')),
  'denySpecialChars': FilteringTextInputFormatter.deny(
      RegExp(r"[%^&*()_/-/.!@#&,`!<>₺{};|:$\\//]")),
  'denyNumbers': FilteringTextInputFormatter.deny(RegExp(r"[0-9]")),
  'denyArabicNumbers':
      FilteringTextInputFormatter.deny(RegExp(r"[/^[\u0660-\u0669]{10}$/;]")),
  'customInputFormatter': OnlyOneSpaceAllowedAfterEachStringInputFormatter(),
};

// Show message bar
void showSnackbar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: Theme.of(context).snackBarTheme.backgroundColor,
      content: Text(
        message,
        textAlign: TextAlign.center,
      ),
    ),
  );
}

// Borders
const double defaultBorderRadiusCircular = 30;
