import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:main_app/components/customNav.dart';
import 'package:main_app/firebase_options.dart';
import 'package:main_app/providers/recipe_provider.dart';
import 'package:main_app/screens/homePage.dart';
import 'package:main_app/screens/searchPage.dart';
import 'package:main_app/themes/customTheme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: ((context) => RecipeProvider())),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  final String appTitle = "Sangkap Snap App";

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appTitle,
      theme: customTheme,
      home: const CustomNav(),
      routes: {
        SearchPage.routename: (context) => SearchPage(),
        HomePage.routename: (context) => HomePage(),
      },
    );
  }
}
