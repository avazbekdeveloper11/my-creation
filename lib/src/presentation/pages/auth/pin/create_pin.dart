import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sovchilar_mobile/src/config/router/app_routes.dart';
import 'package:sovchilar_mobile/src/core/extension/extension.dart';
import 'package:sovchilar_mobile/src/presentation/pages/auth/pin/pin_screen.dart';
import 'package:sovchilar_mobile/src/presentation/pages/main/main_page.dart';

class CreatePinCode extends StatefulWidget {
  const CreatePinCode({super.key});

  @override
  State<CreatePinCode> createState() => _CreatePinCodeState();
}

class _CreatePinCodeState extends State<CreatePinCode> {
  String pin = '';
  int step = 0;
  String? warningText;

  @override
  Widget build(BuildContext context) => Scaffold(
        resizeToAvoidBottomInset: true,
        body: Container(
          child: pin == ''
              ? PinScreen(
                  onCheck: (pin) => true,
                  onComplete: _newPinCompleted,
                  onCancel: _newPinCancelled,
                  warningText: warningText,
                  title: 'create_pin_code'.tr(),
                  type: '',
                )
              : PinScreen(
                  onCheck: _checkConfirmPassword,
                  onComplete: (v) {
                    step = 2;
                    localSource
                      ..setPinCode(pinCode: v)
                      ..setHasProfile(value: true);
                    context.push(Routes.main, extra: MainArgs());
                  },
                  onCancel: _confirmPinCancelled,
                  warningText: warningText,
                  title: 'confirm_pin'.tr(),
                  type: '',
                ),
        ),
      );

  void _newPinCompleted(String val) {
    step = 1;
    setState(() {
      pin = val;
    });
  }

  void _confirmPinCancelled() {
    step = 0;
    setState(() {
      pin = '';
    });
  }

  bool _checkConfirmPassword(String val) {
    final result = pin == val;
    if (!result) {
      setState(() {
        warningText = 'create_pin'.tr();
      });
    } else {
      setState(() {
        warningText = null;
      });
    }
    return result;
  }

  void _newPinCancelled() {}
}
