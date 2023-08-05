part of 'home_page.dart';
class HomePageBody extends StatefulWidget {
  const HomePageBody({Key? key}) : super(key: key);

  @override
  _HomePageBodyState createState() => _HomePageBodyState();
}

class _HomePageBodyState extends State<HomePageBody> {
  bool showAllCategories = false; // Tüm kategoriler gösteriliyor mu

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final categoryProvider = Provider.of<CategoryController>(context);
    final questionController = Provider.of<QuestionController>(context);
    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceVariant,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
      ),
      child:  Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const HomeCategoryBuilder(),
    Expanded(
        flex: 4,
        child: QuestionCardListBuilder(categoriesFilter: questionController.selectedCategory,),
    ),
          ],
        ),
      ),
    );
  }
}

