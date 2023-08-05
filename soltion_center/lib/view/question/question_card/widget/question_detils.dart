

import 'package:flutter/material.dart';
import 'package:soltion_center/models/question_model.dart';

class QuestionDetails extends StatelessWidget {
  const QuestionDetails({Key? key, required this.question}) : super(key: key);
  final QuestionModel question;
  @override
  Widget build(BuildContext context) {
    return Text(
      '${question.questionDetails}',
      style:Theme.of(context).textTheme.bodyMedium,
    );
  }
}
