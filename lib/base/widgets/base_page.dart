import 'package:flutter/material.dart';
import 'package:manga_reader/base/widgets/custom_bottom_navigation_bar/custom_bottom_navigation_bar.dart';
import 'package:manga_reader/base/widgets/custom_text.dart';
import 'package:manga_reader/modules/home/ui/page/home.dart';
import 'package:manga_reader/modules/search/ui/page/search_page.dart';
import 'package:manga_reader/modules/settings/ui/page/settings_page.dart';
import 'package:manga_reader/utils/responsive.dart';

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
    final Responsive responsive = Responsive.of(context);
    return Scaffold(
      body: SizedBox(
        height: responsive.heightResponsive(100),
        width: responsive.widthResponsive(100),
        child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
          return Column(children: [
            TopBar(size: constraints),
            Container(
              color: Colors.red,
              height: constraints.maxHeight * 0.845,
              width: constraints.maxWidth,
              child: PageView(
                physics: const NeverScrollableScrollPhysics(),
                controller: _pageController,
                onPageChanged: _onPageChanged,
                children: const [
                  HomePage(),
                  SearchPage(),
                  SettingsPage(),
                ],
              ),
            ),
          ]);
        }),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: _currentIndex,
        onChange: _onTabTapped,
      ),
    );
  }
}

class TopBar extends StatelessWidget {
  const TopBar({
    super.key,
    required this.size,
  });

  final BoxConstraints size;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        height: size.maxHeight * 0.077,
        width: size.maxWidth,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/icons/manga.png"),
            Container(
              margin: const EdgeInsets.only(left: 15),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomText(
                    text: "Manga",
                    height: 1,
                    fontWeight: FontWeight.w600,
                  ),
                  CustomText(
                    text: "Reader",
                    fontWeight: FontWeight.w600,
                    height: 1,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
