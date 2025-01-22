import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sovchilar_mobile/src/app.dart';
import 'package:sovchilar_mobile/src/app_options.dart';
import 'package:sovchilar_mobile/src/config/router/app_routes.dart';
import 'package:sovchilar_mobile/src/config/themes/themes.dart';
import 'package:sovchilar_mobile/src/injector_container.dart';
import 'package:sovchilar_mobile/src/presentation/bloc/log_bloc_observer.dart';
import 'src/core/services/notification_service.dart';
import 'src/presentation/pages/components/native_splash/flutter_native_splash.dart';

void main() async {
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  await NotificationService.initialize();

  /// bloc logger
  if (kDebugMode) {
    Bloc.observer = LogBlocObserver();
  }

  HttpOverrides.global = _HttpOverrides();

  await init();

  /// new format
  runApp(
    ModelBinding(
      initialModel: AppOptions(
        themeMode: localSource.themeMode,
        locale: Locale(localSource.locale),
      ),
      child: ScreenUtilInit(
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) => const MainApp(),
      ),
    ),
  );
  FlutterNativeSplash.remove();
}

class _HttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) =>
      super.createHttpClient(context)..badCertificateCallback = (cert, host, port) => true;
}

/// flutter pub run flutter_launcher_icons:main
/// flutter run -d windows --no-sound-null-safety
/// flutter build apk --release --no-sound-null-safety
/// flutter build apk --split-per-abi --no-sound-null-safety
/// flutter build appbundle --release --no-sound-null-safety
/// flutter pub run build_runner watch --delete-conflicting-outputs
/// flutter pub ipa
/// dart fix --apply
