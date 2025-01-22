part of 'extension.dart';

extension BuildContextExt on BuildContext {
  Locale get locale => Localizations.localeOf(this);

  ThemeData get theme => Theme.of(this);

  ColorScheme get colorScheme => Theme.of(this).colorScheme;

  bool get isDarkMode => Theme.of(this).brightness == Brightness.dark;

  ThemeColors get color => Theme.of(this).extension<ThemeColors>()!;

  ThemeTextStyles get textStyle => Theme.of(this).extension<ThemeTextStyles>()!;

  String tr(
    String key, {
    Map<String, String>? namedArgs,
  }) =>
      AppLocalizations.of(this).translate(key, namedArgs: namedArgs);

  AppOptions get options => AppOptions.of(this);

  void setLocale(Locale locale) {
    AppOptions.update(
      this,
      AppOptions.of(this).copyWith(locale: locale),
    );
  }

  void setThemeMode(ThemeMode themeMode) {
    AppOptions.update(
      this,
      AppOptions.of(this).copyWith(themeMode: themeMode),
    );
  }

  void showFloatingSnackBar({
    required String message,
    Color backgroundColor = Colors.red,
    EdgeInsets margin = const EdgeInsets.all(16),
    TextStyle textStyle = const TextStyle(color: Colors.white, fontSize: 14),
    BorderRadius borderRadius = const BorderRadius.all(Radius.circular(16)),
    EdgeInsets padding = const EdgeInsets.all(16),
  }) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: textStyle,
        ),
        backgroundColor: backgroundColor,
        behavior: SnackBarBehavior.floating,
        margin: margin,
        shape: RoundedRectangleBorder(borderRadius: borderRadius),
        padding: padding,
      ),
    );
  }
}

extension LocalizationExtension on String {
  String tr({
    BuildContext? context,
    Map<String, String>? namedArgs,
  }) =>
      context == null
          ? AppLocalizations.instance.translate(this, namedArgs: namedArgs)
          : AppLocalizations.of(context).translate(this, namedArgs: namedArgs);
}
