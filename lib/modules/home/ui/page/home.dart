import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manga_reader/base/widgets/base.dart';
import 'package:manga_reader/themes/bloc/theme_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Búsqueda de Manga'),
        actions: [
          IconButton(
            icon: const Icon(Icons.brightness_6),
            onPressed: () {
              BlocProvider.of<ThemeBloc>(context).add(ToggleTheme());
            },
          ),
        ],
      ),
      body: const Column(
        children: [Center(child: CustomText(text: "HomePage"))],
      ),
    );
  }
}
