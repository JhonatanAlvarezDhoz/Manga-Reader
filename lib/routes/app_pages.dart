import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:manga_reader/base/ui/page/base_page.dart';
import 'package:manga_reader/base/ui/page/splash.dart';
import 'package:manga_reader/modules/home/ui/page/pages.dart';
import 'package:manga_reader/modules/search/ui/page/search_page.dart';
import 'package:manga_reader/modules/settings/ui/page/settings_page.dart';
import 'package:manga_reader/routes/app_routes.dart';

class AppPages {
  static Route<dynamic> routes(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.splash:
        return CupertinoPageRoute(builder: (_) => const SplashPage());
      case AppRoutes.base:
        return CupertinoPageRoute(builder: (_) => const BasePage());
      case AppRoutes.home:
        return CupertinoPageRoute(builder: (_) => const HomePage());
      case AppRoutes.search:
        return CupertinoPageRoute(builder: (_) => const SearchPage());
      case AppRoutes.settings:
        return CupertinoPageRoute(builder: (_) => const SettingsPage());
      default:
        return CupertinoPageRoute(builder: (_) => const Scaffold());
    }
  }
}
