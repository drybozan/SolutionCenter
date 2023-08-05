import 'package:flutter/material.dart';
import 'package:soltion_center/models/question_model.dart';

import 'widget/questionCategories.dart';
import 'widget/question_details_button.dart';
import 'widget/question_detils.dart';
import 'widget/question_header.dart';
import 'widget/states.dart';

class QuestionCard extends StatelessWidget {
  const QuestionCard({Key? key, required this.question}) : super(key: key);
  final QuestionModel question;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                //TODO change the input
                QuestionStateIcon(question: question),
                const SizedBox(
                  width: 16,
                ),
                Expanded(
                  flex: 1,
                  child: QuestionHeader(
                    question: question,
                  ),
                ),
              ],
            ),
            space(),
            //TODO change the input to categoryList
            QuestionCategoryBuilder(
              question: question,
            ),
            space(),

            //TODO change input to only string
            QuestionDetails(
              question: question,
            ),
            space(),
            Align(
                alignment: Alignment.bottomRight,
                //TODO change input (need to plan)
                child: QuestionDetailsButton(
                  question: question,
                )),
          ],
        ),
      ),
    );
  }

  space() => const SizedBox(
    height: 16,
  );
}
