// ignore_for_file: non_constant_identifier_names

part of 'theme_bloc.dart';

class ThemeState extends Equatable {
  final ThemeData themeData;
  final bool isDarckMode;

  const ThemeState({required this.themeData, this.isDarckMode = false});

  ThemeState copyWith({
    ThemeData? themeData,
    bool? isDarckMode,
  }) =>
      ThemeState(
        themeData: themeData ?? this.themeData,
        isDarckMode: isDarckMode ?? this.isDarckMode,
      );

  @override
  List<Object> get props => [themeData, isDarckMode];
}
