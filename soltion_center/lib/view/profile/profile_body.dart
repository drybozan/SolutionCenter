part of 'profile.dart';

class ProfileBody extends StatelessWidget {
  const ProfileBody({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    var profileList = ProfileModel().getProfileList(context);
    return Container(
      decoration:  BoxDecoration(
        color: theme.colorScheme.surfaceVariant,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        )
      ),
      child: ListView.builder(
          itemCount: profileList.length,
          shrinkWrap: true,
          itemBuilder: (context,index){
        return Padding(
          padding: const EdgeInsets.all(12.0),
          child: GestureDetector(
            onTap: (){
              profileList[index].onPressed!();
            },
            child: SizedBox(
              height: 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                     CircleAvatar(
                       backgroundColor: theme.colorScheme.primary,
                      child: Icon(
                        profileList[index].icon,
                        color: theme.colorScheme.onPrimary,
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: 12,),
                    Text('${profileList[index].name}',style: theme.textTheme.labelLarge!.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),)
                  ],
                ),),
          ),
        );
      }),
    );
  }
}
