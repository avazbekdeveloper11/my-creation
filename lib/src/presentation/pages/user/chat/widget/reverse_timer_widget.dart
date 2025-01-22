// import 'dart:async';
// import 'dart:ui';
//
// import 'package:flutter/material.dart';
// import 'package:sovchilar_mobile/src/core/extension/extension.dart';
//
// class ReverseTimerWidget extends StatefulWidget {
//   final String chatCreatedTime;
//   final int totalHours;
//
//   const ReverseTimerWidget({
//     super.key,
//     required this.chatCreatedTime,
//     required this.totalHours,
//   });
//
//   @override
//   State<ReverseTimerWidget> createState() => _ReverseTimerWidgetState();
// }
//
// class _ReverseTimerWidgetState extends State<ReverseTimerWidget> {
//   late DateTime createdTime;
//   late Duration totalDuration;
//   Timer? timer;
//   Duration remainingTime = Duration.zero;
//
//   @override
//   void initState() {
//     super.initState();
//
//     createdTime = DateTime.parse(widget.chatCreatedTime);
//     totalDuration = Duration(hours: widget.totalHours - 5);
//
//     _updateRemainingTime();
//     timer = Timer.periodic(Duration(seconds: 1), (_) => _updateRemainingTime());
//   }
//
//   void _updateRemainingTime() {
//     final elapsedTime = DateTime.now().difference(createdTime);
//     final newRemainingTime = totalDuration - elapsedTime;
//
//     setState(() {
//       remainingTime = newRemainingTime.isNegative ? Duration.zero : newRemainingTime;
//     });
//
//     if (remainingTime <= Duration.zero) {
//       timer?.cancel();
//     }
//   }
//
//   @override
//   void dispose() {
//     timer?.cancel();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final hours = remainingTime.inHours;
//     final minutes = remainingTime.inMinutes.remainder(60);
//
//     Color textColor;
//
//     if (remainingTime.inMinutes <= 10) {
//       textColor = Colors.red;
//     } else if (remainingTime.inMinutes <= 30) {
//       textColor = Colors.amber.shade800;
//     } else {
//       textColor = Colors.black;
//     }
//
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Text(
//           'end_time'.tr(),
//           style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
//         ),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(
//               hours.toString().padLeft(2, '0'),
//               style: TextStyle(
//                 fontSize: 14,
//                 fontWeight: FontWeight.w500,
//                 color: textColor,
//               ),
//             ),
//             Text(
//               'hour'.tr(),
//               style: TextStyle(
//                 fontSize: 12,
//                 fontWeight: FontWeight.w500,
//                 color: textColor,
//               ),
//             ),
//             Text(
//               minutes.toString().padLeft(2, '0'),
//               style: TextStyle(
//                 fontSize: 14,
//                 fontWeight: FontWeight.w500,
//                 color: textColor,
//               ),
//             ),
//             Text(
//               'minute'.tr(),
//               style: TextStyle(
//                 fontSize: 12,
//                 fontWeight: FontWeight.w500,
//                 color: textColor,
//               ),
//             ),
//           ],
//         ),
//       ],
//     );
//   }
// }
