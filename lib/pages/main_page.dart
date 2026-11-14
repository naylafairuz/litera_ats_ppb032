import 'package:flutter/material.dart';
import 'home_page.dart';
import 'review_page.dart';

/// Kerangka dengan bottom navigation: Beranda & Review.
class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
          index: _index, children: const [HomePage(), ReviewPage()]),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index,
        onTap: (i) => setState(() => _index = i),
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined), label: 'Beranda'),
          BottomNavigationBarItem(
              icon: Icon(Icons.edit_note), label: 'Review'),
        ],
      ),
    );
  }
}