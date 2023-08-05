import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soltion_center/controllers/localization_controller.dart';
import 'package:soltion_center/controllers/question_controller.dart';
import 'package:soltion_center/models/category_model.dart';
import 'package:soltion_center/models/question_model.dart';

import 'question_card.dart';

class QuestionCardListBuilder extends StatelessWidget {
   const QuestionCardListBuilder({super.key,this.categoriesFilter});
  final List<CategoryModel>? categoriesFilter;

  @override
  Widget build(BuildContext context) {
    final questionController = Provider.of<QuestionController>(context);
    final lang = Provider.of<LocalizationController>(context).getLanguage();
    final theme = Theme.of(context);
    return FutureBuilder<List<QuestionModel>>(
        future: questionController.getQuestionsByCategoryForTheUser(categoriesFilter??[]),
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
    );
  }
}
