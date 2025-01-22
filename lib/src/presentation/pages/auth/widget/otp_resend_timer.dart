import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sovchilar_mobile/src/core/extension/extension.dart';

class OTPResendTimer extends StatefulWidget {
  final int initialSeconds;

  final VoidCallback onResend;

  const OTPResendTimer({
    super.key,
    required this.initialSeconds,
    required this.onResend,
  });

  @override
  State<OTPResendTimer> createState() => _OTPResendTimerState();
}

class _OTPResendTimerState extends State<OTPResendTimer> {
  late int remainingSeconds;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    remainingSeconds = widget.initialSeconds;
    startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (remainingSeconds > 0) {
          remainingSeconds--;
        } else {
          timer.cancel();
        }
      });
    });
  }

  void handleResend() {
    if (remainingSeconds == 0) {
      widget.onResend();

      setState(() {
        remainingSeconds = widget.initialSeconds;
        startTimer();
      });
    }
  }

  String formatTime(int seconds) {
    final minutes = (seconds ~/ 60).toString().padLeft(2, '0');
    final secs = (seconds % 60).toString().padLeft(2, '0');
    return "$minutes:$secs";
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        remainingSeconds > 0
            ? Text(
                "${"resend_in".tr()} ${formatTime(remainingSeconds)}",
                style: const TextStyle(fontSize: 14),
              )
            : GestureDetector(
                onTap: handleResend,
                child: Text(
                  'resend_sms'.tr(),
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 12.sp,
                  ),
                ),
              ),
      ],
    );
  }
}
