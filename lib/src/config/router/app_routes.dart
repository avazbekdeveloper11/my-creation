import 'package:chuck_interceptor/chuck.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:sovchilar_mobile/src/core/pages/others/error/error_page.dart';
import 'package:sovchilar_mobile/src/core/pages/others/internet_connection/internet_connection_page.dart';
import 'package:sovchilar_mobile/src/data/models/chat/chat_model.dart';
import 'package:sovchilar_mobile/src/data/models/home/user_model.dart';
import 'package:sovchilar_mobile/src/data/models/profile/profile_model.dart';
import 'package:sovchilar_mobile/src/data/source/local_source.dart';
import 'package:sovchilar_mobile/src/injector_container.dart';
import 'package:sovchilar_mobile/src/presentation/bloc/auth/forgot_password/forgot_password_bloc.dart';
import 'package:sovchilar_mobile/src/presentation/bloc/auth/login/login_bloc.dart';
import 'package:sovchilar_mobile/src/presentation/bloc/auth/otp/otp_bloc.dart';
import 'package:sovchilar_mobile/src/presentation/bloc/auth/register/register_bloc.dart';
import 'package:sovchilar_mobile/src/presentation/bloc/chat/chat_bloc.dart';
import 'package:sovchilar_mobile/src/presentation/bloc/user/user_bloc.dart';
import 'package:sovchilar_mobile/src/presentation/bloc/filter/filter_bloc.dart';
import 'package:sovchilar_mobile/src/presentation/bloc/home/home_bloc.dart';
import 'package:sovchilar_mobile/src/presentation/bloc/home/home_detail/home_detail_bloc.dart';
import 'package:sovchilar_mobile/src/presentation/bloc/image/image_upload_bloc.dart';
import 'package:sovchilar_mobile/src/presentation/bloc/like/like_bloc.dart';
import 'package:sovchilar_mobile/src/presentation/bloc/profile/profile_bloc.dart';
import 'package:sovchilar_mobile/src/presentation/bloc/questionnaire/questionnaire_bloc.dart';
import 'package:sovchilar_mobile/src/presentation/pages/auth/forgot%20password/forgot_otp.dart';
import 'package:sovchilar_mobile/src/presentation/pages/auth/forgot%20password/forgot_password_page.dart';
import 'package:sovchilar_mobile/src/presentation/pages/auth/login/login_page.dart';
import 'package:sovchilar_mobile/src/presentation/pages/auth/otp/otp_page.dart';
import 'package:sovchilar_mobile/src/presentation/pages/auth/pin/create_pin.dart';
import 'package:sovchilar_mobile/src/presentation/pages/auth/pin/verify_pin_code.dart';
import 'package:sovchilar_mobile/src/presentation/pages/auth/register/register_page.dart';
import 'package:sovchilar_mobile/src/presentation/pages/home/filter/filter_page.dart';
import 'package:sovchilar_mobile/src/presentation/pages/home/home_detail/home_detail_page.dart';
import 'package:sovchilar_mobile/src/presentation/pages/main/main_page.dart';
import 'package:sovchilar_mobile/src/presentation/pages/profile/create_questionnaire/create_questionnaire_page.dart';
import 'package:sovchilar_mobile/src/presentation/pages/profile/edit_profile/edit_profile_page.dart';
import 'package:sovchilar_mobile/src/presentation/pages/profile/image_upload/image_upload_page.dart';
import 'package:sovchilar_mobile/src/presentation/pages/profile/settings/settings_page.dart';
import 'package:sovchilar_mobile/src/presentation/pages/splash/splash_page.dart';
import 'package:sovchilar_mobile/src/presentation/pages/user/chat/chat_page.dart';

part 'name_routes.dart';

final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();

final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

final localSource = sl<LocalSource>();

final packageInfo = sl<PackageInfo>();

final Chuck chuck = Chuck(navigatorKey: rootNavigatorKey);

final GoRouter router = GoRouter(
  navigatorKey: rootNavigatorKey,
  initialLocation: Routes.initial,
  errorBuilder: (_, state) => ErrorPage(state: state),
  routes: <RouteBase>[
    GoRoute(
      path: Routes.initial,
      name: Routes.initial,
      builder: (_, __) => const SplashPage(),
    ),
    GoRoute(
      path: Routes.internetConnection,
      name: Routes.internetConnection,
      builder: (_, __) => const InternetConnectionPage(),
    ),
    GoRoute(
      name: Routes.main,
      path: Routes.main,
      pageBuilder: (_, state) => CustomTransitionPage(
        transitionDuration: const Duration(milliseconds: 800),
        child: MultiBlocProvider(
          providers: [
            BlocProvider<HomeBloc>(
              create: (_) => sl<HomeBloc>()
                ..add(
                  GetUsersEvent(filter: localSource.filter),
                ),
            ),
            BlocProvider<LikeBloc>(
              create: (_) => sl<LikeBloc>()..add(GetLikesEvent()),
            ),
            BlocProvider(create: (_) => sl<ImageUploadBloc>()..add(GetImageUrlEvent())),
            BlocProvider(create: (_) => sl<UserBloc>()..add(GetChatUsersEvent())),
            BlocProvider(create: (_) => sl<ProfileBloc>()..add(GetProfileEvent(isCache: true))),
          ],
          child: MainPage(args: (state.extra as MainArgs?)),
        ),
        transitionsBuilder: (_, animation, __, child) => FadeTransition(
          opacity: CurveTween(curve: Curves.easeInOutCirc).animate(animation),
          child: child,
        ),
      ),
    ),
    GoRoute(
      path: Routes.auth,
      name: Routes.auth,
      builder: (_, __) => BlocProvider(
        create: (context) => sl<LoginBloc>(),
        child: LoginPage(),
      ),
    ),
    GoRoute(
      path: Routes.register,
      name: Routes.register,
      builder: (_, __) => BlocProvider(
        create: (context) => sl<RegisterBloc>()..add(GetPrivacy()),
        child: RegisterPage(),
      ),
    ),
    GoRoute(
      path: Routes.userDetailScreen,
      name: Routes.userDetailScreen,
      builder: (context, state) => BlocProvider(
        create: (_) => sl<HomeDetailBloc>()
          ..add(GetProfileDetailImage(profileId: (state.extra as UserModel?)?.id ?? ''))
          ..add(GetHomeDetailEvent(uuid: (state.extra as UserModel?)?.id ?? ''))
          ..add(PostViewedEvent(userModel: state.extra as UserModel?)),
        child: HomeDetailsPage(),
      ),
    ),
    GoRoute(
      path: Routes.settings,
      name: Routes.settings,
      builder: (_, __) => BlocProvider(
        create: (context) => sl<ChatBloc>(),
        child: SettingsPage(),
      ),
    ),
    GoRoute(
      path: Routes.pinCode,
      name: Routes.pinCode,
      builder: (_, __) => const VerifyPinPage(),
    ),
    GoRoute(
      path: Routes.createPinCode,
      name: Routes.createPinCode,
      builder: (_, __) => const CreatePinCode(),
    ),
    GoRoute(
      path: Routes.filter,
      name: Routes.filter,
      builder: (_, __) => BlocProvider.value(
        value: sl<FilterBloc>(),
        child: FilterScreen(),
      ),
    ),
    GoRoute(
      path: Routes.createQuestionnaire,
      name: Routes.createQuestionnaire,
      builder: (_, __) => CreateQuestionnairePage(),
    ),
    GoRoute(
      path: Routes.otpPage,
      name: Routes.otpPage,
      builder: (_, state) => BlocProvider(
        create: (context) => sl<OtpBloc>()
          ..add(GetConfigEvent())
          ..add(
            SendOtpEvent(
              (state.extra as String)
                  .replaceAll('+', '')
                  .replaceFirst('(', '')
                  .replaceFirst(')', '')
                  .replaceAll(' ', '')
                  .replaceAll('-', ''),
            ),
          ),
        child: OtpPage(phone: state.extra as String),
      ),
    ),
    GoRoute(
      path: Routes.forgotOtp,
      name: Routes.forgotOtp,
      builder: (_, state) => BlocProvider.value(
        value: sl<ForgotPasswordBloc>()
          ..add(
            GetConfigForgotEvent(
              (state.extra as String)
                  .replaceFirst('(', '')
                  .replaceFirst(')', '')
                  .replaceFirst(' ', '')
                  .replaceAll('-', ''),
            ),
          ),
        child: ForgotOtp(phone: state.extra as String),
      ),
    ),
    GoRoute(
      path: Routes.imageUpload,
      name: Routes.imageUpload,
      builder: (_, state) => BlocProvider(
        create: (context) => sl<ImageUploadBloc>()..add(GetImageUrlEvent()),
        child: ImageUploadScreen(photoLimit: (state.extra as int?) ?? 0),
      ),
    ),
    GoRoute(
      path: Routes.editProfile,
      name: Routes.editProfile,
      builder: (_, state) => BlocProvider.value(
        value: sl<QuestionnaireBloc>(),
        child: EditProfilePage(profile: state.extra as ProfileModel),
      ),
    ),
    GoRoute(
      path: Routes.forgotPassword,
      name: Routes.forgotPassword,
      builder: (_, __) => BlocProvider(
        create: (_) => sl<ForgotPasswordBloc>(),
        child: ForgotPasswordPage(),
      ),
    ),
    GoRoute(
      path: Routes.chat,
      name: Routes.chat,
      builder: (_, state) => BlocProvider(
        create: (context) => sl<ChatBloc>(),
        child: ChatPage(
          userId: (state.extra as MatchesModel?)?.oppositeProfile?.user?.id ?? '',
          profileId: (state.extra as MatchesModel?)?.oppositeProfile?.id ?? '',
          name: (state.extra as MatchesModel?)?.oppositeProfile?.name ?? '',
          status: (state.extra as MatchesModel?)?.status ?? '',
          roomId: (state.extra as MatchesModel?)?.id ?? '',
          profilePictureType: (state.extra as MatchesModel?)?.oppositeProfile?.profilePictureType ?? '',
          createdDateTime: (state.extra as MatchesModel?)?.updatedDate ?? '',
          chatId: (state.extra as MatchesModel?)?.chat?.chatId ?? '',
          chatEndHour: (state.extra as MatchesModel?)?.chatDurationInHour ?? 0,
        ),
      ),
    ),
  ],
);
