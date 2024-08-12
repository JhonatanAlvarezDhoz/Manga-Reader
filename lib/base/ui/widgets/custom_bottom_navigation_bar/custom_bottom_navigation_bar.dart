import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:manga_reader/base/ui/widgets/custom_text.dart';
import 'package:manga_reader/modules/settings/bloc/settings_bloc.dart';
import 'package:manga_reader/themes/theme_colors.dart';
import 'package:manga_reader/utils/constants.dart';
import 'package:manga_reader/utils/responsive.dart';

const homeTab = 0;
const searchTab = 1;
const settingsTab = 2;

class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({
    super.key,
    required this.onChange,
    required this.currentIndex,
  });

  final ValueChanged<int> onChange;
  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);
    final settingBloc = context.watch<SettingsBloc>().state;

    bool isDarkTheme = settingBloc.themeData.brightness == Brightness.dark;
    final ThemeData theme = Theme.of(context);

    Color shadowColor = isDarkTheme
        ? Colors.white.withOpacity(0.5)
        : Colors.grey.withOpacity(0.1);

    return SafeArea(
      top: false,
      child: Container(
        padding:
            EdgeInsets.symmetric(horizontal: responsive.diagonalResponsive(3)),
        height: responsive.heightResponsive(7),
        width: responsive.widthResponsive(100),
        decoration: BoxDecoration(
          color: theme.scaffoldBackgroundColor,
          boxShadow: [
            BoxShadow(
              offset: const Offset(0.0, -3.0),
              color: shadowColor,
              spreadRadius: 0.0,
              blurRadius: 1,
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            iconNavBottomBar.length,
            (index) {
              IconNavBottomBar item = iconNavBottomBar[index];

              return _BottomAnimatedContainer(
                index: index,
                isSelected: currentIndex == index,
                item: item,
                onChanged: (int value) {
                  onChange(value);
                },
              );
            },
          ),
        ),
      ),
    );
  }
}

class _BottomAnimatedContainer extends StatelessWidget {
  const _BottomAnimatedContainer({
    required this.item,
    required this.isSelected,
    required this.index,
    required this.onChanged,
  });

  final IconNavBottomBar item;
  final bool isSelected;
  final int index;
  final ValueChanged<int> onChanged;

  Color choiceColor(BuildContext context, int currentTab) {
    final settingBloc = context.watch<SettingsBloc>().state;
    bool isDarkTheme = settingBloc.themeData.brightness == Brightness.dark;

    if (isDarkTheme) {
      switch (currentTab) {
        case homeTab:
          return ThemeColors.hintColor;
        case searchTab:
          return Colors.red[300]!;
        case settingsTab:
          return ThemeColors.greenColor;
        default:
          return Colors.grey[600]!;
      }
    } else {
      switch (currentTab) {
        case homeTab:
          return ThemeColors.hintColor;
        case searchTab:
          return Colors.red;
        case settingsTab:
          return ThemeColors.greenColor;
        default:
          return Colors.grey;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);
    final settingState = context.watch<SettingsBloc>().state;
    bool isDarkTheme = settingState.themeData.brightness == Brightness.dark;

    Color backgroundColor =
        isDarkTheme ? Colors.grey[850]! : Colors.grey.withOpacity(0.2);

    return TweenAnimationBuilder(
      curve: Curves.ease,
      tween: Tween(begin: 0.0, end: isSelected ? 1.0 : 0.0),
      duration: const Duration(milliseconds: 600),
      builder: (context, value, child) {
        final double width = value * responsive.diagonalResponsive(11) +
            responsive.heightResponsive(5.5);
        return GestureDetector(
          onTap: isSelected ? null : () => onChanged(index),
          child: Container(
            height: responsive.heightResponsive(5.5),
            width: isSelected ? width : responsive.widthResponsive(12),
            margin: const EdgeInsets.symmetric(horizontal: 10),
            padding: isSelected
                ? const EdgeInsets.symmetric(horizontal: 9)
                : const EdgeInsets.symmetric(horizontal: 0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color: Color.lerp(backgroundColor,
                  choiceColor(context, index).withOpacity(0.2), value),
            ),
            child: LayoutBuilder(builder: (context, constraints) {
              return Stack(
                alignment: Alignment.center,
                children: [
                  AnimatedPositioned(
                    left: 14,
                    width: constraints.maxWidth * .35,
                    duration: const Duration(milliseconds: 0),
                    child: SvgPicture.asset(
                      item.iconString,
                      width: isSelected
                          ? constraints.maxWidth * .19
                          : constraints.maxWidth * .4,
                      color: choiceColor(context, index),
                    ),
                  ),
                  if (isSelected)
                    Positioned(
                      right: constraints.maxWidth * .02,
                      width: constraints.maxWidth * .6,
                      child: AnimatedOpacity(
                        opacity: value > 0.7 ? 1 : 0,
                        duration: const Duration(milliseconds: 200),
                        child: FittedBox(
                          fit: BoxFit.none,
                          child: CustomText(
                            text: item.title!,
                            fontSize: responsive.diagonalResponsive(1.6),
                            color: choiceColor(context, index),
                          ),
                        ),
                      ),
                    ),
                ],
              );
            }),
          ),
        );
      },
    );
  }
}
