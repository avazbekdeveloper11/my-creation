import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:sovchilar_mobile/src/config/themes/themes.dart';
import 'package:sovchilar_mobile/src/core/constants/constants.dart';
import 'package:sovchilar_mobile/src/presentation/pages/components/app_button/app_button.dart';
import 'package:sovchilar_mobile/src/presentation/pages/components/app_text/app_text.dart';
import 'package:sovchilar_mobile/src/config/router/app_routes.dart';
import 'package:sovchilar_mobile/src/core/extension/extension.dart';
import 'package:sovchilar_mobile/src/core/utils/utils.dart';
import 'package:sovchilar_mobile/src/presentation/bloc/auth/forgot_password/forgot_password_bloc.dart';
import 'package:sovchilar_mobile/src/presentation/pages/auth/login/login_page.dart';
import 'package:sovchilar_mobile/src/presentation/pages/components/inputs/custom_text_field.dart';

part 'mixin/forgot_password_mixin.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> with ForgotPasswordMixin {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ForgotPasswordBloc, ForgotPasswordState>(
      listenWhen: (c, p) => c.apiStatus != p.apiStatus,
      listener: (context, state) {
        if (state.apiStatus.isError) {
          context.showFloatingSnackBar(message: state.message ?? '');
        }
        if (state.apiStatus.isSuccess) {
          context.push(Routes.forgotOtp, extra: phoneController.text);
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            leading: BackButton(
              color: gradientColors[1],
            ),
          ),
          body: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                children: [
                  SizedBox(height: 30.h),
                  AppText(
                    'change_password'.tr(),
                    size: 20.sp,
                    textColor: AppColor.textColor,
                    fontWeight: FontWeight.w600,
                  ),
                  SizedBox(height: 30.h),
                  titleTextField(label: 'phone_number'.tr()),
                  SizedBox(height: 10.h),
                  Form(
                    key: formKey,
                    child: CustomTextField(
                      autoValidateMode: autoValidate ? AutovalidateMode.always : null,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14.sp,
                      ),
                      controller: phoneController,
                      prefixIcon: Padding(
                        padding: EdgeInsets.only(left: 8.w),
                        child: SizedBox(
                          width: 40.w,
                          child: Center(
                            child: AppText(
                              '+998 ',
                              size: 14.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                      hintText: '(99) 123-45-67',
                      validator: (value) => appTextValidator(
                        value?.trim(),
                        required: true,
                        minLength: 14,
                      ),
                      keyboardType: TextInputType.phone,
                      inputFormatters: [Mask.PHONE_NUMBER],
                      onChanged: (v) {
                        if (v?.length == 14) {
                          context.read<ForgotPasswordBloc>().add(
                                SendForgotOtp(
                                  phone:
                                      '998${phoneController.text.trim().replaceFirst('(', '').replaceFirst(')', '').replaceFirst(' ', '').replaceAll('-', '')}',
                                ),
                              );
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          bottomNavigationBar: SafeArea(
            minimum: AppUtils.kPaddingHorizontal16.copyWith(bottom: 8.h),
            child: AppButton(
              width: 1.sw,
              title: 'continues'.tr(),
              onPressed: () {
                setState(() {
                  autoValidate = true;
                });
                if (formKey.currentState!.validate()) {
                  context.read<ForgotPasswordBloc>().add(
                        SendForgotOtp(
                          phone:
                              '998${phoneController.text.trim().replaceFirst('(', '').replaceFirst(')', '').replaceFirst(' ', '').replaceAll('-', '')}',
                        ),
                      );
                }
              },
              child: state.apiStatus.isLoading ? CircularProgressIndicator() : null,
            ),
          ),
        );
      },
    );
  }
}
