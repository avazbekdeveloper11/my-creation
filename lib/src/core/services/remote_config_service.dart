// import 'dart:convert';
// import 'dart:developer';
// import 'dart:io';
// import 'package:firebase_remote_config/firebase_remote_config.dart';
// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import 'package:package_info_plus/package_info_plus.dart';
//
// import '../../config/router/app_routes.dart';
// import '../../injector_container.dart';
// import '../extension/extension.dart';
// import '../platform/network_info.dart';
//
// sealed class RemoteConfigService {
//   RemoteConfigService._();
//
//   static FirebaseRemoteConfig remoteConfig = FirebaseRemoteConfig.instance;
//
//   static Future<AppUpdate> isCallCheckAppVersion(
//     BuildContext context,
//   ) async {
//     if (await sl<NetworkInfo>().isConnected) {
//       try {
//         final packageInfo = await PackageInfo.fromPlatform();
//         await remoteConfig.setConfigSettings(
//           RemoteConfigSettings(
//             fetchTimeout: Duration.zero,
//             minimumFetchInterval: Duration.zero,
//           ),
//         );
//         await remoteConfig.fetchAndActivate();
//         RemoteConfigValue? version;
//         if (Platform.isAndroid) {
//           version = remoteConfig.getAll()[TargetPlatform.android.name];
//         } else {
//           version = remoteConfig.getAll()[TargetPlatform.iOS.name];
//         }
//         final isNotLast = isNotLastVersion(packageInfo.version, version);
//         return isNotLast;
//       } on Exception catch (e, s) {
//         log('Firebase initialize error: $e $s');
//         return AppUpdate.none;
//       }
//     } else {
//       return context.pushNamed(Routes.internetConnection).then((value) => isCallCheckAppVersion(context));
//     }
//   }
//
//   static AppUpdate isNotLastVersion(
//     String packageInfo,
//     RemoteConfigValue? employeeVersion,
//   ) {
//     if (employeeVersion == null) return AppUpdate.none;
//     final Map<String, dynamic> employeeVersionMap = jsonDecode(employeeVersion.asString());
//     final String version = employeeVersionMap['version'];
//     final bool isForce = employeeVersionMap['is_force'];
//     final int employee = version.replaceAll('.', '').toVersion;
//     final int package = packageInfo.replaceAll('.', '').toVersion;
//     if (package < employee && isForce) return AppUpdate.forceUpdate;
//     if (package < employee && !isForce) return AppUpdate.softUpdate;
//     return AppUpdate.none;
//   }
// }
//
// enum AppUpdate { forceUpdate, softUpdate, none }
