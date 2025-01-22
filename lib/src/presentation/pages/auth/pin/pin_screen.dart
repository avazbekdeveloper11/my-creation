import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sovchilar_mobile/src/config/themes/themes.dart';

import '../../components/app_text/app_text.dart';

class PinScreen extends StatefulWidget {
  const PinScreen({
    super.key,
    required this.title,
    required this.onCheck,
    required this.onComplete,
    required this.onCancel,
    this.warningText,
    this.type,
    this.route,
  });

  final String title;
  final bool Function(String pin) onCheck;
  final void Function(String text) onComplete;
  final void Function() onCancel;
  final String? warningText;
  final String? type;
  final String? route;

  @override
  State<PinScreen> createState() => _PinScreenState();
}

double keyBoardSize = 50.sp;

class _PinScreenState extends State<PinScreen> {
  int pinIndex = 0;
  List<String> currentPin = ['', '', '', ''];

  bool bioAuthState = false;

  TextEditingController pinFirstController = TextEditingController();
  TextEditingController pinSecondController = TextEditingController();
  TextEditingController pinThirdController = TextEditingController();
  TextEditingController pinFourthController = TextEditingController();

  OutlineInputBorder outlineInputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(20), borderSide: const BorderSide(color: Colors.black38, width: 4));

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Flexible(
                flex: 3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 30.w),
                      child: AppText(widget.title,
                          size: 26.sp, fontWeight: FontWeight.bold, textAlign: TextAlign.center, maxLines: 2),
                    ),
                    SizedBox(height: 10.h),
                    _buildWarningText(widget.warningText ?? ''),
                    SizedBox(height: 20.h)
                  ],
                ),
              ),
              Flexible(
                flex: 7,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [_buildPinRow(), SizedBox(height: 30.h), _buildNumberPad()],
                  ),
                ),
              )
            ],
          ),
        ),
      );

  Padding _buildWarningText(String warningText) => Padding(
        padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 20.w),
        child: Text(
          warningText,
          textAlign: TextAlign.center,
          style: const TextStyle(color: AppColor.errorColor),
        ),
      );

  Padding _buildNumberPad() => Padding(
        padding: EdgeInsets.symmetric(vertical: 18.h, horizontal: 10.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                KeyboardNumber(n: 1, onPressed: () => pinSetupIndex('1')),
                KeyboardNumber(n: 2, onPressed: () => pinSetupIndex('2')),
                KeyboardNumber(n: 3, onPressed: () => pinSetupIndex('3')),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                KeyboardNumber(n: 4, onPressed: () => pinSetupIndex('4')),
                KeyboardNumber(n: 5, onPressed: () => pinSetupIndex('5')),
                KeyboardNumber(n: 6, onPressed: () => pinSetupIndex('6')),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                KeyboardNumber(n: 7, onPressed: () => pinSetupIndex('7')),
                KeyboardNumber(n: 8, onPressed: () => pinSetupIndex('8')),
                KeyboardNumber(n: 9, onPressed: () => pinSetupIndex('9')),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // widget.route != Routes.changePinPage
                //     ? _buildBiometricButton()
                //     : SizedBox(width: 70.w, height: 70.h),
                SizedBox(height: 64.sp, width: 64.sp),
                KeyboardNumber(n: 0, onPressed: () => pinSetupIndex('0')),
                _buildRemoveButton()
              ],
            ),
          ],
        ),
      );

  // _buildBiometricButton() {
  //   return SizedBox(
  //     width: 70.w,
  //     height: 70.h,
  //     child: (bioAuthState && widget.type == Constants.verifyPinPage)
  //         ? PushableButton(
  //             height: 66.h,
  //             onPressed: () {
  //               SharedPrefsProvider().saveBoolValue('checkBioDialog', true);
  //               ScreenLock().authenticateUser(path: Constants.verifyPinPage);
  //             },
  //             shadow: BoxShadow(
  //               color: Colors.grey..withValue(alpha: (0.5),
  //               spreadRadius: -4,
  //               blurRadius: 3,
  //               offset: const Offset(0, 3),
  //             ),
  //             elevation: 5,
  //             hslColor: HSLColor.fromColor(AppColor.white),
  //             child: const Icon(Icons.fingerprint,
  //                 color: AppColor.bottomNavColor, size: 30),
  //           )
  //         : const SizedBox(),
  //   );
  // }

  Widget _buildRemoveButton() => pinIndex != 0
      ? Container(
          width: 64.sp,
          height: 64.sp,
          decoration: BoxDecoration(
              // gradient: LinearGradient(colors: gradientColors),
              borderRadius: BorderRadius.circular(100),
              border: Border.all(color: gradientColors[1], width: 2)),
          child: MaterialButton(
            onPressed: removeIndex,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
            // shadow: BoxShadow(
            //   color: Colors.grey..withValue(alpha: (0.5),
            //   spreadRadius: -4,
            //   blurRadius: 3,
            //   offset: const Offset(0, 3),
            // ),
            elevation: 5,
            child: const Icon(
              Icons.keyboard_backspace,
              color: AppColor.textColor,
              size: 30,
              semanticLabel: 'Remove',
            ),
          ),
        )
      : SizedBox(width: 64.sp, height: 64.sp);

  void removeIndex() {
    if (pinIndex > 0) {
      setPin(pinIndex, '');
      setState(() {
        pinIndex--;
      });
    }
  }

  void setPin(int pinIndex, String text) {
    switch (pinIndex) {
      case 1:
        pinFirstController.text = text;
      case 2:
        pinSecondController.text = text;
      case 3:
        pinThirdController.text = text;
      case 4:
        pinFourthController.text = text;
    }
  }

  void removeAll() {
    setPin(1, '');
    setPin(2, '');
    setPin(3, '');
    setPin(4, '');
    setState(() {
      pinIndex = 0;
    });
  }

  Padding _buildPinRow() => Padding(
        padding: EdgeInsets.symmetric(horizontal: 50.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            PinNumber(textEditingController: pinFirstController, outlineInputBorder: outlineInputBorder),
            PinNumber(textEditingController: pinSecondController, outlineInputBorder: outlineInputBorder),
            PinNumber(textEditingController: pinThirdController, outlineInputBorder: outlineInputBorder),
            PinNumber(textEditingController: pinFourthController, outlineInputBorder: outlineInputBorder),
          ],
        ),
      );

  void pinSetupIndex(String number) {
    if (pinIndex < 4) {
      setState(() {
        pinIndex++;
      });
      setPin(pinIndex, number);
      currentPin[pinIndex - 1] = number;
      var strPin = '';
      for (final element in currentPin) {
        strPin = element;
      }
      if (pinIndex == 4) {
        onCompleted(strPin);
      }
    }
  }

  void onCompleted(String strPin) {
    log('Completed => $strPin');
    Future.delayed(const Duration(milliseconds: 500), () {
      removeAll();
      if (widget.onCheck(strPin)) {
        widget.onComplete(strPin);
      } else {
        widget.onCancel();
      }
    });
  }
}

class KeyboardNumber extends StatelessWidget {
  const KeyboardNumber({super.key, required this.n, required this.onPressed});

  final int n;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) => Container(
        margin: EdgeInsets.symmetric(vertical: 5.h),
        width: 64.sp,
        height: 64.sp,
        decoration: BoxDecoration(
            // gradient: LinearGradient(colors: gradientColors),
            borderRadius: BorderRadius.circular(100),
            border: Border.all(color: gradientColors[1], width: 2)),
        child: MaterialButton(
          height: 64.sp,
          minWidth: 64.sp,
          onPressed: onPressed,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
          elevation: 5,
          child: Text(
            '$n',
            textAlign: TextAlign.center,
            style: TextStyle(color: AppColor.textColor, fontWeight: FontWeight.bold, fontSize: 24.sp),
          ),
        ),
      );
}

class PinNumber extends StatelessWidget {
  const PinNumber({super.key, required this.textEditingController, required this.outlineInputBorder});

  final TextEditingController textEditingController;
  final OutlineInputBorder outlineInputBorder;

  @override
  Widget build(BuildContext context) => SizedBox(
        width: 36,
        height: 36,
        child: TextField(
          controller: textEditingController,
          enabled: false,
          obscureText: true,
          textAlign: TextAlign.center,
          decoration: InputDecoration(
              border: outlineInputBorder,
              contentPadding: const EdgeInsets.all(1),
              filled: true,
              fillColor: AppColor.white),
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
            color: AppColor.textColor,
          ),
        ),
      );
}
