import 'package:flutter/material.dart';
import 'package:project/screens/homePage.dart';
import 'package:project/screens/settingsPage.dart';
import 'package:project/screens/habitlListPage.dart';
import 'package:project/screens/splashScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: SplashScreen.routeName,
      routes: {
        SplashScreen.routeName: (_) => const SplashScreen(),
        Homepage.routeName: (_) => const Homepage(),
        SettingsPage.routeName: (_) => const SettingsPage(),
        HabbitListPage.routeName: (_) => const HabbitListPage(),
      },
      theme: ThemeData(
        appBarTheme: const AppBarTheme(foregroundColor: Colors.white),
      ),
    );
  }
}
