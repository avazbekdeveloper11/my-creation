import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:sovchilar_mobile/src/config/themes/themes.dart';
import 'package:sovchilar_mobile/src/presentation/pages/components/app_text/app_text.dart';
import 'package:sovchilar_mobile/src/config/router/app_routes.dart';
import 'package:sovchilar_mobile/src/core/constants/constants.dart';
import 'package:sovchilar_mobile/src/core/extension/extension.dart';
import 'package:sovchilar_mobile/src/data/models/auth/app_version_model.dart';
import 'package:sovchilar_mobile/src/presentation/pages/components/bottom_sheet/custom_bottom_sheet.dart';
import 'package:sovchilar_mobile/src/presentation/pages/components/bottom_sheet/update_app_sheet.dart';
import 'package:sovchilar_mobile/src/presentation/pages/components/native_splash/flutter_native_splash.dart';

part 'mixins/splash_mixin.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with SplashMixin {
  @override
  Widget build(BuildContext context) => Scaffold(
        body: Center(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 50.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Spacer(),
                Lottie.asset('assets/lottie/heart.json', width: 140.sp, height: 140.sp, fit: BoxFit.cover),
                ShaderMask(
                  blendMode: BlendMode.srcIn,
                  shaderCallback: (bounds) => LinearGradient(
                    colors: gradientColors,
                  ).createShader(bounds),
                  child: AppText(
                    Constants.appName,
                    maxLines: 2,
                    size: 34.sp,
                    fontFamily: 'Lexend',
                    textAlign: TextAlign.center,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Spacer(),
                SafeArea(
                  child: Text(
                    packageInfo.version.toString(),
                    style: TextStyle(fontWeight: FontWeight.w400),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}
