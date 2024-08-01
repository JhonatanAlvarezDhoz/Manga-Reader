import 'package:flutter/material.dart';
import 'package:manga_reader/base/widgets/base.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CustomText(text: "SettingsPage"),
      ),
    );
  }
}
