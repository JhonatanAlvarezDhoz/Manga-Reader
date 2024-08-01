part of 'theme_bloc.dart';

abstract class ThemeEvent extends Equatable {
  const ThemeEvent();

  @override
  List<Object> get props => [];
}

class ToggleTheme extends ThemeEvent {
  final bool isDarckMode;

  const ToggleTheme(this.isDarckMode);

  @override
  List<Object> get props => [isDarckMode];
}
