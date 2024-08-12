import 'package:flutter/material.dart';
import 'package:manga_reader/base/ui/widgets/base.dart';
import 'package:manga_reader/localization/languageManager.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Center(
              child: CustomText(text: LanguageManager().translate().download),
            )
          ],
        ),
      ),
    );
  }
}
