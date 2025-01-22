import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sovchilar_mobile/src/config/themes/themes.dart';
import 'package:sovchilar_mobile/src/core/constants/constants.dart';
import 'package:sovchilar_mobile/src/presentation/pages/components/app_button/app_button.dart';
import 'package:sovchilar_mobile/src/core/extension/extension.dart';
import 'package:sovchilar_mobile/src/core/utils/utils.dart';
import 'package:sovchilar_mobile/src/injector_container.dart';
import 'package:sovchilar_mobile/src/presentation/bloc/auth/forgot_password/forgot_password_bloc.dart';
import 'package:sovchilar_mobile/src/presentation/bloc/auth/login/login_bloc.dart';
import 'package:sovchilar_mobile/src/presentation/pages/auth/login/login_page.dart';
import 'package:sovchilar_mobile/src/presentation/pages/auth/widget/otp_resend_timer.dart';
import 'package:sovchilar_mobile/src/presentation/pages/components/inputs/custom_text_field.dart';

part 'mixin/forgot_otp_mixin.dart';

class ForgotOtp extends StatefulWidget {
  const ForgotOtp({super.key, required this.phone});

  final String phone;

  @override
  State<ForgotOtp> createState() => _ForgotOtpState();
}

class _ForgotOtpState extends State<ForgotOtp> with ForgotOtpMixin {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ForgotPasswordBloc, ForgotPasswordState>(
      buildWhen: (c, p) => c.otpApiStatus != p.otpApiStatus || p.isShow != c.isShow,
      listenWhen: (c, p) => c.otpApiStatus != p.otpApiStatus,
      listener: (context, state) {
        if (state.otpApiStatus.isError) {
          context.showFloatingSnackBar(message: state.message ?? '');
        }
        if (state.otpApiStatus.isSuccess) {
          context.showFloatingSnackBar(message: 'password_changed_success'.tr(), backgroundColor: Colors.green);
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => BlocProvider(
                create: (context) => sl<LoginBloc>(),
                child: LoginPage(),
              ),
            ),
            (route) => true,
          );
        }
      },
      builder: (context, state) => Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: BackButton(
            color: gradientColors[1],
          ),
        ),
        body: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                40.verticalSpace,
                Text(
                  '+998 ${widget.phone} ${'desc_otp'.tr()}',
                  style: TextStyle(fontSize: 10.5.sp),
                ),
                16.verticalSpace,
                Padding(
                  padding: AppUtils.kPaddingHorizontal16,
                  child: CustomTextField(
                    focusNode: otpFocus,
                    titleText: 'code'.tr(),
                    autoValidateMode: autoValidate ? AutovalidateMode.always : null,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14.sp,
                    ),
                    controller: otpController,
                    hintText: '1234',
                    validator: (value) => appTextValidator(
                      value?.trim(),
                      required: true,
                      minLength: 4,
                    ),
                    keyboardType: TextInputType.phone,
                    inputFormatters: [Mask.OTP_CODE],
                    nextFocus: passwordFocus,
                  ),
                ),
                12.verticalSpace,
                Padding(
                  padding: AppUtils.kPaddingHorizontal16,
                  child: CustomTextField(
                    focusNode: passwordFocus,
                    titleText: 'password'.tr(),
                    autoValidateMode: autoValidate ? AutovalidateMode.always : null,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14.sp,
                    ),
                    controller: passwordController,
                    hintText: '****',
                    validator: (value) => appTextValidator(
                      value?.trim(),
                      required: true,
                      minLength: 4,
                    ),
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: !state.isShow,
                    nextFocus: confirmPasswordFocus,
                    suffixIcon: IconButton(
                      onPressed: () {
                        context.read<ForgotPasswordBloc>().add(OnChangedVisible());
                      },
                      icon: Icon(state.isShow ? Icons.visibility : Icons.visibility_off),
                    ),
                  ),
                ),
                12.verticalSpace,
                Padding(
                  padding: AppUtils.kPaddingHorizontal16,
                  child: CustomTextField(
                    focusNode: confirmPasswordFocus,
                    titleText: 'confirm_password'.tr(),
                    autoValidateMode: autoValidate ? AutovalidateMode.always : null,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14.sp,
                    ),
                    controller: confirmPasswordController,
                    hintText: '****',
                    obscureText: !state.isShow,
                    validator: (value) => appTextValidator(
                      confirmPasswordController.text.trim(),
                      required: true,
                      equalText: passwordController.text.trim(),
                      minLength: 4,
                    ),
                    keyboardType: TextInputType.visiblePassword,
                    onChanged: (v) {
                      if (passwordController.text.isNotEmpty &&
                          passwordController.text == confirmPasswordController.text) {
                        FocusScope.of(context).unfocus();
                      }
                    },
                    suffixIcon: IconButton(
                      onPressed: () {
                        context.read<ForgotPasswordBloc>().add(OnChangedVisible());
                      },
                      icon: Icon(state.isShow ? Icons.visibility : Icons.visibility_off),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: SafeArea(
          minimum: AppUtils.kPaddingHorizontal16,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              OTPResendTimer(
                initialSeconds: 60,
                onResend: () {
                  context.read<ForgotPasswordBloc>()
                    ..add(GetConfigForgotEvent(
                        '998${widget.phone.trim().replaceFirst('(', '').replaceFirst(')', '').replaceFirst(' ', '').replaceAll('-', '')}'))
                    ..add(
                      SendForgotOtp(
                        phone:
                            '998${widget.phone.trim().replaceFirst('(', '').replaceFirst(')', '').replaceFirst(' ', '').replaceAll('-', '')}',
                      ),
                    );
                },
              ),
              AppUtils.kGap16,
              AppButton(
                width: 1.sw,
                title: 'continues'.tr(),
                onPressed: () {
                  setState(() {
                    autoValidate = true;
                  });
                  if (formKey.currentState!.validate()) {
                    context.read<ForgotPasswordBloc>().add(
                          VerifyForgotOtpEvent(
                            password: passwordController.text.trim(),
                            code: otpController.text.trim(),
                            phone:
                                '998${widget.phone.trim().replaceFirst('(', '').replaceFirst(')', '').replaceFirst(' ', '').replaceAll('-', '')}',
                          ),
                        );
                  }
                },
                child: state.otpApiStatus.isLoading ? Center(child: CircularProgressIndicator()) : null,
              ),
              AppUtils.kGap8,
            ],
          ),
        ),
      ),
    );
  }
}
