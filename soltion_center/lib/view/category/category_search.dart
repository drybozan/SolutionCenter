part of 'category_search_page.dart';

class CategorySearch extends StatefulWidget {
  const CategorySearch({Key? key, required this.theme,required this.lang}) : super(key: key);

  static const routeName = '/';

  final ThemeData theme;
  final Localization lang;

  @override
  State<CategorySearch> createState() => _CategorySearchState();
}

class _CategorySearchState extends State<CategorySearch> {
  //late List<CategoryModel> searchList;
  List<CategoryModel> findedList = [];
  late int listLength;

  bool notFind = false;

  @override
  void initState() {
    super.initState();
    //searchList = context.read<categoryController
    //>().getAllCategories();
    listLength = findedList.isEmpty ? 1 : findedList.length;
  }

  Widget addItem(int index) {
    return Card(
      color: widget.theme.colorScheme.primary,
      child: ListTile(
        leading: Icon(
          Icons.add,
          color: widget.theme.colorScheme.onPrimary,
        ),
        title: Text(
          widget.lang.addCategory!,
          style: widget.theme.textTheme.bodyMedium!.copyWith(
            color: widget.theme.colorScheme.onPrimary,
          ),
        ),
        onTap: () {
          String title =
              context.read<CategoryController>().categoryNameController.text;

          Provider.of<CategoryController>(
            context,
            listen: false,
          ).addCategory(
            CategoryModel(
                categoryId: title.toLowerCase().trim(),
                categoryName: title
            ),
          );

          Provider.of<CategoryController>(
            context,
            listen: false,
          ).addCategoryToUser(
            CategoryModel(
                categoryId: title.toLowerCase().trim(),
                categoryName: title),
          );

          setState(() {
            notFind = false;
            context.read<CategoryController>().categoryNameController.clear();
            findedList.clear();
          });
        },
      ),
    );
  }

  Widget body(CategoryModel category, BuildContext context) {
    final categoryController = Provider.of<CategoryController>(context);

    if (findedList.isNotEmpty) {
      notFind = true;
      return Card(
        color: widget.theme.colorScheme.secondaryContainer,
        child: ListTile(
          title: Text(
            category.categoryName!,
            style: widget.theme.textTheme.bodyMedium,
          ),
          onTap: () {
            categoryController.addCategoryToUser(category);
            setState(() {
              notFind = false;
              context.read<CategoryController>().categoryNameController.clear();
              findedList.clear();
            });
          },
        ),
      );
    } else {
      return const SizedBox();
    }
  }

  @override
  Widget build(BuildContext context) {
    final categoryController = Provider.of<CategoryController>(context);
    final theme = Theme.of(context);
    return Column(
      children: [
        TextField(
          style: theme.textTheme.bodyLarge,
          onSubmitted: (value) {
            if (findedList.length == 1) {}
            findedList.clear();
            categoryController.categoryNameController.text = '';
          },
          onChanged: (value) async {
            findedList.clear();
            var userCategory = await categoryController.getAllCategories();

            userCategory.forEach((element) {
              print(element.categoryName);
            });

            if (value != '') {
              for (int i = 0; i < userCategory.length; i++) {
                if (userCategory[i].categoryName!.toLowerCase().contains(
                    categoryController.categoryNameController.text
                        .toLowerCase())) {
                  // if (categoryController
                  //.categorySearchController.text.isEmpty) {
                  //   return findedList.clear();
                  // }

                  setState(() {
                    if (!findedList.contains(userCategory[i])) {
                      //findedList.clear();
                      findedList.add(userCategory[i]);
                    }
                  });
                } else {
                  setState(() {
                    notFind = true;
                  });
                }
              }
            } else {
              setState(() {
                notFind = false;
                findedList.clear();
              });
            }
          },
          controller: categoryController.categoryNameController,
          decoration: InputDecoration(
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: findedList.isEmpty && notFind == true
                    ? theme.colorScheme.error
                    : theme.colorScheme.outline,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: theme.colorScheme.error,
              ),
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(
                color: theme.colorScheme.outline,
              ),
            ),

            //labelText: 'Category',
            labelStyle: theme.textTheme.bodyLarge,
            hintText: widget.lang.searchForCategory,
            hintStyle: theme.textTheme.bodyLarge,
          ),
        ),
        if (findedList.isNotEmpty || notFind == true)
          Expanded(
            child: ListView.builder(
              itemCount: findedList.isEmpty ? 1 : findedList.length,
              itemBuilder: (context, index) {
                return Material(
                  color: theme.colorScheme.surfaceVariant,
                  child: Column(
                    children: [
                      if (findedList.isNotEmpty)
                        body(findedList[index], context),
                      if (findedList.isEmpty && notFind == true) addItem(index),
                    ],
                  ),
                );
              },
            ),
          ),
      ],
    );
  }
}
//

