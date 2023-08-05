part of 'profile.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {

    final theme = Theme.of(context);
    final userProvider = Provider.of<UserController>(context);
    return  Column(
      children: [
        CustomPaint(
          size: Size(200, (200 * 1).toDouble()),
          painter: AppLogo(),
        ),

        FutureBuilder<UserModel?>(
            future: userProvider.getUserInfo(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {

                final UserModel user = snapshot.data!;
                return Text(user.username!, style: theme.textTheme.titleLarge);
              }else {
                return Text('User Name', style: theme.textTheme.titleLarge);
              }
            }),
      ],
    );
  }
}
/*
final userProvider = Provider.of<UserController>(context);

    final theme = Theme.of(context);
    return Column(
      children: [
        CustomPaint(
          size: Size(200, (200 * 1).toDouble()),
          painter: AppLogo(),
        ),
        FutureBuilder<UserModel?>(
            future: userProvider.currentUser(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {

                final UserModel user = snapshot.data!;
                Text(user.username!, style: theme.textTheme.titleLarge);
              }
            }),
      ],
    );
 */