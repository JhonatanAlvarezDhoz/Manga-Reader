part of 'settings_bloc.dart';

sealed class SettingsEvent extends Equatable {
  const SettingsEvent();

  @override
  List<Object> get props => [];
}

class LoadSettingsEvent extends SettingsEvent {}

class ToggleThemeEvent extends SettingsEvent {}

class ToggleViewModeEvent extends SettingsEvent {}

class ToggleChangeLanguageEvent extends SettingsEvent {}
