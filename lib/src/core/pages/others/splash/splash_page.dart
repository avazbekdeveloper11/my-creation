// import 'dart:async';
//
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:go_router/go_router.dart';
// import 'package:sovchilar_mobile/src/config/router/app_routes.dart';
// import 'package:sovchilar_mobile/src/config/themes/themes.dart';
// import 'package:sovchilar_mobile/src/presentation/pages/components/bottom_sheet/custom_bottom_sheet.dart';
// import 'package:sovchilar_mobile/src/presentation/pages/components/bottom_sheet/update_app_sheet.dart';
// import 'package:sovchilar_mobile/src/presentation/pages/components/loading_widgets/staggered_dots_wave.dart';
// import 'package:url_launcher/url_launcher.dart';
// import '../../../../core/constants/constants.dart';
// import '../../../../core/extension/extension.dart';
// import '../../../../core/utils/utils.dart';
//
// part 'mixins/splash_mixin.dart';
//
// class SplashPage extends StatefulWidget {
//   const SplashPage({super.key});
//
//   @override
//   State<SplashPage> createState() => _SplashPageState();
// }
//
// class _SplashPageState extends State<SplashPage> with SplashMixin {
//   @override
//   Widget build(BuildContext context) => AnnotatedRegion<SystemUiOverlayStyle>(
//         value: SystemUiOverlayStyle.light,
//         child: Scaffold(
//           backgroundColor: context.theme.primaryColor,
//           body: const Stack(
//             children: [
//               Align(
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     Icon(
//                       AppIcons.main,
//                       color: Colors.white,
//                       size: 48,
//                     ),
//                     AppUtils.kGap8,
//                     Text(
//                       'MEDPAY',
//                       style: TextStyle(
//                         fontSize: 36,
//                         color: Colors.white,
//                         fontWeight: FontWeight.w900,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               Positioned(
//                 bottom: 80,
//                 left: 0,
//                 right: 0,
//                 child: Center(
//                   child: StaggeredDotsWave(
//                     color: Colors.white,
//                     size: 48,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       );
// }
