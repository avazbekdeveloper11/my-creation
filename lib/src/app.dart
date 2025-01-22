import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sovchilar_mobile/src/config/router/app_routes.dart';
import 'package:sovchilar_mobile/src/config/themes/themes.dart';
import 'package:sovchilar_mobile/src/core/extension/extension.dart';
import 'package:sovchilar_mobile/src/core/l10n/app_localizations.dart';
import 'package:sovchilar_mobile/src/injector_container.dart';

import 'presentation/bloc/main/main_bloc.dart';
import 'presentation/bloc/questionnaire/questionnaire_bloc.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) => MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => sl<MainBloc>(),
          ),
          BlocProvider(
            create: (context) => sl<QuestionnaireBloc>(),
          ),
        ],
        child: MaterialApp.router(
          /// title
          debugShowCheckedModeBanner: false,
          scaffoldMessengerKey: scaffoldMessengerKey,

          /// theme style
          theme: lightTheme,
          // darkTheme: darkTheme,
          themeMode: context.options.themeMode,

          /// lang
          locale: context.options.locale,
          supportedLocales: AppLocalizations.supportedLocales,
          localizationsDelegates: AppLocalizations.localizationsDelegates,

          /// pages
          routerDelegate: router.routerDelegate,
          routeInformationParser: router.routeInformationParser,
          routeInformationProvider: router.routeInformationProvider,
        ),
      );
}
