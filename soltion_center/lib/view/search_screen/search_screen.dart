import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soltion_center/controllers/localization_controller.dart';
import 'package:soltion_center/controllers/question_controller.dart';
import 'package:soltion_center/models/category_model.dart';
import 'package:soltion_center/models/question_model.dart';
import 'package:soltion_center/view/search_screen/search_category_builder.dart';

import 'search_questions_builder.dart';

class SearchScreen extends StatelessWidget {
   SearchScreen({super.key});

  bool notFind = true;
  late List<QuestionModel> findQuestionList;
  late List<CategoryModel> selectedCategory;
  late List<CategoryModel> allCategories;

  @override
  Widget build(BuildContext context) {
    final lang = Provider.of<LocalizationController>(context, listen: true)
        .getLanguage();
    final questionController = Provider.of<QuestionController>(context, listen: true);
    final theme = Theme.of(context);
    final info = MediaQuery.of(context);
    return  Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        centerTitle: false,
        backgroundColor: theme.colorScheme.surfaceVariant,
        leading: IconButton(
          icon: const Icon(Icons.close,),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          IconButton(onPressed: (){
            Navigator.pushNamed(context, '/addQuestion');
          },
            icon: const Icon(Icons.add_comment_outlined),
            color: theme.colorScheme.secondary,)
        ],
        title:   Hero(
          tag: 'Search',
          child:Material(
            color: Colors.transparent,
            child: TextFormField(
              controller: questionController.questionSearchTextField,
              onChanged: (text) {
                // questionController.findQuestionList.clear();
                // questionProvider.search(text);
                // if (questionProvider.questionSearchController.text.isEmpty) {
                //   questionProvider.findQuestionList.clear();
                // }
              },
              style: theme.textTheme.bodyLarge,
              //autofocus: true,
              decoration: InputDecoration(
                hintText: lang.search,
                hintStyle: theme.textTheme.bodyLarge,
                fillColor: theme.colorScheme.onBackground!,
                enabled: true,
                // contentPadding: const EdgeInsets.symmetric(
                //     vertical: 20.0, horizontal: 20),
                // enabledBorder:  OutlineInputBorder(
                //   // borderSide: BorderSide(
                //   //     width: 3,
                //   //     color: theme.colorScheme.outline,
                //   // ),
                //   borderRadius: BorderRadius.circular(9.0),//<-- SEE HERE
                // ),
                enabledBorder:InputBorder.none,

                focusedBorder: InputBorder.none,
                disabledBorder: InputBorder.none,

              ),

            ),
          ),),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 24,vertical: 24,
        ),
        child: SizedBox(
          width: info.size.width,
          height: info.size.height,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
                SizedBox(
                  width: info.size.width,
                    child: const SearchCategoryBuilder(),),
              const SizedBox(
                height: 24,
              ),
              Divider(
                height: 0,
                thickness: 1,
                color: theme.colorScheme.onBackground,
              ),
              const SizedBox(
                height: 24,
              ),
              Expanded(
                child: FutureBuilder<List<QuestionModel>?>(
                    future: questionController.getAllQuestions(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        if (snapshot.data!.isNotEmpty) {
                          if (questionController.findQuestionList.isEmpty &&
                              questionController
                                  .questionSearchTextField.text.isEmpty) {
                            return SearchQuestionBuilder(
                              questions: snapshot.data!,
                            );
                          } else if (questionController
                              .findQuestionList.isEmpty &&
                              questionController
                                  .questionSearchTextField.text.isNotEmpty) {
                            return const SearchQuestionBuilder(questions: []);
                          } else {
                            return SearchQuestionBuilder(
                              questions: questionController.findQuestionList,
                            );
                          }
                        } else {
                          return Center(
                            child: Text(
                              lang.notFind!,
                              style: theme.textTheme.bodyLarge,
                            ),
                          );
                        }
                      } else {
                        return Center(
                          child: Text(
                            lang.loading!,
                            style: theme.textTheme.bodyLarge,
                          ),
                        );
                      }
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
