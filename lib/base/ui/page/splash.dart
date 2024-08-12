// ignore_for_file: use_build_context_synchronously
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:manga_reader/base/ui/widgets/custom_text.dart';
import 'package:manga_reader/routes/app_routes.dart';
import 'package:manga_reader/themes/theme_colors.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 3), () async {
      await validateSession();
    });
    super.initState();
  }

  Future<void> validateSession() async {
    await Future.delayed(const Duration(seconds: 2), () async {
      Future.delayed(const Duration(seconds: 1), () {
        Navigator.of(context).pushReplacementNamed(AppRoutes.base);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SafeArea(
              child: Container(
            margin: const EdgeInsets.only(top: 30),
            child: CustomText(
              text: "Manga Reader",
              fontSize: 30,
              fontWeight: FontWeight.w700,
              color: Theme.of(context).textTheme.bodyMedium!.color,
            ),
          )),
          ZoomIn(
            duration: const Duration(milliseconds: 3000),
            child: Center(
              child: Image.asset(
                "assets/icons/manga.png",
                width: 260,
              ),
            ),
          ),
          SafeArea(
              child: Container(
            margin: const EdgeInsets.only(bottom: 20),
            child: const CustomText(
              text: "by: Jhonatan Alvarez",
              fontWeight: FontWeight.w600,
              color: ThemeColors.hintColor,
            ),
          ))
        ],
      ),
    );
  }
}
