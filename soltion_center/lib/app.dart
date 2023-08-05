import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soltion_center/services/auth_service.dart';
import 'package:soltion_center/view/category/category_search_page.dart';
import 'package:soltion_center/view/homepage/home_page.dart';
import 'package:soltion_center/view/login/sign_in.dart';
import 'package:soltion_center/view/login/sign_up.dart';
import 'package:soltion_center/view/profile/profile.dart';

import 'controllers/connection_controller.dart';
import 'controllers/localization_controller.dart';

import 'view/over_screens/apply_for_each_page.dart';
import 'units/theme.dart';
import 'view/intro.dart';
import 'view/question/add_question.dart';
import 'view/question/question_history.dart';
import 'view/search_screen/search_screen.dart';

class MyApp extends StatelessWidget {
   MyApp({super.key});

  final AuthService _authService = AuthService();
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final connection = context.read<ConnectionController>();
    connection.getConnectivity.onConnectivityChanged
        .listen(connection.checkConnectivityState);
    return MaterialApp(
      title:  Provider.of<LocalizationController>(context, listen: false).getLanguage().appTitle!,
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: lightColorScheme,
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: darkColorScheme,
        brightness: Brightness.dark,
      ),
        initialRoute:  _authService.getCurrentUser() == null
            ? '/SignIn'
            : '/Home',

      routes: {
        '/intro': (context) => const ApplyForEachPage(
          child: IntroPage(),
        ),
        '/SignIn': (context) =>  ApplyForEachPage(
          child: SignIn(),
        ),
        '/SignUp': (context) =>  ApplyForEachPage(
          child: SignUp(),
        ),
        '/Profile': (context) => const ApplyForEachPage(
          child: Profile(),
        ),
        '/Home': (context) =>  const ApplyForEachPage(
          child: HomePage(),
        ),
        '/Profile/Category': (context) =>  const ApplyForEachPage(
          child: CategoryScreen(),
        ),
        '/Profile/History': (context) =>  const ApplyForEachPage(
          child: QuestionHistoryPage(),
        ),
        '/Search': (context) =>  ApplyForEachPage(
          child: SearchScreen(),
        ),
        '/addQuestion': (context) =>  const ApplyForEachPage(
          child: AddQuestionScreen(),
        ),

      },

    );
  }
}
