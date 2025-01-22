part of 'themes.dart';

/// A set of colors for the entire app.
const colorLightScheme = ColorScheme.light(
  primary: Color(0xff2AA2C8),
  surface: Color(0xFFFAFAFA),
  onSurface: Color(0xFF242424),
  secondary: Color(0xFF69D7C7),
  onSecondary: Color(0xFF616161),
  error: Color(0xFFD93F2F),
  surfaceContainerHighest: Color(0xFFF5F5F5),
  secondaryContainer: Color(0xFFF0F0F0),
  outline: Color(0xFFF5F5F5),
);

///
// const colorDarkScheme = ColorScheme.dark(
//   primary: Color(0xff2AA2C8),
//   surface: Color(0xFFF7F9FC),
//   onSurface: Color(0xFF242424),
//   secondary: Color(0xFF69D7C7),
//   onSecondary: Color(0xFF616161),
//   error: Color(0xFFD93F2F),
//   surfaceContainerHighest: Color(0xFFF5F5F5),
//   secondaryContainer: Color(0xFFF0F0F0),
//   outline: Color(0xFFF5F5F5),
// );

class ThemeColors extends ThemeExtension<ThemeColors> {
  const ThemeColors({
    required this.yellow,
    required this.green,
    required this.blueDark,
    required this.blueLight,
    required this.red,
    required this.brown,
    required this.primaryText,
    required this.secondaryText,
  });

  final Color green;
  final Color yellow;
  final Color blueDark;
  final Color blueLight;
  final Color red;
  final Color brown;
  final Color primaryText;
  final Color secondaryText;

  static const ThemeColors light = ThemeColors(
    yellow: Color(0xFFF4CA36),
    green: Color(0xFF119C2B),
    blueDark: Color(0xFF2A56C8),
    blueLight: Color(0xFF2A7CC8),
    red: Color(0xFFC82A63),
    brown: Color(0xFFC86C2A),
    primaryText: Color(0xFF242424),
    secondaryText: Color(0xFF616161),
  );
  static const ThemeColors dark = ThemeColors(
    yellow: Color(0xFFF4CA36),
    green: Color(0xFF119C2B),
    blueDark: Color(0xFF2A56C8),
    blueLight: Color(0xFF2A7CC8),
    red: Color(0xFFC82A63),
    brown: Color(0xFFC86C2A),
    primaryText: Color(0xFF242424),
    secondaryText: Color(0xFF616161),
  );

  @override
  ThemeExtension<ThemeColors> copyWith({
    Color? yellow,
    Color? green,
    Color? primaryText,
    Color? secondaryText,
    Color? blueDark,
    Color? blueLight,
    Color? red,
    Color? brown,
  }) =>
      ThemeColors(
        blueDark: blueDark ?? this.blueDark,
        blueLight: blueLight ?? this.blueLight,
        brown: brown ?? this.brown,
        red: red ?? this.red,
        yellow: yellow ?? this.yellow,
        green: green ?? this.green,
        primaryText: primaryText ?? this.primaryText,
        secondaryText: secondaryText ?? this.secondaryText,
      );

  @override
  ThemeExtension<ThemeColors> lerp(ThemeExtension<ThemeColors>? other, double t) {
    if (other is! ThemeColors) {
      return this;
    }
    return ThemeColors(
      blueDark: Color.lerp(blueDark, other.blueDark, t)!,
      blueLight: Color.lerp(blueLight, other.blueLight, t)!,
      brown: Color.lerp(brown, other.brown, t)!,
      red: Color.lerp(red, other.red, t)!,
      primaryText: Color.lerp(primaryText, other.primaryText, t)!,
      secondaryText: Color.lerp(secondaryText, other.secondaryText, t)!,
      green: Color.lerp(green, other.green, t)!,
      yellow: Color.lerp(yellow, other.yellow, t)!,
    );
  }
}

bool isDarkModeEnable = false;

List<Color> gradientColors = [
  isDarkModeEnable ? const Color(0xFF862254) : Color(0xFFFA457E),
  isDarkModeEnable ? const Color(0xFF483585) : const Color(0xFF7B49FF),
];

List<Color> buttonGradient = [
  AppColor.mainColor.withOpacity(0.8),
  AppColor.mainColor,
  AppColor.mainColor.withOpacity(0.8),
];

List<Color> scaffoldBackgroundGradientColors = [
  const Color(0xFF061C88),
  const Color(0xFF292343),
];

class AppColor {
  static const white = Color(0xFFFFFFFF);
  static const black = Color(0xFF000000);
  static const textColor = Color(0xFF03000C);
  static const iconsColor = Color(0xFF292343);
  static const errorColor = Color(0xFFD31D07);
  static const likeMaleIconColor = Color(0xFFEC8400);
  static const likeFemaleIconColor = Color(0xFFD01700);

  /// women
  static const mainWomenColor = Color(0xFFFF4B6C);
  static const womenBackColor = Color(0xFFFFF3F4);

  /// men
  static const mainMenColor = Color(0xF22A5CEF);
  static const menBackColor = Color(0xF2F2F3FF);

  /// main
  static Color mainColor = Colors.blue;
  static Color mainBackColor = Colors.white;
}

void getColors(String? gender) {
  if (gender == 'MALE') {
    AppColor.mainColor = AppColor.mainMenColor;
    AppColor.mainBackColor = AppColor.menBackColor;
  } else if (gender == 'FEMALE') {
    AppColor.mainColor = AppColor.mainWomenColor;
    AppColor.mainBackColor = AppColor.womenBackColor;
  } else {
    AppColor.mainColor = AppColor.white;
    AppColor.mainBackColor = AppColor.white;
  }
}
