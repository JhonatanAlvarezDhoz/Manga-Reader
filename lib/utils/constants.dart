import 'package:flutter/material.dart';

class IconNavBottomBar {
  IconData icon;
  String? title;
  Color? color;

  IconNavBottomBar({required this.icon, this.title, this.color});
}

List<IconNavBottomBar> iconNavBottomBar = [
  IconNavBottomBar(
    icon: Icons.home,
    title: "Home",
  ),
  IconNavBottomBar(
    icon: Icons.search,
    title: "Search",
  ),
  IconNavBottomBar(
    icon: Icons.settings,
    title: "settings",
  )
];
