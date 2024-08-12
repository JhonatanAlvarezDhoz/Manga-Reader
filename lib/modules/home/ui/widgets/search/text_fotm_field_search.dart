import 'package:flutter/material.dart';
import 'package:manga_reader/localization/languageManager.dart';

class SearchableTextFormField extends StatelessWidget {
  const SearchableTextFormField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(children: [
          // Barra de búsqueda visual
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
            decoration: BoxDecoration(
              color: theme.scaffoldBackgroundColor,
              borderRadius: BorderRadius.circular(8.0),
              boxShadow: [
                BoxShadow(
                  color: theme.textTheme.bodyMedium!.color!,
                  blurRadius: 0.5,
                  offset: const Offset(0, 0.5),
                ),
              ],
            ),
            child: Row(
              children: [
                const Icon(Icons.search, color: Colors.grey),
                const SizedBox(width: 8.0),
                Expanded(
                  child: Text(
                    LanguageManager().translate().typeSearch,
                    style: const TextStyle(color: Colors.grey),
                  ),
                ),
              ],
            ),
          ),
        ]));
  }
}
