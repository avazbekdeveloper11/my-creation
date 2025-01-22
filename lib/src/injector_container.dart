import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio_retry_plus/dio_retry_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sovchilar_mobile/src/config/router/app_routes.dart';
import 'package:sovchilar_mobile/src/domain/repositories/auth_repo/auth_repository.dart';
import 'package:sovchilar_mobile/src/domain/repositories/chat_repo/chat_repository.dart';
import 'package:sovchilar_mobile/src/domain/repositories/image_repo/image_repository.dart';
import 'package:sovchilar_mobile/src/domain/repositories/like_repo/like_repository.dart';
import 'package:sovchilar_mobile/src/domain/repositories/profile_repo/profile_repository.dart';
import 'package:sovchilar_mobile/src/presentation/bloc/auth/login/login_bloc.dart';
import 'package:sovchilar_mobile/src/presentation/bloc/auth/otp/otp_bloc.dart';
import 'package:sovchilar_mobile/src/presentation/bloc/chat/chat_bloc.dart';
import 'package:sovchilar_mobile/src/presentation/bloc/user/user_bloc.dart';
import 'package:sovchilar_mobile/src/presentation/bloc/filter/filter_bloc.dart';
import 'package:sovchilar_mobile/src/presentation/bloc/image/image_upload_bloc.dart';
import 'package:sovchilar_mobile/src/presentation/bloc/like/like_bloc.dart';
import 'package:sovchilar_mobile/src/presentation/bloc/profile/profile_bloc.dart';
import 'core/connectivity/internet_connection_checker.dart';
import 'core/platform/network_info.dart';
import 'data/source/local_source.dart';
import 'domain/repositories/user_repo/user_repository.dart';
import 'presentation/bloc/auth/forgot_password/forgot_password_bloc.dart';
import 'presentation/bloc/auth/register/register_bloc.dart';
import 'presentation/bloc/home/home_bloc.dart';
import 'presentation/bloc/home/home_detail/home_detail_bloc.dart';
import 'presentation/bloc/main/main_bloc.dart';
import 'presentation/bloc/questionnaire/questionnaire_bloc.dart';
import 'package:telegram_bot_crashlytics/telegram_bot_crashlytics.dart';

final sl = GetIt.instance;
late Box<dynamic> _box;

final telegramCrashlytics = TelegramBotCrashlytics(
  botToken: '7579047843:AAGN_-Wg5NIzeva1wa3p-W26r409LOYW_1A',
  chatId: 941120745,
  ignoreStatusCodes: [400, 403],
  includeHeaders: true,
);

Future<void> init() async {
  /// External
  await initHive();
  sl.registerSingleton<LocalSource>(LocalSource(_box));

  // Register Dio with Retry Interceptor and other configurations
  sl.registerLazySingleton(
    () => Dio()
      ..options = BaseOptions(
        contentType: 'application/json',
        sendTimeout: const Duration(seconds: 50),
        receiveTimeout: const Duration(seconds: 50),
        connectTimeout: const Duration(seconds: 50),
        headers: {
          'X-User-Language': {
                'uz': 'UZ_LATIN',
                'ru': 'RU',
                'oz': 'UZ_CYRIL',
              }[localSource.locale] ??
              'UZ_LATIN'
        },
      )
      ..interceptors.addAll([
        LogInterceptor(
          requestBody: kDebugMode,
          responseBody: kDebugMode,
          logPrint: (object) => kDebugMode ? log('dio: $object') : null,
        ),
        telegramCrashlytics.interceptor,
        if (localSource.chuck) chuck.getDioInterceptor(),
      ]),
  );

  sl<Dio>().interceptors.add(
        RetryInterceptor(
          dio: sl<Dio>(),
          toNoInternetPageNavigator: () async {
            final lastMatch = router.routerDelegate.currentConfiguration.last;
            final matchList =
                lastMatch is ImperativeRouteMatch ? lastMatch.matches : router.routerDelegate.currentConfiguration;
            final String location = matchList.uri.toString();
            if (location.contains(Routes.internetConnection)) return;
            await router.pushNamed(Routes.internetConnection);
          },
          accessTokenGetter: () => localSource.accessToken,
          refreshTokenFunction: () async {
            if (localSource.accessToken.isEmpty) return;
            await sl<AuthRepository>().refreshToken().then(
              (v) async {
                if (v.isLeft) {
                  await localSource.clear().then((v) => rootNavigatorKey.currentContext!.goNamed(Routes.auth));
                }
              },
            );
          },
          logPrint: (object) {
            if (kDebugMode) log('dio: $object');
          },
        ),
      );

  // Registering various features
  sl
    ..registerLazySingleton(
      () => InternetConnectionChecker.createInstance(
        checkInterval: const Duration(seconds: 3),
      ),
    )
    ..registerSingletonAsync(PackageInfo.fromPlatform)
    ..registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  // Registering all features
  mainFeature();
  homeFeature();
  filterFeature();
  likeFeature();
  homeDetailFeature();
  questionnaireFeature();
  imageFeature();
  authFeature();
  chatFeature();
  profileFeature();
}

void mainFeature() {
  sl.registerLazySingleton(MainBloc.new);
}

void homeFeature() {
  sl
    ..registerFactory<HomeBloc>(() => HomeBloc(sl(), sl()))
    ..registerLazySingleton<UserRepository>(() => UserRepositoryImpl(dio: sl()));
}

void filterFeature() {
  sl.registerLazySingleton<FilterBloc>(() => FilterBloc(sl()));
}

void likeFeature() {
  sl
    ..registerFactory<LikeBloc>(() => LikeBloc(sl()))
    ..registerLazySingleton<LikeRepository>(() => LikeRepositoryImpl(dio: sl()));
}

void homeDetailFeature() {
  sl.registerFactory<HomeDetailBloc>(() => HomeDetailBloc(homeRepository: sl(), imageRepository: sl()));
}

void questionnaireFeature() {
  sl.registerSingleton<QuestionnaireBloc>(QuestionnaireBloc(sl()));
}

void imageFeature() {
  sl
    ..registerFactory<ImageUploadBloc>(() => ImageUploadBloc(sl()))
    ..registerLazySingleton<ImageRepository>(() => ImageRepositoryImpl(dio: sl()));
}

void authFeature() {
  sl
    ..registerFactory(() => LoginBloc(sl()))
    ..registerFactory(() => RegisterBloc(sl()))
    ..registerFactory(() => OtpBloc(sl()))
    ..registerFactory(() => ForgotPasswordBloc(sl()))
    ..registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(dio: sl()));
}

void chatFeature() {
  sl
    ..registerFactory(() => UserBloc(sl()))
    ..registerFactory(() => ChatBloc(sl(), sl()))
    ..registerLazySingleton<ChatRepository>(() => ChatRepositoryImpl(dio: sl()));
}

void profileFeature() {
  sl
    ..registerFactory(() => ProfileBloc(sl()))
    ..registerLazySingleton<ProfileRepository>(() => ProfileRepositoryImpl(dio: sl()));
}

Future<void> initHive() async {
  const boxName = 'bloc_mobile_box';
  final Directory directory = await getApplicationDocumentsDirectory();
  Hive.init(directory.path);
  _box = await Hive.openBox<dynamic>(boxName);
}
