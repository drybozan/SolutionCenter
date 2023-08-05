part of 'home_page.dart';

class HomePageHeader extends StatelessWidget {
  const HomePageHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final lang = Provider.of<LocalizationController>(context, listen: true)
        .getLanguage();

    return  Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24,vertical: 18,),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            lang.homePageTitle!,
            style: theme.textTheme.headlineSmall,
          ),
          const SizedBox(height: 8),
          Text(
            lang.homePageSubTitle!,
            style: theme.textTheme.titleSmall,
          ),
          const SizedBox(height: 24),
          GestureDetector(
            onTap: (){
              Navigator.pushNamed(context, '/Search');
            },
            child: Hero(
              tag: 'Search',
              child: Material(
                color: Colors.transparent,
                child: Container(
                  width: double.infinity,
                  height: 55,
                  decoration: BoxDecoration(
                    color: theme.colorScheme.background,
                    borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: theme.colorScheme.outline,
                      width: 2.5,)
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(width: 18,),
                      Icon(Icons.search, color: theme.colorScheme.outline),
                      const SizedBox(width: 8),
                      Text(
                        lang.search!,
                        style: theme.textTheme.titleSmall!.copyWith(
                          color: theme.colorScheme.outline,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
