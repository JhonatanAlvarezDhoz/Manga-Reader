import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manga_reader/base/widgets/base.dart';
import 'package:manga_reader/modules/search/bloc/search_delegate_bloc.dart';
import 'package:manga_reader/themes/bloc/theme_bloc.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      final BoxConstraints size = constraints;
      final themeBloc = BlocProvider.of<ThemeBloc>(context);
      final searchBloc = BlocProvider.of<SearchDelegateBloc>(context);

      return BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, stateTheme) {
          return BlocBuilder<SearchDelegateBloc, SearchDelegateState>(
            builder: (context, stateSeach) {
              return Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                child: Column(
                  children: [
                    const SafeArea(
                      child: CustomText(text: "Settings"),
                    ),
                    _SettingBox(
                      size: size,
                      textLabel: "DarckMode",
                      isActive: stateTheme.isDarckMode,
                      onToggle: (bool newValue) {
                        themeBloc.add(ToggleTheme(newValue));
                      },
                    ),
                    _SettingBox(
                        size: size,
                        textLabel: "Capitulos en cascada",
                        isActive: stateSeach.isCascadeMode,
                        onToggle: (bool newValue) {
                          searchBloc.add(ToggleCascadeModeEvent(newValue));
                        })
                  ],
                ),
              );
            },
          );
        },
      );
    }));
  }
}

class _SettingBox extends StatelessWidget {
  const _SettingBox({
    super.key,
    required this.size,
    required this.textLabel,
    required this.onToggle,
    required this.isActive,
  });

  final String textLabel;
  final bool isActive;
  final BoxConstraints size;
  final ValueChanged<bool> onToggle;
  @override
  Widget build(BuildContext context) {
    final double height = size.maxHeight;
    final double width = size.maxWidth;
    final Color shadowColor = Colors.grey.withOpacity(0.1);
    return Container(
      height: height * 0.06,
      width: width,
      decoration: BoxDecoration(
        border: Border.symmetric(
          horizontal: BorderSide(color: shadowColor, width: 1.0),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomText(text: textLabel),
          Switch.adaptive(value: isActive, onChanged: onToggle)
        ],
      ),
    );
  }
}
