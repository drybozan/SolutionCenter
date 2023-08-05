import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:soltion_center/controllers/localization_controller.dart';

import 'dialog_button.dart';

class LanguageDialog extends StatelessWidget {
  const LanguageDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final lang = Provider.of<LocalizationController>(context, listen: true);
    final theme = Theme.of(context);
    final scrollController = ScrollController();
    return Dialog(
      // insetAnimationDuration: const Duration(seconds: 2),

      backgroundColor: theme.colorScheme.background,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 24,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: lang.getLangDirection() == LangDirection.left
              ? CrossAxisAlignment.start
              : CrossAxisAlignment.end,
          children: [
            Text(
              lang.getLanguage().language!,
              textAlign: lang.getLangDirection() == LangDirection.left
                  ? TextAlign.left
                  : TextAlign.right,
              style: theme.textTheme.titleLarge!.copyWith(
                color: theme.colorScheme.onSecondaryContainer,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              lang.getLanguage().languageDialogDescription!,
              textAlign: lang.getLangDirection() == LangDirection.left
                  ? TextAlign.left
                  : TextAlign.right,
              style: theme.textTheme.titleMedium!.copyWith(
                color: theme.colorScheme.outline,
              ),
            ),
            const SizedBox(height: 24),
            Scrollbar(
              controller: scrollController,
              thumbVisibility: true,
              child: ListView.builder(
                shrinkWrap: true,
                controller: scrollController,
                itemCount: lang.getLanguageTitles().length,
                itemBuilder: (context, index) => SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: DialogButton(
                    langDirection: lang.getLangDirection(),
                    isSelected: lang.getLanguageTitle() ==
                        lang.getLanguageTitles().values.elementAt(index),
                    buttonText:
                        lang.getLanguageTitles().values.elementAt(index),
                    theme: theme,
                    backgroundColor: lang.getLanguageTitle() ==
                            lang.getLanguageTitles().values.elementAt(index)
                        ? MaterialStateProperty.all(
                            theme.colorScheme.secondaryContainer)
                        : MaterialStateProperty.all(Colors.transparent),
                    textColor: lang.getLanguageTitle() ==
                            lang.getLanguageTitles().values.elementAt(index)
                        ? theme.colorScheme.primary
                        : theme.colorScheme.onBackground,
                    onPressed: lang.getLanguageTitle() ==
                            lang.getLanguageTitles().values.elementAt(index)
                        ? () {
                            Navigator.pop(context);
                          }
                        : () {
                            lang.setAppLang =
                                lang.languages.keys.elementAt(index);
                            Navigator.pop(context);
                          },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
