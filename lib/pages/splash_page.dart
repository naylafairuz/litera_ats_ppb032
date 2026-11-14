import 'package:flutter/material.dart';
import '../widgets/common.dart';
import 'main_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 4), () {
      if (!mounted) return;
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => const MainPage()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Icon(Icons.menu_book, size: 80, color: kMaroon),
          Text('Litera',
              style: TextStyle(
                  fontSize: 36, fontWeight: FontWeight.bold, color: kMaroon)),
          Text('Review Your Book Here.', style: TextStyle(fontSize: 16)),
        ]),
      ),
    );
  }
}