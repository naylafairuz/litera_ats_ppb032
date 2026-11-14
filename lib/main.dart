import 'package:flutter/material.dart';
import 'pages/splash_page.dart';
import 'widgets/common.dart';

void main() => runApp(const LiteraApp());

class LiteraApp extends StatelessWidget {
  const LiteraApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Litera',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: kMaroon),
        scaffoldBackgroundColor: kBg,
        appBarTheme: const AppBarTheme(
          backgroundColor: kBg,
          foregroundColor: kMaroon,
          elevation: 0,
          titleTextStyle: TextStyle(
              color: kMaroon, fontSize: 22, fontWeight: FontWeight.bold),
        ),
        cardTheme: const CardThemeData(color: Colors.white, elevation: 0),
      ),
      home: const SplashPage(),
    );
  }
}