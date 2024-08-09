part of 'settings_bloc.dart';

class SettingsState extends Equatable {
  final ThemeData themeData;
  final bool isDarckMode;
  final bool isCascadeView;

  const SettingsState({
    required this.isDarckMode,
    required this.themeData,
    required this.isCascadeView,
  });

  SettingsState copyWith({
    ThemeData? themeData,
    bool? isDarckMode,
    bool? isCascadeView,
  }) =>
      SettingsState(
        themeData: themeData ?? this.themeData,
        isDarckMode: isDarckMode ?? this.isDarckMode,
        isCascadeView: isCascadeView ?? this.isCascadeView,
      );

  @override
  List<Object> get props => [themeData, isDarckMode, isCascadeView];
}
