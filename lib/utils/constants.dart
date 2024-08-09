import 'package:flutter/material.dart';
import 'package:manga_reader/localization/languageManager.dart';

class IconNavBottomBar {
  IconData icon;
  String? title;
  Color? color;

  IconNavBottomBar({required this.icon, this.title, this.color});
}

List<IconNavBottomBar> iconNavBottomBar = [
  IconNavBottomBar(
    icon: Icons.home,
    title: LanguageManager().translate().home,
  ),
  IconNavBottomBar(
    icon: Icons.search,
    title: LanguageManager().translate().search,
  ),
  IconNavBottomBar(
    icon: Icons.settings,
    title: LanguageManager().translate().settings,
  )
];
