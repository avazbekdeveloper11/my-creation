part of 'themes.dart';

final appTheme = ThemeData(
  useMaterial3: true,
  applyElevationOverlayColor: true,
  pageTransitionsTheme: const PageTransitionsTheme(
    builders: {
      TargetPlatform.android: CupertinoPageTransitionsBuilderCustomBackGestureWidth(),
      TargetPlatform.iOS: CupertinoPageTransitionsBuilderCustomBackGestureWidth(),
      TargetPlatform.macOS: CupertinoPageTransitionsBuilderCustomBackGestureWidth(),
      TargetPlatform.windows: CupertinoPageTransitionsBuilderCustomBackGestureWidth(),
    },
  ),
  actionIconTheme: ActionIconThemeData(
    backButtonIconBuilder: (context) => IconButton(
      onPressed: () => Navigator.maybePop(context),
      icon: Platform.isAndroid ? const Icon(Icons.arrow_back_rounded) : const Icon(Icons.arrow_back_ios_new_rounded),
    ),
    drawerButtonIconBuilder: (context) => IconButton(
      onPressed: () => Scaffold.of(context).openDrawer(),
      icon: const Icon(Icons.menu),
    ),
  ),
  splashFactory: Platform.isAndroid ? InkRipple.splashFactory : NoSplash.splashFactory,
  visualDensity: VisualDensity.standard,
  materialTapTargetSize: MaterialTapTargetSize.padded,
  textButtonTheme: const TextButtonThemeData(
    style: ButtonStyle(
      padding: WidgetStatePropertyAll<EdgeInsetsGeometry>(EdgeInsets.zero),
    ),
  ),
  dividerTheme: const DividerThemeData(thickness: 1),
);

final ThemeData lightTheme = appTheme.copyWith(
  progressIndicatorTheme: ProgressIndicatorThemeData(
    color: AppColor.mainColor,
    circularTrackColor: AppColor.white,
  ),
  extensions: <ThemeExtension<dynamic>>[
    ThemeTextStyles.light,
    ThemeColors.light,
  ],
  primaryColor: colorLightScheme.primary,
  colorScheme: colorLightScheme,
  dialogBackgroundColor: colorLightScheme.surface,
  scaffoldBackgroundColor: colorLightScheme.surface,
  cardColor: Colors.white,
  canvasColor: Colors.white,
  shadowColor: const Color(0xFFF5F5F5),
  disabledColor: const Color(0xFFF5F5F5),
  iconTheme: const IconThemeData(color: Color(0xFF242424)),
  dividerTheme: const DividerThemeData(
    thickness: 1,
    color: Color(0xFFF5F5F5),
  ),
  dialogTheme: const DialogTheme(
    backgroundColor: Colors.white,
    surfaceTintColor: Colors.white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(10)),
    ),
  ),
  bottomAppBarTheme: const BottomAppBarTheme(
    elevation: 1,
    color: Colors.white,
    surfaceTintColor: Colors.white,
    shadowColor: Colors.black45,
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: colorLightScheme.primary,
    foregroundColor: Colors.white,
    elevation: 0,
    focusElevation: 0,
    hoverElevation: 0,
    highlightElevation: 0,
    shape: const CircleBorder(),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      foregroundColor: WidgetStateProperty.resolveWith(
        (states) => Colors.white,
      ),
      backgroundColor: WidgetStateProperty.resolveWith(
        (states) {
          if (states.contains(WidgetState.disabled)) {
            return Colors.grey;
          }
          return colorLightScheme.primary;
        },
      ),
      textStyle: WidgetStatePropertyAll(ThemeTextStyles.light.buttonStyle),
      elevation: const WidgetStatePropertyAll(0),
      shape: const WidgetStatePropertyAll(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
      ),
      fixedSize: const WidgetStatePropertyAll(Size(double.infinity, 48)),
    ),
  ),
  inputDecorationTheme: const InputDecorationTheme(),
  bottomSheetTheme: const BottomSheetThemeData(
    elevation: 0,
    showDragHandle: true,
    backgroundColor: Colors.white,
    surfaceTintColor: Colors.white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(16),
        topRight: Radius.circular(16),
      ),
    ),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    elevation: 4,
    backgroundColor: Colors.white,
    type: BottomNavigationBarType.fixed,
    showSelectedLabels: true,
    selectedLabelStyle: const TextStyle(fontSize: 12),
    unselectedLabelStyle: const TextStyle(fontSize: 12),
    unselectedItemColor: const Color(0xffA0A9B6),
    selectedItemColor: Colors.grey,
  ),
  tabBarTheme: TabBarTheme(
    indicatorColor: colorLightScheme.primary,
    labelColor: colorLightScheme.primary,
    unselectedLabelColor: const Color(0xFF616161),
    dividerColor: Colors.transparent,
    overlayColor: const WidgetStatePropertyAll(Colors.transparent),
    labelStyle: const TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.w500,
    ),
    unselectedLabelStyle: const TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.w500,
    ),
    indicator: UnderlineTabIndicator(
      borderSide: BorderSide(
        width: 2.5,
        color: colorLightScheme.primary,
      ),
    ),
  ),
  navigationBarTheme: NavigationBarThemeData(
    elevation: 0,
    backgroundColor: Colors.white,
    height: kToolbarHeight,
    iconTheme: WidgetStateProperty.resolveWith<IconThemeData>(
      (states) => const IconThemeData(
        color: Colors.black,
      ),
    ),
    labelTextStyle: WidgetStateProperty.resolveWith<TextStyle>(
      (states) => ThemeTextStyles.light.appBarTitle,
    ),
  ),
  appBarTheme: AppBarTheme(
    elevation: 1,
    scrolledUnderElevation: 1,
    systemOverlayStyle: const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Colors.transparent,
      // ios
      statusBarBrightness: Brightness.light,
      // android
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
    iconTheme: const IconThemeData(color: Colors.black),
    shadowColor: Colors.black45,
    titleTextStyle: const TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.w600,
      fontSize: 17,
    ),
    toolbarTextStyle: ThemeTextStyles.light.appBarTitle,
    backgroundColor: Colors.white,
    surfaceTintColor: Colors.white,
  ),
  listTileTheme: const ListTileThemeData(
    iconColor: Color(0xFF242424),
    tileColor: Colors.white,
    minVerticalPadding: 16,
    textColor: Color(0xFF242424),
    titleTextStyle: TextStyle(
      fontSize: 15,
      height: 20 / 15,
      color: Color(0xFF242424),
      fontWeight: FontWeight.w500,
    ),
    leadingAndTrailingTextStyle: TextStyle(
      fontSize: 13,
      height: 18 / 13,
      color: Color(0xFF616161),
      fontWeight: FontWeight.w400,
    ),
    contentPadding: EdgeInsets.symmetric(horizontal: 16),
  ),
  textTheme: const TextTheme(
    titleLarge: TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.w400,
      fontSize: 34,
    ),

    /// text field title style
    titleMedium: TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.w400,
      fontSize: 17,
    ),
    titleSmall: TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.w400,
      fontSize: 17,
    ),

    /// list tile title style
    bodyLarge: TextStyle(
      fontSize: 15,
      height: 20 / 15,
      color: Color(0xFF242424),
      fontWeight: FontWeight.w500,
    ),

    /// list tile subtitle style
    bodyMedium: TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.w600,
      fontSize: 17,
    ),
    bodySmall: TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.w600,
      fontSize: 15,
    ),
    displayLarge: TextStyle(
      color: Colors.black,
    ),
    displayMedium: TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.w600,
      fontSize: 17,
    ),
    displaySmall: TextStyle(
      color: Colors.black,
    ),
  ),
);
//
final ThemeData darkTheme = appTheme.copyWith(
  progressIndicatorTheme: ProgressIndicatorThemeData(
    color: AppColor.mainColor,
    circularTrackColor: AppColor.white,
  ),
  extensions: <ThemeExtension<dynamic>>[
    ThemeTextStyles.dark,
    ThemeColors.dark,
  ],
  bottomSheetTheme: const BottomSheetThemeData(
    elevation: 0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(24),
        topRight: Radius.circular(24),
      ),
    ),
  ),
  tabBarTheme: TabBarTheme(
    labelColor: Colors.white,
    indicator: BoxDecoration(
      color: Colors.transparent,
      borderRadius: const BorderRadius.all(Radius.circular(24)),
      border: Border.all(color: Colors.blue, width: 2),
    ),
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    showSelectedLabels: true,
    elevation: 2,
  ),
  pageTransitionsTheme: const PageTransitionsTheme(
    builders: {
      TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
      TargetPlatform.android: CupertinoPageTransitionsBuilder(),
    },
  ),
  appBarTheme: AppBarTheme(
    elevation: 0,
    centerTitle: true,
    systemOverlayStyle: const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      // systemNavigationBarColor: ThemeColors.primary,

      /// android
      statusBarIconBrightness: Brightness.light,

      /// ios
      statusBarBrightness: Brightness.dark,
    ),
    iconTheme: const IconThemeData(color: Colors.white),
    titleTextStyle: ThemeTextStyles.dark.appBarTitle,
    // backgroundColor: ThemeColors.cardBackgroundDark,
  ),
  textTheme: const TextTheme(
    bodySmall: TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.w500,
      fontSize: 17,
    ),
    bodyMedium: TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.w500,
      fontSize: 17,
    ),
  ),
);
