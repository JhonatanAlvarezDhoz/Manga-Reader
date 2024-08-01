import 'package:flutter/material.dart';
import 'package:manga_reader/base/widgets/custom_bottom_navigation_bar/custom_bottom_navigation_bar.dart';
import 'package:manga_reader/modules/home/ui/page/home.dart';
import 'package:manga_reader/modules/search/ui/page/search_page.dart';
import 'package:manga_reader/modules/settings/ui/page/settings_page.dart';

class BasePage extends StatefulWidget {
  const BasePage({super.key});

  @override
  _BasePageState createState() => _BasePageState();
}

class _BasePageState extends State<BasePage> {
  int _currentIndex = 0;
  final PageController _pageController = PageController();

  void _onPageChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  void _onTabTapped(int index) {
    _pageController.jumpToPage(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: _onPageChanged,
        children: const [
          HomePage(),
          SearchPage(),
          SettingsPage(),
        ],
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: _currentIndex,
        onChange: _onTabTapped,
      ),
    );
  }
}
