import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:soltion_center/controllers/question_controller.dart';
import 'package:soltion_center/controllers/user_controller.dart';

import 'app.dart';
import 'controllers/category_controller.dart';
import 'controllers/connection_controller.dart';
import 'controllers/localization_controller.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  if (kIsWeb) {
    await FirebaseAuth.instance.setPersistence(Persistence.LOCAL);
    // web is not supported in path provider
    await Hive.initFlutter();
  } else {
    final Directory dir = await getApplicationDocumentsDirectory();
    await Hive.initFlutter(dir.path);
  }
  await Hive.openBox('theme');
  await Hive.openBox('language');
  if (kReleaseMode) {
    debugPrint = (String? message, {int? wrapWidth}) {};
  }
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => LocalizationController()),
        ChangeNotifierProvider(create: (context) => ConnectionController()),
        ChangeNotifierProvider(create: (context) => UserController()),
        ChangeNotifierProvider(create: (context) => CategoryController()),
        ChangeNotifierProvider(create: (context) => QuestionController()),

      ],
      child: MyApp(),
    ),
  );
}

