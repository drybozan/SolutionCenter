

import 'package:flutter/material.dart';
import 'package:soltion_center/models/question_model.dart';

class QuestionHeader extends StatelessWidget {
  const QuestionHeader({Key? key, required this.question}) : super(key: key);
  final QuestionModel question;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${question.questionTitle}',
          style: theme.textTheme
              .titleMedium,
        ),
        Text(
          question.updatedAt!.split('T').first,
          style: theme.textTheme.bodyMedium,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          softWrap: true,
        )
      ],
    );
  }
}
