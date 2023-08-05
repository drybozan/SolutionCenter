import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soltion_center/controllers/localization_controller.dart';
import 'package:soltion_center/controllers/question_controller.dart';
import 'package:soltion_center/models/answer_model.dart';

class AnswerCardBody extends StatelessWidget {
  const AnswerCardBody({Key? key, required this.answer})
      : super(key: key);
  final AnswerModel answer;


  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final questionProvider = Provider.of<QuestionController>(context);
    final lang = Provider.of<LocalizationController>(context).getLanguage();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${answer.answerTitle}',
          style: theme.textTheme.titleMedium,
        ),
        const SizedBox(
          height: 8,
        ),
        Text(
          '${answer.answerDescription}',
          style: theme.textTheme.titleSmall,
        ),
        const SizedBox(
          height: 8,
        ),
        Align(
          alignment: Alignment.centerRight,
          child: ElevatedButton(
              style: TextButton.styleFrom(
                primary: theme.colorScheme.onSecondaryContainer,
                onSurface: theme.colorScheme.onSecondaryContainer,
                //padding: const EdgeInsets.all(16.0),
                elevation: 0,
                backgroundColor: theme.colorScheme.secondaryContainer,
                // shape: RoundedRectangleBorder(
                //   borderRadius: BorderRadius.circular(8.0),
                // ),
              ),
              onPressed: () => showDialog<String>(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  backgroundColor: theme.colorScheme.background,
                  title: Center(
                    child: Text(
                      lang.voteForTheAnswer!,
                      style: theme.textTheme.headlineSmall,
                    ),
                  ),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        lang.voteForTheAnswerDescription!,
                        style: theme.textTheme.titleMedium,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            style: TextButton.styleFrom(
                              primary: theme.colorScheme.onPrimary,
                              onSurface: theme.colorScheme.onBackground,
                              //padding: const EdgeInsets.all(16.0),
                              backgroundColor:
                              theme.colorScheme.primary,
                              // shape: RoundedRectangleBorder(
                              //   borderRadius: BorderRadius.circular(8.0),
                              // ),
                            ),
                            onPressed: () async {
                              await questionProvider.updateAnswerCounter(
                                  answer.questionId!, answer.sId!, 1);
                              Navigator.pop(context);
                            },
                            child: Text(
                              lang.working!,
                              style: theme.textTheme

                                  .bodyMedium!
                                  .copyWith(
                                  color: theme
                                      .colorScheme.onPrimary),
                            ),
                          ),
                          const SizedBox(
                            width: 12,
                          ),
                          OutlinedButton(
                            onPressed: () async {
                              await questionProvider.updateAnswerCounter(
                                  answer.questionId!, answer.sId!, -1);
                              Navigator.pop(context);
                            },
                            child:  Text(
                              lang.notWorking!,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              child: Text(
                lang.vote!,
                style: theme.textTheme.titleSmall,
              )),
        ),
      ],
    );
  }
}
