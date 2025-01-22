import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:sovchilar_mobile/src/presentation/pages/components/app_button/app_button.dart';
import 'package:sovchilar_mobile/src/config/router/app_routes.dart';
import 'package:sovchilar_mobile/src/core/extension/extension.dart';
import 'package:sovchilar_mobile/src/core/utils/utils.dart';
import 'package:sovchilar_mobile/src/presentation/bloc/auth/otp/otp_bloc.dart';
import 'package:sovchilar_mobile/src/presentation/pages/auth/widget/otp_resend_timer.dart';
import 'package:sovchilar_mobile/src/presentation/pages/components/inputs/custom_pin_put.dart';

part 'mixin/otp_mixin.dart';

class OtpPage extends StatefulWidget {
  const OtpPage({super.key, required this.phone});

  final String phone;

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> with OtpMixin {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OtpBloc, OtpState>(
      listenWhen: (p, c) => p.otpApiStatus != c.otpApiStatus,
      listener: (context, state) async {
        if (state.otpApiStatus.isSuccess) {
          context.pushReplacement(Routes.createPinCode);
        }
        if (state.otpApiStatus.isError) {
          context.showFloatingSnackBar(message: state.message);
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text('verify'.tr()),
          ),
          body: Stack(
            children: [
              Padding(
                padding: AppUtils.kPaddingHorizontal16,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    50.verticalSpace,
                    Text(
                      '${widget.phone} ${'desc_otp'.tr()}',
                      textAlign: TextAlign.start,
                      style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w500),
                    ),
                    12.verticalSpace,
                    CustomPinPut(
                      controller: otpController,
                      onComplete: (v) {
                        if (v.length == 4) {
                          context.read<OtpBloc>().add(OtpConfirmEvent(otpController.text));
                        }
                      },
                    ),
                    40.verticalSpace,
                    OTPResendTimer(
                      initialSeconds: 60,
                      onResend: () {
                        context.read<OtpBloc>()
                          ..add(GetConfigEvent())
                          ..add(
                            SendOtpEvent(
                              widget.phone
                                  .replaceAll('+', '')
                                  .replaceFirst('(', '')
                                  .replaceFirst(')', '')
                                  .replaceAll(' ', '')
                                  .replaceAll('-', ''),
                            ),
                          );
                      },
                    ),
                    100.verticalSpace,
                    AppButton(
                      borderRadius: AppUtils.kBorderRadius12,
                      width: 1.sw,
                      title: 'verify'.tr(),
                      onPressed: () {
                        if (otpController.text.length == 4) {
                          context.read<OtpBloc>().add(OtpConfirmEvent(otpController.text));
                        }
                      },
                    ),
                  ],
                ),
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                top: 0,
                child: state.configApiStatus.isLoading || state.otpApiStatus.isLoading
                    ? Container(
                        color: Colors.white.withOpacity(0.2),
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      )
                    : SizedBox(),
              )
            ],
          ),
        );
      },
    );
  }
}
