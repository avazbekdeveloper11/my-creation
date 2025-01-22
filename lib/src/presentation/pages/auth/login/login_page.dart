import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
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
import 'package:sovchilar_mobile/src/presentation/bloc/auth/login/login_bloc.dart';
import 'package:sovchilar_mobile/src/presentation/pages/components/inputs/custom_text_field.dart';
import 'package:sovchilar_mobile/src/presentation/pages/widgets/change_language_widget.dart';

import '../../components/bottom_sheet/custom_bottom_sheet.dart';

part 'mixin/login_mixin.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with LoginMixin {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginBloc, LoginState>(
      buildWhen: (p, c) =>
          p.apiStatus != c.apiStatus ||
          p.isVisible != c.isVisible ||
          p.getAccountApiStatus != c.getAccountApiStatus ||
          p.message != c.message ||
          p.accountModel != c.accountModel,
      listenWhen: (p, c) =>
          p.apiStatus != c.apiStatus ||
          p.getAccountApiStatus != c.getAccountApiStatus ||
          p.accountModel != c.accountModel,
      listener: (context, state) {
        if (state.getAccountApiStatus.isSuccess) {
          if (state.accountModel?.status == 'ACTIVATED') {
            context.pushReplacement(Routes.createPinCode);
          } else if (state.accountModel?.status == 'NON_ACTIVE') {
            context.push(Routes.otpPage, extra: '+998${phoneController.text}');
          }
        }
        if (state.apiStatus.isError || state.getAccountApiStatus.isError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.red,
              content: Text(
                state.message,
                style: TextStyle(color: Colors.white, fontSize: 12.sp),
              ),
            ),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        alignment: Alignment.centerRight,
                        padding: EdgeInsets.all(8.sp),
                        child: IconButton(
                          onPressed: () async {
                            await customModalBottomSheet<void>(
                              context: context,
                              builder: (_, controller) => const ChangeLanguageWidget(),
                            );
                          },
                          icon: Icon(Icons.language, size: 26.sp),
                        ),
                      ),
                      SizedBox(height: 40.h),
                      Text(
                        'Login'.tr(),
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColor.textColor,
                        ),
                      ),
                      SizedBox(height: 20.h),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: AppUtils.kPaddingHorizontal16,
                          child: Text(
                            'phone_number'.tr(),
                            maxLines: 1,
                            style: TextStyle(
                              fontSize: 11.sp,
                              color: AppColor.textColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 8.h),
                      CustomTextField(
                        controller: phoneController,
                        focusNode: phoneFocus,
                        onChanged: (v) {
                          if (v?.length == 14) {
                            passwordFocus.requestFocus();
                          }
                        },
                        autoValidateMode: autoValidate ? AutovalidateMode.always : AutovalidateMode.disabled,
                        inputFormatters: [Mask.PHONE_NUMBER],
                        keyboardType: TextInputType.number,
                        style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
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
                        // : 10.h,
                        hintText: '(99) 123-45-67',
                        validator: (value) {
                          if (value?.length != 14) {
                            return '${'min_text_length'.tr()} 14';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20.h),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: AppUtils.kPaddingHorizontal16,
                          child: Text(
                            'password'.tr(),
                            maxLines: 1,
                            style: TextStyle(
                              fontSize: 11.sp,
                              color: AppColor.textColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 8.h),
                      CustomTextField(
                        controller: passwordController,
                        focusNode: passwordFocus,
                        keyboardType: TextInputType.visiblePassword,
                        style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
                        autoValidateMode: autoValidate ? AutovalidateMode.always : AutovalidateMode.disabled,
                        obscureText: state.isVisible,
                        suffixIcon: IconButton(
                          onPressed: () {
                            context.read<LoginBloc>().add(const ShowPassword());
                          },
                          icon: Icon(Icons.visibility),
                        ),
                        validator: (value) {
                          if ((value?.length ?? 0) < 4) {
                            return '${'min_text_length'.tr()} 4';
                          }
                          return null;
                        },
                        hintText: '****',
                      ),
                      14.verticalSpace,
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {
                            context.push(Routes.forgotPassword);
                          },
                          child: AppText(
                            'forgot_password'.tr(),
                            size: 13.sp,
                            textColor: gradientColors[1],
                            textDecoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                      SizedBox(height: 14.h),
                      AppButton(
                        width: 1.sw,
                        colors: [AppColor.mainWomenColor, AppColor.mainWomenColor],
                        borderRadius: AppUtils.kBorderRadius12,
                        onPressed: state.apiStatus.isLoading
                            ? () {}
                            : () {
                                setState(() => autoValidate = true);
                                if (formKey.currentState!.validate()) {
                                  FocusScope.of(context).unfocus();
                                  context.read<LoginBloc>().add(
                                        LoginButtonPressed(
                                          login:
                                              '998${phoneController.text.trim().replaceFirst('(', '').replaceFirst(')', '').replaceFirst(' ', '').replaceAll('-', '')}',
                                          password: passwordController.text.trim(),
                                        ),
                                      );
                                }
                              },
                        title: 'continues'.tr(),
                        child: state.apiStatus.isLoading
                            ? SizedBox(height: 18, width: 18, child: CircularProgressIndicator(color: AppColor.white))
                            : null,
                      ),
                      // SizedBox(height: 30.h),
                      // Padding(
                      //   padding: EdgeInsets.symmetric(horizontal: 10.w),
                      //   child: Row(
                      //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //     children: [
                      //       Flexible(flex: 2, child: AppText(maxLines: 5, 'i_do_not_have_account'.tr(), size: 12.sp)),
                      //       Flexible(
                      //         child: TextButton(
                      //           onPressed: () => context.push(Routes.register),
                      //           child: AppText(
                      //             'register'.tr(),
                      //             textColor: gradientColors[1],
                      //             size: 13.sp,
                      //             maxLines: 5,
                      //             textAlign: TextAlign.center,
                      //             textDecoration: TextDecoration.underline,
                      //           ),
                      //         ),
                      //       )
                      //     ],
                      //   ),
                      // ),
                      // SizedBox(height: 50.h),
                    ],
                  ),
                ),
              ),
            ),
          ),
          bottomNavigationBar: SafeArea(
            minimum: AppUtils.kPaddingHorizontal16.copyWith(bottom: 12.h),
            child: OutlinedButton(
              onPressed: () => context.push(Routes.register),
              style: OutlinedButton.styleFrom(
                fixedSize: Size(1.sw, 34.h),
                side: BorderSide(
                  color: Colors.grey,
                  style: BorderStyle.solid,
                  width: 1.w,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.r),
                ),
              ),
              child: Text(
                'register'.tr(),
                style: TextStyle(color: Colors.black),
              ),
            ),
          ),
        );
      },
    );
  }
}

Container titleTextField({required String label, bool? isRequired, double? texSize, Color? textColor}) => Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w),
      alignment: Alignment.centerLeft,
      child: Row(
        children: [
          AppText(
            label,
            size: texSize ?? 11.sp,
            maxLines: 1,
            textColor: textColor ?? AppColor.textColor,
            fontWeight: FontWeight.w600,
          ),
          SizedBox(width: 3.w),
          isRequired ?? false
              ? AppText('*', fontWeight: FontWeight.w300, textColor: AppColor.errorColor, size: 15.sp)
              : const SizedBox()
        ],
      ),
    );
