import 'package:flutter/material.dart';
import 'package:main_app/components/customNav.dart';
import 'package:main_app/screens/homePage.dart';
import 'package:main_app/screens/searchPage.dart';
import 'package:main_app/themes/customTheme.dart';

void main() {
  runApp(const MyApp());
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
