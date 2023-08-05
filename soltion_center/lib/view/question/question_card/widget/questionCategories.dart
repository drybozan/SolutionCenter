
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soltion_center/controllers/localization_controller.dart';
import 'package:soltion_center/controllers/question_controller.dart';
import 'package:soltion_center/models/category_model.dart';
import 'package:soltion_center/models/question_model.dart';

class QuestionCategoryBuilder extends StatelessWidget {
  const QuestionCategoryBuilder({Key? key, required this.question})
      : super(key: key);
  final QuestionModel question;
  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final lang = Provider.of<LocalizationController>(context).getLanguage();
    return SizedBox(
        height: 40,
        //TODO add the categories of the question
        child: FutureBuilder<List<CategoryModel>?>(
          future: context
              .read<QuestionController>()
              .getAllCategoryOfQuestion(question.sId!),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data!.isNotEmpty) {
                return ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return Card(
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                              color: themeData.colorScheme.outline!, width: 1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          child: Text(
                            '${snapshot.data![index].categoryName}',
                            textAlign: TextAlign.center,
                            style: themeData.textTheme
                                .bodySmall,
                          ),
                        ),
                      );
                    });
              } else {
                return Card(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(color: Colors.black, width: 1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      //TODO update the text
                      'No category',
                      textAlign: TextAlign.center,
                      style: themeData.textTheme
                          .bodySmall,
                    ),
                  ),
                );
              }
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: LinearProgressIndicator());
            }else{
              return Card(
                elevation: 0,
                shape: RoundedRectangleBorder(
                  side: const BorderSide(color: Colors.black, width: 1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    lang.error!,
                    textAlign: TextAlign.center,
                    style: themeData.textTheme
                        .bodySmall,
                  ),
                ),
              );
            }
          },
        ));
  }
}
