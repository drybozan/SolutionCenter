import 'package:flutter/material.dart';

InputDecoration textFormFieldDecoration(
    {Widget? suffixIcon,
      Widget? prefixIcon,
      String? hint,
      String? label,
      required BuildContext context}) {

  final theme = Theme.of(context);
  BorderSide borderSide = BorderSide(
    color: theme.colorScheme.outline,
  );
  BorderRadius borderRadius = BorderRadius.circular(8);
  return InputDecoration(
    focusColor: theme.colorScheme.onBackground,
    suffixIcon: suffixIcon,
    //add prefix icon
    prefixIcon: prefixIcon,
    suffixStyle: theme.textTheme.bodyLarge,

    contentPadding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20),
    border: OutlineInputBorder(
      borderSide: borderSide,
      borderRadius: borderRadius,
    ),

    enabledBorder: OutlineInputBorder(
      borderSide: borderSide,
      borderRadius: borderRadius,
    ),

    focusedBorder: OutlineInputBorder(
      borderSide: borderSide,
      borderRadius: borderRadius,
    ),
    fillColor: theme.colorScheme.onBackground,
    disabledBorder: OutlineInputBorder(
      borderSide: borderSide,
      borderRadius: borderRadius,
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderSide: borderSide,
      borderRadius: borderRadius,
    ),
    errorBorder: OutlineInputBorder(
      borderSide: borderSide,
      borderRadius: borderRadius,
    ),
    hintText: hint,
    errorStyle: theme.textTheme.bodySmall!.copyWith(
      color: theme.colorScheme.error,
    ),
    errorMaxLines: 2,

//make hint text
    hintStyle: theme.textTheme.bodyLarge,

//create lable
    labelText: label,

//lable style
    labelStyle: theme.textTheme.labelLarge,
  );
}
