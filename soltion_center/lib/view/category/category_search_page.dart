import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soltion_center/controllers/category_controller.dart';
import 'package:soltion_center/controllers/localization_controller.dart';
import 'package:soltion_center/localization/Localization.dart';
import 'package:soltion_center/models/category_model.dart';
part 'category_search.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final categoryProvider = Provider.of<CategoryController>(context);
    final ThemeData theme = Theme.of(context);

    final lang = Provider.of<LocalizationController>(context, listen: true)
        .getLanguage();
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios,),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          lang.category!,
          style: theme.textTheme.titleLarge,
        ),
      ),
      backgroundColor: theme.colorScheme.background,
      body: Container(
        decoration: BoxDecoration(
          color: theme.colorScheme.surfaceVariant,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Stack(
            children: [
              Column(
                children: [
                  const SizedBox(
                    height: 80,
                  ),
                  Divider(
                    color: theme.colorScheme.onBackground,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      lang.yourCategories!,
                      style: theme.textTheme.titleMedium,
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  FutureBuilder<List<CategoryModel>>(
                      future: categoryProvider.getCategoryOfUser(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          if (snapshot.data!.isNotEmpty) {
                            return Wrap(
                              // spacing: 16,
                              runSpacing: 16,
                              children: [
                                for (int i = 0; i < snapshot.data!.length; i++)
                                  Card(
                                    color: Colors.transparent,
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(
                                      side: const BorderSide(
                                          color: Colors.black, width: 1),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16, vertical: 8),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            '${snapshot.data![i].categoryName}',
                                            textAlign: TextAlign.center,
                                            style: theme.textTheme
                                                .bodySmall,
                                          ),
                                          const SizedBox(
                                            width: 8,
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              categoryProvider
                                                  .deleteCategoryFromUser(
                                                  snapshot.data!
                                                      .elementAt(i));
                                            },
                                            child: Icon(
                                              Icons.close,
                                              color: theme.colorScheme.onBackground,
                                              size: 18,
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
                                lang.searchForCategoryDes!,
                                style: theme.textTheme.bodyLarge,
                              ),
                            );
                          }
                        } else {
                          return const Center(
                            child: LinearProgressIndicator(),
                          );
                        }
                      }),
                ],
              ),
              FutureBuilder<List<CategoryModel>>(
                  future: categoryProvider.getAllCategories(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data!.isNotEmpty) {
                        return  CategorySearch(
                          theme: theme,
                          lang: lang,
                        );
                      } else {
                        return Center(
                          child: Text(
                            'Error!',
                            style: theme.textTheme.bodyLarge,
                          ),
                        );
                      }
                    } else {
                      return const Center(
                        child: LinearProgressIndicator(),
                      );
                    }
                  }),

            ],
          ),
        ),
      ),
    );
  }
}