import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soltion_center/controllers/localization_controller.dart';
import 'package:soltion_center/controllers/question_controller.dart';
import 'package:soltion_center/models/answer_model.dart';
import 'package:soltion_center/models/question_model.dart';
import 'package:soltion_center/services/auth_service.dart';
import 'package:soltion_center/units/text_field_theme.dart';

class AddAnswerScreen extends StatefulWidget {
  const AddAnswerScreen({Key? key, required this.question}) : super(key: key);
  final QuestionModel question;

  @override
  State<AddAnswerScreen> createState() => _AddAnswerScreenState();
}

class _AddAnswerScreenState extends State<AddAnswerScreen> {
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final info = MediaQuery.of(context);
    final questionProvider = Provider.of<QuestionController>(context);
    final lang = Provider.of<LocalizationController>(context).getLanguage();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: theme.colorScheme.background,
      appBar: AppBar(
        backgroundColor: theme.colorScheme.surfaceVariant,
        title: Text(
          lang.addNewAnswer!,
          style: theme.textTheme.titleLarge,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: formKey,
          autovalidateMode: AutovalidateMode.always,
          onChanged: () {
            Form.of(primaryFocus!.context!).save();
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                lang.answerInformation!,
                style: theme.textTheme.titleMedium,
              ),
              const SizedBox(
                height: 24,
              ),
              TextFormField(
                keyboardType: TextInputType.text,
                controller: questionProvider.answerTitleController,
                style: theme.textTheme.bodyLarge,
                cursorColor: theme.colorScheme.onBackground,
                autocorrect: false,
                validator: (value) {
                  if (value!.isEmpty) {
                    return lang.pleaseEnterYourAnswerTitle;
                  } else {
                    return null;
                  }
                },
                decoration: textFormFieldDecoration(
                  label: lang.title,
                  hint: lang.pleaseEnterYourAnswerTitle,
                  context: context,
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              TextFormField(
                keyboardType: TextInputType.text,
                controller: questionProvider.answerDetailsController,
                maxLines: 4,
                minLines: 1,
                style: theme.textTheme.bodyLarge,
                cursorColor: theme.colorScheme.onBackground,
                autocorrect: false,
                validator: (value) {
                  if (value!.isEmpty) {
                    return lang.pleaseEnterYourAnswerDescription;
                  } else {
                    return null;
                  }
                },
                decoration: textFormFieldDecoration(
                  label: lang.details,
                  hint: lang.pleaseEnterYourAnswerDescription,
                  context: context,
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              const Spacer(),
              SizedBox(
                width: info.size.width,
                child: ElevatedButton(
                  style: TextButton.styleFrom(
                    foregroundColor: theme.colorScheme.onPrimary, padding: const EdgeInsets.all(16.0),
                    elevation: 1,
                    backgroundColor: theme.colorScheme.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  onPressed: () async {
                    if (questionProvider
                        .answerTitleController.text.isNotEmpty &&
                        questionProvider
                            .answerDetailsController.text.isNotEmpty) {
                      AnswerModel newAnswer = AnswerModel(
                        answerCounter: 0,
                        userId: AuthService().getUser()!.uid,
                        createdAt: '${DateTime.now()}',
                        questionId: widget.question.sId,
                        updatedAt: '${DateTime.now()}',
                        answerDescription:
                        questionProvider.answerDetailsController.text,
                        answerTitle:
                        questionProvider.answerTitleController.text,
                      );
                      await questionProvider.addQuestionAnswer(
                        widget.question,
                        newAnswer,
                      );

                      Navigator.pop(context);
                    } else {
                      final snackBar = SnackBar(
                        content: Text(
                          lang.pleaseFillTheFields!,
                          style:
                          theme.textTheme.bodyLarge!.copyWith(
                            color: theme.colorScheme.background,
                          ),
                        ),
                      );

                      // Find the ScaffoldMessenger in the widget tree
                      // and use it to show a SnackBar.
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }
                  },
                  child: Text(
                    lang.save!,
                    style: theme.textTheme

                        .titleSmall!
                        .copyWith(color: theme.colorScheme.onPrimary),
                  ),
                ),
              ),
              const SizedBox(
                height: 24,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
