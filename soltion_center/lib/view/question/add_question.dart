import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soltion_center/controllers/category_controller.dart';
import 'package:soltion_center/controllers/localization_controller.dart';
import 'package:soltion_center/controllers/question_controller.dart';
import 'package:soltion_center/models/category_model.dart';
import 'package:soltion_center/models/question_model.dart';
import 'package:soltion_center/services/auth_service.dart';
import 'package:soltion_center/units/text_field_theme.dart';
import 'package:soltion_center/view/category/category_search_page.dart';

class AddQuestionScreen extends StatefulWidget {
  const AddQuestionScreen({Key? key}) : super(key: key);

  @override
  State<AddQuestionScreen> createState() => _AddQuestionScreenState();
}

class _AddQuestionScreenState extends State<AddQuestionScreen> {
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final info = MediaQuery.of(context);
    final questionProvider = Provider.of<QuestionController>(context);
    final categoryProvider = Provider.of<CategoryController>(context);
    final lang = Provider.of<LocalizationController>(context).getLanguage();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: theme.colorScheme.background,
      appBar: AppBar(
        backgroundColor: theme.colorScheme.surfaceVariant,
        title: Text(
          lang.addNewQuestion!,
          style: theme.textTheme.titleLarge,
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios,),
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: formKey,
          autovalidateMode: AutovalidateMode.always,
          onChanged: () {
            Form.of(primaryFocus!.context!)!.save();
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                lang.questionInformation!,
                style: theme.textTheme.titleMedium,
              ),
              const SizedBox(
                height: 24,
              ),
              TextFormField(
                keyboardType: TextInputType.text,
                controller: questionProvider.questionTitleController,
                style: theme.textTheme.bodyLarge,
                cursorColor: theme.colorScheme.onBackground,
                autocorrect: false,
                validator: (value) {
                  if (value!.isEmpty) {
                    return lang.pleaseEnterText;
                  } else {
                    return null;
                  }
                },
                decoration: textFormFieldDecoration(
                  label: lang.title,
                  hint: lang.pleaseEnterYourQuestionTitle!,
                  context: context,
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              TextFormField(
                keyboardType: TextInputType.text,
                controller: questionProvider.questionDetailsController,
                maxLines: 4,
                minLines: 1,
                style: theme.textTheme.bodyLarge,
                cursorColor: theme.colorScheme.onBackground,
                autocorrect: false,
                validator: (value) {
                  if (value!.isEmpty) {
                    return lang.pleaseEnterText;
                  } else {
                    return null;
                  }
                },
                decoration: textFormFieldDecoration(
                  label: lang.details,
                  hint: lang.pleaseEnterYourQuestionDetails,
                  context: context,
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              SizedBox(
                width: info.size.width,
                child: ElevatedButton(
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.all(16.0),
                    primary: theme.colorScheme.onPrimary,
                    elevation: 1,
                    backgroundColor:
                    theme.colorScheme.secondaryContainer,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  onPressed: () => showDialog<void>(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      scrollable: true,
                      backgroundColor: theme.colorScheme.background,
                      title: Center(
                        child: Column(
                          children: [
                            Text(
                              lang.selectCategory!,
                              textAlign: TextAlign.center,
                              style: theme.textTheme.headlineSmall,
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Text(
                              lang.selectCategoryDescription!,
                              textAlign: TextAlign.center,
                              style: theme.textTheme.titleSmall,
                            ),
                          ],
                        ),
                      ),
                      content: FutureBuilder<List<CategoryModel>?>(
                          future: categoryProvider.getAllCategories(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              if (snapshot.data!.isNotEmpty) {
                                return Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    for (int index = 0;
                                    index < snapshot.data!.length;
                                    index++)
                                      Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          ListTile(
                                            title: Text(
                                              '${snapshot.data![index].categoryName}',
                                              style: theme.textTheme

                                                  .bodyMedium,
                                            ),
                                            // subtitle: Text(
                                            //   '${categoryProvider.getAllCategories()[index].categoryDetails}',
                                            //   style: theme.textTheme.bodySmall,
                                            // ),
                                            trailing: questionProvider
                                                .checkSelectedCategory(
                                                questionProvider
                                                    .newQuestionSelectedCategory,
                                                snapshot.data![index])
                                                ? CircleAvatar(
                                              backgroundColor:
                                              Colors.transparent,
                                              child: Icon(
                                                Icons.clear,
                                                color: theme.colorScheme
                                                    .onBackground,
                                              ),
                                            )
                                                : CircleAvatar(
                                              backgroundColor:
                                              Colors.transparent,
                                              child: Icon(
                                                Icons.add,
                                                color: theme.colorScheme
                                                    .onBackground,
                                              ),
                                            ),
                                            onTap: () {
                                              questionProvider
                                                  .updateNewQuestionSelectedCategory(
                                                  snapshot.data![index]);
                                              Navigator.pop(context);
                                            },
                                          ),
                                          Divider(
                                            color:
                                            theme.colorScheme.onBackground,
                                            endIndent: 12,
                                            indent: 12,
                                          ),
                                        ],
                                      ),
                                    TextButton(
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                const CategoryScreen()),
                                          );
                                        },
                                        child:
                                         Text(lang.addCategory!)),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width,
                                      child: ElevatedButton(
                                        style: TextButton.styleFrom(
                                          primary:
                                          theme.colorScheme.onPrimary,
                                          onSurface:
                                          theme.colorScheme.onBackground,
                                          //padding: const EdgeInsets.all(16.0),
                                          backgroundColor:
                                          theme.colorScheme.primary,
                                          // shape: RoundedRectangleBorder(
                                          //   borderRadius: BorderRadius.circular(8.0),
                                          // ),
                                        ),
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text(
                                          lang.cancel!,
                                          style: theme.textTheme

                                              .bodyMedium!
                                              .copyWith(
                                              color: theme.colorScheme
                                                  .onPrimary),
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              } else {
                                return Center(
                                  child: Text(
                                    lang.error!,
                                    style:
                                    theme.textTheme.bodyLarge,
                                  ),
                                );
                              }
                            } else {
                              return const Center(
                                child: LinearProgressIndicator(),
                              );
                            }
                          }),

                      //actionsOverflowButtonSpacing: 4,

                      alignment: Alignment.center,
                    ),
                  ),
                  child: Text(
                    lang.addCategory!,
                    style: theme.textTheme.titleSmall!.copyWith(
                      color: theme.colorScheme.onSecondaryContainer,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              Wrap(
                runSpacing: 16,
                spacing: 16,
                children: [
                  for (int i = 0;
                  i < questionProvider.newQuestionSelectedCategory.length;
                  i++)
                    Padding(
                      padding: const EdgeInsets.all(0.0),
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.background,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: theme.colorScheme.outline!,
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              '${questionProvider.newQuestionSelectedCategory[i].categoryName}',
                              style:
                              Theme.of(context).textTheme.button!.copyWith(
                                color: theme.colorScheme.onBackground,
                              ),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            GestureDetector(
                              onTap: () {
                                questionProvider.updateNewQuestionSelectedCategory(questionProvider.newQuestionSelectedCategory[i]);
                              },
                              child: Icon(
                                Icons.clear,
                                color: theme.colorScheme.onBackground,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
              const Spacer(),
              SizedBox(
                width: info.size.width,
                child: ElevatedButton(
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.all(16.0),
                    primary: theme.colorScheme.onPrimary,
                    elevation: 1,
                    backgroundColor: theme.colorScheme.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  onPressed: () {
                    if (questionProvider
                        .questionDetailsController.text.isNotEmpty &&
                        questionProvider
                            .questionTitleController.text.isNotEmpty &&
                        questionProvider
                            .newQuestionSelectedCategory.isNotEmpty) {
                      List<String> _categoryList = [];
                      for (CategoryModel cat
                      in questionProvider.newQuestionSelectedCategory) {
                        _categoryList.add(cat.categoryId!);
                      }
                      QuestionModel newQuestion = QuestionModel(
                        createdAt: '${DateTime.now()}',
                        updatedAt: '${DateTime.now()}',
                        questionState: 'not_solved',
                        userCounter: 0,
                        userList: [
                          AuthService().getUser()!.uid,
                        ],
                        questionCategory: _categoryList,
                        questionTitle:
                        questionProvider.questionTitleController.text,
                        questionDetails:
                        questionProvider.questionDetailsController.text,
                      );

                      //questionProvider.updateQuesitonToUser(newQuestion);
                      questionProvider.addQuestion(
                        newQuestion,
                      );
                      questionProvider.answerTitleController.clear();
                      questionProvider.answerDetailsController.clear();
                      Navigator.pop(context);
                    }
                  },
                  child: Text(
                    lang.save!,
                    style: theme.textTheme

                        .titleSmall!
                        .copyWith(color: theme.colorScheme.onPrimary),
                  ),
                ),
              ),
              const SizedBox(
                height: 24,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
