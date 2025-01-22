import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:sovchilar_mobile/src/config/themes/themes.dart';
import 'package:sovchilar_mobile/src/core/constants/constants.dart';
import 'package:sovchilar_mobile/src/presentation/pages/components/app_button/app_button.dart';

import 'package:sovchilar_mobile/src/presentation/pages/components/app_text/app_text.dart';
import 'package:sovchilar_mobile/src/config/router/app_routes.dart';
import 'package:sovchilar_mobile/src/core/extension/extension.dart';
import 'package:sovchilar_mobile/src/core/utils/utils.dart';
import 'package:sovchilar_mobile/src/presentation/bloc/auth/register/register_bloc.dart';
import 'package:sovchilar_mobile/src/presentation/pages/components/bottom_sheet/custom_bottom_sheet.dart';
import 'package:sovchilar_mobile/src/presentation/pages/components/inputs/custom_text_field.dart';
import 'package:sovchilar_mobile/src/presentation/pages/widgets/change_language_widget.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../login/login_page.dart';

part 'mixin/register_mixin.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> with RegisterMixin {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterBloc, RegisterState>(
      buildWhen: (p, c) =>
          p.apiStatus != c.apiStatus ||
          p.isVisible != c.isVisible ||
          p.message != c.message ||
          p.isAccept != c.isAccept ||
          p.privacyApiStatus != c.privacyApiStatus,
      listenWhen: (p, c) => p.loginApiStatus != c.loginApiStatus || p.apiStatus != c.apiStatus,
      listener: (context, state) {
        if (state.loginApiStatus.isSuccess && state.apiStatus.isSuccess) {
          context.push(Routes.otpPage, extra: '+998 ${phoneController.text}');
        } else if (state.apiStatus.isError) {
          context.showFloatingSnackBar(message: state.message);
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Visibility(
              visible: appBarShow,
              child: Text('register'.tr()),
            ),
            actions: [
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
            ],
          ),
          backgroundColor: Colors.white,
          body: SafeArea(
            child: SingleChildScrollView(
              controller: _scrollController,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 30.h),
                      AppText(
                        'register'.tr(),
                        size: 20.sp,
                        textColor: AppColor.textColor,
                        fontWeight: FontWeight.w600,
                      ),
                      SizedBox(height: 12.h),
                      AppText(
                        'desc_register'.tr(),
                        textAlign: TextAlign.center,
                        size: 12.sp,
                        textColor: AppColor.textColor,
                      ),
                      SizedBox(height: 12.h),
                      CustomTextField(
                        titleText: 'phone_number'.tr(),
                        controller: phoneController,
                        focusNode: phoneFocus,
                        inputFormatters: [Mask.PHONE_NUMBER],
                        keyboardType: TextInputType.number,
                        hintText: '(99) 123-45-67',
                        onChanged: (v) {
                          if (v?.length == 14) {
                            passwordFocus.requestFocus();
                          }
                        },
                        prefixIcon: SizedBox(
                          width: 48.w,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Center(
                              child: AppText(
                                '+998 ',
                                size: 14.sp,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                        autoValidateMode: autoValidate ? AutovalidateMode.always : AutovalidateMode.disabled,
                        validator: (value) =>
                            appTextValidator(phoneController.text.trim(), required: true, minLength: 14),
                      ),
                      SizedBox(height: 12.h),
                      CustomTextField(
                        hintText: '*****',
                        obscureText: state.isVisible,
                        suffixIcon: IconButton(
                          onPressed: () {
                            context.read<RegisterBloc>().add(const ShowPasswordEvent());
                          },
                          icon: Icon(Icons.visibility),
                        ),
                        titleText: 'new_password'.tr(),
                        focusNode: passwordFocus,
                        controller: passwordController,
                        validator: (value) => appTextValidator(
                          passwordController.text.trim(),
                          required: true,
                          minLength: 4,
                        ),
                        autoValidateMode: autoValidate ? AutovalidateMode.always : AutovalidateMode.disabled,
                      ),
                      SizedBox(height: 12.h),
                      CustomTextField(
                        hintText: '*****',
                        obscureText: state.isVisible,
                        suffixIcon: IconButton(
                          onPressed: () {
                            context.read<RegisterBloc>().add(const ShowPasswordEvent());
                          },
                          icon: Icon(Icons.visibility),
                        ),
                        titleText: 'confirm_password'.tr(),
                        controller: confirmPasswordController,
                        validator: (value) => appTextValidator(confirmPasswordController.text.trim(),
                            required: true, equalText: passwordController.text.trim(), minLength: 4),
                        autoValidateMode: autoValidate ? AutovalidateMode.always : AutovalidateMode.disabled,
                        onChanged: (v) {
                          if (passwordController.text == v && (v?.isNotEmpty ?? false)) {
                            FocusScope.of(context).unfocus();
                          }
                        },
                      ),
                      SizedBox(height: 12.h),
                      CustomTextField(
                        validator: (v) {
                          if (v == null || v.isEmpty) {
                            return 'please_complete_this_field'.tr();
                          }
                          return null;
                        },
                        controller: dateController,
                        hintText: selectDate ?? DateFormat('dd-MM-yyyy').format(DateTime(DateTime.now().year)),
                        titleText: 'date_of_birth'.tr(),
                        autoValidateMode: autoValidate ? AutovalidateMode.always : AutovalidateMode.disabled,
                        readOnly: true,
                        onTap: showCustomDatePicker,
                      ),
                      SizedBox(height: 8.h),
                      RadioListTile(
                        activeColor: AppColor.mainWomenColor,
                        contentPadding: AppUtils.kPadding0,
                        value: 'MALE',
                        groupValue: _gender,
                        title: titleTextField(label: 'MALE'.tr()),
                        onChanged: (value) {
                          setState(() {
                            _gender = value ?? 'MALE';
                          });
                        },
                      ),
                      RadioListTile(
                        activeColor: AppColor.mainWomenColor,
                        contentPadding: AppUtils.kPadding0,
                        value: 'FEMALE',
                        title: titleTextField(label: 'FEMALE'.tr()),
                        groupValue: _gender,
                        onChanged: (value) {
                          setState(() {
                            _gender = value ?? 'FEMALE';
                          });
                        },
                      ),
                      SizedBox(height: 20.h),
                      Row(
                        // mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            flex: 1,
                            child: Checkbox(
                              value: state.isAccept,
                              onChanged: (v) {
                                context.read<RegisterBloc>().add(OnChangedPrivacy());
                              },
                              activeColor: AppColor.mainWomenColor,
                              side: const BorderSide(color: AppColor.mainWomenColor, width: 2),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.r)),
                            ),
                          ),
                          Expanded(
                            flex: 7,
                            child: GestureDetector(
                              child: Text(
                                'privacy_policy'.tr(),
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.w400,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                              onTap: () {
                                customModalBottomSheet(
                                  context: context,
                                  builder: (_, __) => Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.vertical(top: Radius.circular(12.r)),
                                    ),
                                    child: SfPdfViewer.network(
                                      state.privacyModel?.urls?.localizedUrl ?? '',
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                      AppUtils.kGap8,
                      SafeArea(
                        minimum: EdgeInsets.symmetric(vertical: 8.h),
                        child: AppButton(
                          colors: state.isAccept ? [AppColor.mainWomenColor, AppColor.mainWomenColor] : null,
                          isEnabled: state.isAccept,
                          borderRadius: AppUtils.kBorderRadius12,
                          width: 1.sw,
                          onPressed: state.apiStatus.isLoading
                              ? () {}
                              : () {
                                  setState(() {
                                    autoValidate = true;
                                  });
                                  if (formKey.currentState!.validate()) {
                                    if (passwordController.text.trim() != confirmPasswordController.text.trim()) {
                                      return;
                                    }
                                    context.read<RegisterBloc>().add(
                                          RegisterSubmitEvent(
                                            login:
                                                '998${phoneController.text.replaceFirst('(', '').replaceFirst(')', '').replaceFirst(' ', '').replaceAll('-', '')}',
                                            password: passwordController.text.trim(),
                                            date: dateController.text.trim(),
                                            gender: _gender,
                                          ),
                                        );
                                  }
                                },
                          title: 'continues'.tr(),
                          child: state.apiStatus.isLoading ? loadingWidget() : null,
                        ),
                      ),
                      // alreadyHaveAccountWidget(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
