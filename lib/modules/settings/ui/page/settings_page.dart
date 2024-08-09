import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:manga_reader/base/widgets/base.dart';
import 'package:manga_reader/modules/settings/bloc/settings_bloc.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      final BoxConstraints size = constraints;
      final settingBloc = BlocProvider.of<SettingsBloc>(context);

      return BlocBuilder<SettingsBloc, SettingsState>(
        builder: (context, settingState) {
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
                  isActive: settingState.isDarckMode,
                  assetName: settingState.isDarckMode
                      ? "assets/icons/moon.svg"
                      : "assets/icons/sun.svg",
                  onToggle: (bool newValue) {
                    settingBloc.add(ToggleThemeEvent());
                  },
                ),
                _SettingBox(
                    size: size,
                    textLabel: "Capitulos en cascada",
                    isActive: settingState.isCascadeView,
                    assetName: settingState.isCascadeView
                        ? "assets/icons/view.svg"
                        : "assets/icons/offView.svg",
                    onToggle: (bool newValue) {
                      settingBloc.add(ToggleViewModeEvent());
                    }),
                _SettingBox(
                    size: size,
                    textLabel: "Idioma",
                    isActive: settingState.isCascadeView,
                    assetName: settingState.isCascadeView
                        ? "assets/icons/en.svg"
                        : "assets/icons/translate.svg",
                    onToggle: (bool newValue) {
                      settingBloc.add(ToggleViewModeEvent());
                    })
              ],
            ),
          );
        },
      );
    }));
  }
}

class _SettingBox extends StatelessWidget {
  const _SettingBox({
    required this.size,
    required this.textLabel,
    required this.onToggle,
    required this.isActive,
    required this.assetName,
  });

  final String textLabel;
  final bool isActive;
  final BoxConstraints size;
  final ValueChanged<bool> onToggle;
  final String assetName;

  @override
  Widget build(BuildContext context) {
    final double height = size.maxHeight;
    final double width = size.maxWidth;
    final Color shadowColor = Colors.grey.withOpacity(0.1);

    final ThemeData theme = Theme.of(context);
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
          SizedBox(
            width: width * 0.65,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(text: textLabel),
                SvgPicture.asset(
                  assetName,
                  width: height * 0.03,
                  // ignore: deprecated_member_use
                  color: theme.textTheme.bodyMedium!.color,
                ),
              ],
            ),
          ),
          Switch.adaptive(value: isActive, onChanged: onToggle)
        ],
      ),
    );
  }
}
