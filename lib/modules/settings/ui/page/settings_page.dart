import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manga_reader/base/widgets/base.dart';
import 'package:manga_reader/themes/bloc/theme_bloc.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      final BoxConstraints size = constraints;

      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
        child: Column(
          children: [
            const SafeArea(
              child: CustomText(text: "Settings"),
            ),
            _SettingBox(
              size: size,
              textLabel: "DarckMode",
            )
          ],
        ),
      );
    }));
  }
}

class _SettingBox extends StatelessWidget {
  const _SettingBox({
    super.key,
    required this.size,
    required this.textLabel,
  });

  final BoxConstraints size;
  final String textLabel;
  @override
  Widget build(BuildContext context) {
    final double height = size.maxHeight;
    final double width = size.maxWidth;
    final themeBloc = BlocProvider.of<ThemeBloc>(context);
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        return SizedBox(
          height: height * 0.06,
          width: width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(text: textLabel),
              Switch.adaptive(
                  value: state.isDarckMode,
                  onChanged: (bool newValue) {
                    themeBloc.add(ToggleTheme(newValue));
                  })
            ],
          ),
        );
      },
    );
  }
}
