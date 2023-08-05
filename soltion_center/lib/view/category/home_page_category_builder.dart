
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soltion_center/controllers/category_controller.dart';
import 'package:soltion_center/controllers/localization_controller.dart';
import 'package:soltion_center/controllers/question_controller.dart';
import 'package:soltion_center/models/category_model.dart';

class HomeCategoryBuilder extends StatelessWidget {
  const HomeCategoryBuilder({Key? key})
      : super(key: key);


  @override
  Widget build(BuildContext context) {
    final categoryProvider = Provider.of<CategoryController>(context);
    final questionProvider = Provider.of<QuestionController>(context);
    final lang = Provider.of<LocalizationController>(context).getLanguage();
    final info = MediaQuery.of(context);
    final theme = Theme.of(context);
    return SizedBox(
        height: info.size.height* 0.09,
        width: info.size.width,
        child: FutureBuilder<List<CategoryModel>>(
            future: categoryProvider.getCategoryOfUser(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data!.isNotEmpty) {
                  List<CategoryModel> categoryData = snapshot.data!;
                  return ListView.builder(
                    itemCount: categoryData.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                          style: TextButton.styleFrom(
                            backgroundColor: questionProvider.checkSelectedCategory(
                                questionProvider.selectedCategory,
                                categoryData[index])
                                ? theme
                                .colorScheme.secondaryContainer
                                : theme.colorScheme.background,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                          onPressed: () {
                            questionProvider.updateSelectedCategoryList(
                                categoryData[index]);
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              if (questionProvider.checkSelectedCategory(
                                  questionProvider.selectedCategory,
                                  categoryData[index]))
                                Icon(
                                  Icons.done,
                                  color: theme.colorScheme.onSecondaryContainer,
                                ),
                              if (questionProvider.checkSelectedCategory(
                                  questionProvider.selectedCategory,
                                  categoryData[index]))
                                const SizedBox(
                                  width: 8,
                                ),
                              Text(
                                '${categoryData[index].categoryName}',
                                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                  color:
                                  theme.colorScheme.onBackground,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                } else if (snapshot.data!.isEmpty){
                  return Center(
                    child: Text(
                      lang.noDataRecorded!,
                      style: theme.textTheme.bodyLarge,
                    ),
                  );
                }else{
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      style: TextButton.styleFrom(
                        backgroundColor: theme.colorScheme.tertiary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, '/Profile/Category');
                      },
                      child: Text(
                        lang.addCategory!,
                        style: Theme.of(context).textTheme.button!.copyWith(
                          color: theme.colorScheme.onTertiary,
                        ),
                      ),
                    ),
                  );
                }
              } else {
                return const Center(
                  child: LinearProgressIndicator(),
                );
              }
            }));
  }
}
