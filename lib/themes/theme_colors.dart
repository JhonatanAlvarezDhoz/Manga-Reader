import 'dart:ui';

/// A utility class for defining theme colors used throughout the application.
class ThemeColors extends Color {
  /// Private constructor to prevent instantiation of this class.
  ThemeColors._(super.value);

  /// Defines the primary color used in the application, typically used for primary elements.
  static const Color primary = Color(0xffe95c0c);

  /// Defines the primary dark color used in the application, typically used for primary elements.
  static const Color primaryDark = Color.fromARGB(255, 144, 66, 20);

  /// Defines a lighter shade of the primary color, often used for highlights or accents.
  static const Color primaryLight = Color(0xffff7526);

  /// Defines a secondary color used in the application, typically for secondary elements.
  static const Color secondary = Color(0xff253c80);

  /// Defines a tertiary color used in the application, often for backgrounds or subtle accents.
  static const Color tertiary = Color(0xff1c1c1c);

  /// Defines the white color used in the application, primarily for backgrounds or
  /// text on dark backgrounds.
  static const Color white = Color(0xffFFFFFF);

  /// Defines a light gray color used in the application, primarily for backgrounds.
  static const Color whiteGray = Color(0xffEAEAEA);

  /// Defines a blue accent color used in the application, typically for highlighting
  /// or indicating actions.
  static const Color blueAccent = Color(0xFF448AFF);
}
