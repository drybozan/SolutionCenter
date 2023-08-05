import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soltion_center/controllers/category_controller.dart';
import 'package:soltion_center/controllers/localization_controller.dart';
import 'package:soltion_center/controllers/question_controller.dart';
import 'package:soltion_center/models/question_model.dart';
import 'package:soltion_center/view/question/question_card/question_card.dart';

class SearchQuestionBuilder extends StatelessWidget {
  const SearchQuestionBuilder({
    Key? key,
    required this.questions,
  }) : super(key: key);
  final List<QuestionModel>? questions;

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final questionController = Provider.of<QuestionController>(context);
    //final categoryController = Provider.of<CategoryController>(context);
    final lang = Provider.of<LocalizationController>(context).getLanguage();
    if (questions!.isNotEmpty) {
      List<QuestionModel>? _list = [];
      if (questionController.selectedCategory.isNotEmpty) {
        for (var question in questions!) {
          for (var questionCategory in question.questionCategory!) {
            for (var category in questionController.selectedCategory) {
              if (questionCategory
                  .toLowerCase()
                  .contains(category.categoryName!.toLowerCase())) {
                _list.add(question);
              }
            }
          }
        }
        return buildListView(context, _list);
      } else {
        return buildListView(context, questions!);
      }
    } else {
      //return there is nothing founded
      return Center(
        child: Text(
          lang.thereIsNothingFounded!,
          style: themeData
              .textTheme
              .titleLarge,
        ),
      );
    }
  }

  ListView buildListView(BuildContext context, List<QuestionModel> _list) {
    return ListView.builder(
      shrinkWrap: true,
      controller: context.read<QuestionController>().scrollController,
      itemCount: _list.length,
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.only(
          bottom: 16,
        ),
        child: QuestionCard(
          question: _list[index],
        ),
      ),
    );
  }
}
