import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:sovchilar_mobile/src/config/router/app_routes.dart';
import 'package:sovchilar_mobile/src/core/extension/extension.dart';
import 'package:sovchilar_mobile/src/presentation/pages/auth/pin/pin_screen.dart';
import 'package:sovchilar_mobile/src/presentation/pages/main/main_page.dart';

class VerifyPinPage extends StatefulWidget {
  const VerifyPinPage({super.key, this.checkBio});

  final String? checkBio;

  @override
  State<VerifyPinPage> createState() => _VerifyPinPageState();
}

class _VerifyPinPageState extends State<VerifyPinPage> {
  // final LocalAuthentication _auth = LocalAuthentication();
  int _step = 1;
  String? _pin = '';
  bool? check;

  @override
  void initState() {
    _pin = localSource.pinCode;
    // _authenticateWithBiometrics();
    super.initState();
  }

  // Future<void> _authenticateWithBiometrics() async {
  //   try {
  //     final isAvailable = await _auth.canCheckBiometrics;
  //     if (isAvailable) {
  //       final didAuthenticate = await _auth.authenticate(
  //         localizedReason: 'Biometrik autentifikatsiya orqali kirishingiz mumkin',
  //         options: const AuthenticationOptions(
  //           biometricOnly: true,
  //         ),
  //       );
  //       if (didAuthenticate) {
  //         log('Biometric authentication successful.');
  //         // if (localSource.hasImage) {
  //         context.go(Routes.main, extra: MainArgs(isShoDialog: true));
  //         // } else {
  //         //   context.pushReplacement(Routes.imageUpload);
  //         // }
  //       }
  //     }
  //   } catch (e) {
  //     log('Biometric authentication failed: $e');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: PinScreen(
          onCheck: checkConfirmPassword,
          onComplete: (text) => handleConfirmPinCompleted(text, context),
          onCancel: handleConfirmPinCancelled,
          title: 'enter_pin_code'.tr(),
          type: widget.checkBio,
          warningText: _step != 1 ? setWarningText(warningText: 'pin_code_incorrect'.tr()) : null,
        ),
      ),
    );
  }

  String setWarningText({required String warningText}) => warningText.replaceAll('###', '${4 - _step}');

  bool checkConfirmPassword(String pin) {
    final result = _pin == pin;
    setState(() {});
    return result;
  }

  void handleConfirmPinCompleted(String text, BuildContext context) {
    context.push(Routes.main, extra: MainArgs());
  }

  void handleConfirmPinCancelled() {
    if (_step < 3) {
      _step++;
    } else {
      localSource.clear();
      context.pushReplacement(Routes.auth);
    }
  }

  @override
  void dispose() {
    _step = 1;
    super.dispose();
  }
}
