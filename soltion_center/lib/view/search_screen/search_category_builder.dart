import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soltion_center/controllers/category_controller.dart';
import 'package:soltion_center/controllers/localization_controller.dart';
import 'package:soltion_center/controllers/question_controller.dart';
import 'package:soltion_center/models/category_model.dart';

class SearchCategoryBuilder extends StatefulWidget {
  const SearchCategoryBuilder({
    Key? key,
  }) : super(key: key);
  @override
  State<SearchCategoryBuilder> createState() => _SearchCategoryBuilderState();
}

class _SearchCategoryBuilderState extends State<SearchCategoryBuilder> {
  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final questionController = Provider.of<QuestionController>(context);
    final categoryController = Provider.of<CategoryController>(context);
    final lang = Provider.of<LocalizationController>(context).getLanguage();
    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          lang.yourCategories!,
          style: themeData.textTheme.titleMedium,
        ),
        const SizedBox(
          height: 16,
        ),
        FutureBuilder<List<CategoryModel>>(
            future: categoryController.getCategoryOfUser(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data!.isNotEmpty) {
                  return Wrap(
                    runSpacing: 16,
                    spacing: 16,
                    children: [
                      for (int i = 0; i < snapshot.data!.length; i++)
                        Padding(
                          padding: const EdgeInsets.all(0.0),
                          child: ElevatedButton(
                            style: TextButton.styleFrom(
                              primary: themeData.colorScheme.onBackground,
                              onSurface: themeData.colorScheme.onBackground,
                              //padding: const EdgeInsets.all(16.0),
                              backgroundColor:
                              questionController.checkSelectedCategory(
                                  questionController.selectedCategory,
                                  snapshot.data![i])
                                  ? themeData.colorScheme
                                  .secondaryContainer
                                  : themeData.colorScheme.background,
                              elevation: questionController.selectedCategory
                                  .contains(snapshot.data![i])
                                  ? 4
                                  : 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                                side: BorderSide(
                                  color: questionController.checkSelectedCategory(
                                      questionController.selectedCategory,
                                      snapshot.data![i])
                                      ? Colors.transparent
                                      : themeData.colorScheme.outline,
                                ),
                              ),
                            ),
                            onPressed: () {
                              questionController.updateSelectedCategoryList(
                                  snapshot.data![i]);
                            },
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                if (questionController.checkSelectedCategory(
                                    questionController.selectedCategory,
                                    snapshot.data![i]))
                                  Icon(
                                    Icons.done,
                                    color: themeData.colorScheme
                                        .onSecondaryContainer,
                                  ),
                                Text(
                                  '${snapshot.data![i].categoryName}',
                                  style: themeData
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(
                                    color:
                                    themeData.colorScheme.onBackground,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                    ],
                  );
                } else {
                  return Center(
                    child: Text(
                      lang.loading!,
                      style: themeData.textTheme.bodyLarge,
                    ),
                  );
                }
              } else {
                return Center(
                  child: Text(
                    lang.error!,
                    style: themeData.textTheme.bodyLarge,
                  ),
                );
              }
            })
      ],
    );
  }
}
