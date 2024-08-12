import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:manga_reader/localization/languageManager.dart';
import 'package:manga_reader/themes/theme_colors.dart';
import 'package:manga_reader/utils/preferences/save_manager.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  SettingsBloc()
      : super(SettingsState(
            themeData: lightTheme,
            isDarckMode: false,
            isCascadeView: false,
            languageCode: 'es')) {
    on<LoadSettingsEvent>(_onLoadSettings);
    on<ToggleThemeEvent>(_onToggleTheme);
    on<ToggleViewModeEvent>(_onToggleViewMode);
    on<ToggleChangeLanguageEvent>(_onChangeLanguage);

    // Disparar la carga inicial del tema
    add(LoadSettingsEvent());
  }

  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: ThemeColors.primaryLight,
    hintColor: ThemeColors.hintColor,
    scaffoldBackgroundColor: ThemeColors.white,
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: ThemeColors.textPrimaryLightColor),
      bodyMedium: TextStyle(color: ThemeColors.textSecundaryLightColor),
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: ThemeColors.primaryDark,
    hintColor: ThemeColors.hintColor,
    scaffoldBackgroundColor: ThemeColors.primaryDark,
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: ThemeColors.white),
      bodyMedium: TextStyle(color: ThemeColors.whiteGray),
    ),
  );

  Future<void> _onLoadSettings(
      LoadSettingsEvent event, Emitter<SettingsState> emit) async {
    final isDarkMode = await SaveManager.loadDarckMode() ?? false;
    final themeData = isDarkMode ? darkTheme : lightTheme;

    final isCascadeView = await SaveManager.loadViewChapterMode() ?? false;

    final languageCode = await SaveManager.loadLanguage() ?? 'es';
    await LanguageManager().changeLanguage(languageCode);

    emit(state.copyWith(
      themeData: themeData,
      isDarckMode: isDarkMode,
      isCascadeView: isCascadeView,
      languageCode: languageCode,
    ));
  }

  Future<void> _onToggleTheme(
      ToggleThemeEvent event, Emitter<SettingsState> emit) async {
    final isCurrentlyLightTheme = state.themeData == lightTheme;
    final newThemeData = isCurrentlyLightTheme ? darkTheme : lightTheme;
    final newIsDarkMode = !state.isDarckMode;

    // Guardar la preferencia
    await SaveManager.saveDarckMode(newIsDarkMode);

    emit(state.copyWith(
      themeData: newThemeData,
      isDarckMode: newIsDarkMode,
    ));
  }

  Future<void> _onToggleViewMode(
      ToggleViewModeEvent event, Emitter<SettingsState> emit) async {
    final newViewMode = !state.isCascadeView;

    // Guardar la preferencia
    await SaveManager.saveViewChapterMode(newViewMode);

    emit(state.copyWith(isCascadeView: newViewMode));
  }

  Future<void> _onChangeLanguage(
      ToggleChangeLanguageEvent event, Emitter<SettingsState> emit) async {
    final newLanguageCode = state.languageCode == 'en' ? 'es' : 'en';

    // Guardar la preferencia
    await SaveManager.saveLanguage(newLanguageCode);

    // Cambiar el idioma en LanguageManager
    await LanguageManager().changeLanguage(newLanguageCode);

    emit(state.copyWith(languageCode: newLanguageCode));
  }
}
