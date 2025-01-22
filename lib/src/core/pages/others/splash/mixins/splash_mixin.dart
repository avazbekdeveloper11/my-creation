// part of '../splash_page.dart';
//
// mixin SplashMixin on State<SplashPage> {
//   @override
//   void initState() {
//     super.initState();
//   }
//
//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//     // unawaited(
//     //   RemoteConfigService.isCallCheckAppVersion(context).then(
//     //     (value) {
//     //       if (value != AppUpdate.none) {
//     //         appUpdateBottomSheet(isForceUpdate: value == AppUpdate.forceUpdate)
//     //             .then(
//     //           (value) {
//     //             nextToNavigation();
//     //           },
//     //         );
//     //       } else {
//     //         nextToNavigation();
//     //       }
//     //     },
//     //   ),
//     // );
//   }
//
//   Future<void> appUpdateBottomSheet({
//     required bool isForceUpdate,
//   }) async {
//     await customModalBottomSheet<bool>(
//       context: context,
//       enableDrag: false,
//       builder: (_, controller) => AppUpdateBottomSheetWidget(
//         onTap: () async {
//           context.pop();
//         },
//         isForceUpdate: isForceUpdate,
//       ),
//     );
//   }
// }
