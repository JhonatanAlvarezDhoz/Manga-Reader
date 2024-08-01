import 'package:flutter/material.dart';
import 'package:manga_reader/base/widgets/custom_text.dart';
import 'package:manga_reader/modules/search/ui/widgets/search/serch_delegate.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () async {
                await showSearch(
                  context: context,
                  delegate: SarchMangaDelegate(),
                );
              },
            ),
            const Center(
              child: CustomText(text: "SearchPage"),
            ),
          ],
        ),
      ),
    );
  }
}
