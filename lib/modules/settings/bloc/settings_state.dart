part of 'settings_bloc.dart';

class SettingsState extends Equatable {
  final ThemeData themeData;
  final bool isDarckMode;
  final bool isCascadeView;
  final String languageCode;

  const SettingsState({
    required this.isDarckMode,
    required this.themeData,
    required this.isCascadeView,
    required this.languageCode,
  });

  SettingsState copyWith({
    ThemeData? themeData,
    bool? isDarckMode,
    bool? isCascadeView,
    String? languageCode,
  }) =>
      SettingsState(
          themeData: themeData ?? this.themeData,
          isDarckMode: isDarckMode ?? this.isDarckMode,
          isCascadeView: isCascadeView ?? this.isCascadeView,
          languageCode: languageCode ?? this.languageCode);

  @override
  List<Object> get props =>
      [themeData, isDarckMode, isCascadeView, languageCode];
}
