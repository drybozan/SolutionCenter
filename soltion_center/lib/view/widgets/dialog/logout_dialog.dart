import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soltion_center/controllers/connection_controller.dart';
import 'package:soltion_center/controllers/localization_controller.dart';
import 'package:soltion_center/controllers/user_controller.dart';
import 'package:soltion_center/units/constant_units.dart';

class LogoutDialog extends StatelessWidget {
  const LogoutDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final connection = Provider.of<ConnectionController>(context, listen: true);
    final lang = context.read<LocalizationController>().getLanguage();
    final theme = Theme.of(context);
    return connection.getIsConnected
        ? Dialog(
            backgroundColor: theme.colorScheme.surfaceVariant,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    lang.logoutDialogDescriptionText!,
                    textAlign: TextAlign.center,
                    style: theme.textTheme.labelLarge,
                  ),
                  spacing(
                    height: 24,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      actionButtons(
                        buttonText: lang.logoutDialogCancelButtonText!,
                        theme: theme,
                        backgroundColor: MaterialStateProperty.all(
                            theme.colorScheme.secondary),
                        textColor: theme.colorScheme.onSecondary,
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      actionButtons(
                        buttonText: lang.logoutDialogLogoutButtonText!,
                        theme: theme,
                        backgroundColor:
                            MaterialStateProperty.all(theme.colorScheme.error),
                        textColor: theme.colorScheme.onError,
                        onPressed: () {
                          context.read<UserController>().signOut(context);
                        },
                      ),
                    ],
                  )
                ],
              ),
            ),
          )
        : const SizedBox();
  }

  Widget actionButtons({
    required String buttonText,
    required ThemeData theme,
    MaterialStateProperty<Color?>? backgroundColor,
    Color? textColor,
    required VoidCallback onPressed,
  }) {
    return Expanded(
      child: Padding(
        padding: defaultPaddingAll / 2,
        child: ElevatedButton(
          style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
              ),
            ),
            backgroundColor: backgroundColor,
          ),
          onPressed: onPressed,
          child: Padding(
            padding: defaultPaddingAll / 4,
            child: Text(
              buttonText,
              style: theme.textTheme.labelMedium!.copyWith(
                color: textColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
