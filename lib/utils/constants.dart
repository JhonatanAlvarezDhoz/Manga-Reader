import 'package:flutter/material.dart';
import 'package:manga_reader/localization/languageManager.dart';

class IconNavBottomBar {
  String iconString;
  String? title;
  Color? color;

  IconNavBottomBar(
      {required this.iconString, this.title, this.color, required});
}

List<IconNavBottomBar> iconNavBottomBar = [
  IconNavBottomBar(
    iconString: "assets/icons/home.svg",
    title: LanguageManager().translate().home,
  ),
  IconNavBottomBar(
    iconString: "assets/icons/download.svg",
    title: LanguageManager().translate().download,
  ),
  IconNavBottomBar(
    iconString: "assets/icons/settings.svg",
    title: LanguageManager().translate().settings,
  )
];
