import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

class CustomPinPut extends StatelessWidget {
  const CustomPinPut({
    super.key,
    this.onComplete,
    this.controller,
  });

  final void Function(String)? onComplete;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) => Pinput(
        mainAxisAlignment: MainAxisAlignment.center,
        length: 4,
        autofocus: true,
        controller: controller,
        // androidSmsAutofillMethod: AndroidSmsAutofillMethod.smsUserConsentApi,
        // listenForMultipleSmsOnAndroid: true,
        hapticFeedbackType: HapticFeedbackType.lightImpact,
        // defaultPinTheme: defaultPinTheme,
        // submittedPinTheme: defaultPinTheme,
        // focusedPinTheme: defaultPinTheme.copyWith(
        //   decoration: BoxDecoration(
        //     color: context.colorScheme.background,
        //     borderRadius: const BorderRadius.all(Radius.circular(12)),
        //     border: Border.all(color: context.colorScheme.primary),
        //   ),
        // ),
        // errorPinTheme: defaultPinTheme.copyWith(
        //   decoration: BoxDecoration(
        //     color: context.colorScheme.background,
        //     borderRadius: const BorderRadius.all(Radius.circular(12)),
        //     border: Border.all(color: context.colorScheme.error),
        //   ),
        // ),

        onCompleted: onComplete,
      );
}
