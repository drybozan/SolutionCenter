import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soltion_center/controllers/localization_controller.dart';
import 'package:soltion_center/controllers/question_controller.dart';
import 'package:soltion_center/models/question_model.dart';

import 'question_card/question_card.dart';

class QuestionHistoryPage extends StatelessWidget {
  const QuestionHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final questionController = Provider.of<QuestionController>(context);
    final lang = Provider.of<LocalizationController>(context).getLanguage();
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios,),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(lang.questionHistory!),
      ),
      backgroundColor: theme.colorScheme.background,
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: FutureBuilder<List<QuestionModel>>(
            future: questionController.getUserQuestions(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data!.isNotEmpty) {
                  return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context,index){
                        return QuestionCard(question: snapshot.data![index],);
                      });
                } else if (snapshot.data!.isEmpty){
                  return Center(
                    child: Text(
                      lang.noDataRecorded!,
                      style: theme.textTheme.bodyLarge,
                    ),
                  );
                }else{
                  return Center(
                    child: Text(
                      lang.error!,
                      style: theme.textTheme.bodyLarge,
                    ),
                  );
                }
              } else {
                return const Center(
                  child: LinearProgressIndicator(),
                );
              }

            }
        ),
      ),
    );
  }
}
