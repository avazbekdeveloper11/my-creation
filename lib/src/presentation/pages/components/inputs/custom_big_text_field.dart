import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sovchilar_mobile/src/config/themes/themes.dart';
import 'package:sovchilar_mobile/src/core/extension/extension.dart';
import 'package:sovchilar_mobile/src/core/utils/utils.dart';

class CustomBigTextField extends StatelessWidget {
  const CustomBigTextField({
    super.key,
    this.hintText,
    this.errorText,
    this.showError = false,
    this.controller,
    this.keyboardType,
    this.inputAction,
    this.onChanged,
    this.onFieldSubmitted,
    this.inputFormatters,
    this.obscureText,
    this.suffixIcon,
    this.titleText,
    this.enabled,
    this.onTap,
    this.readOnly = false,
    this.fillColor,
    this.onComplete,
    this.validator,
    this.autofocus,
    this.focusNode,
    this.nextFocus,
    this.prefixIcon,
    this.prefixText,
    this.prefixStyle,
    this.contentPadding,
    this.style,
    this.filled,
    this.isRequired = false,
  });

  final String? hintText;
  final String? errorText;
  final bool showError;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final TextInputAction? inputAction;
  final String? titleText;
  final void Function(String?)? onChanged;
  final void Function(String?)? onFieldSubmitted;
  final List<TextInputFormatter>? inputFormatters;
  final bool? obscureText;
  final bool readOnly;
  final Color? fillColor;
  final bool? autofocus;
  final FocusNode? focusNode;
  final FocusNode? nextFocus;
  final bool? enabled;
  final void Function()? onTap;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final void Function()? onComplete;
  final String Function(String?)? validator;
  final String? prefixText;
  final TextStyle? prefixStyle;
  final EdgeInsets? contentPadding;
  final TextStyle? style;
  final bool? filled;
  final bool? isRequired;

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (titleText != null)
            Padding(
              padding: EdgeInsets.only(bottom: 6.h),
              child: RichText(
                text: TextSpan(
                  text: '$titleText',
                  style: TextStyle(
                    fontSize: 12.sp,
                    height: 14 / 12,
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                  children: [
                    TextSpan(
                      text: isRequired! ? ' *' : '',
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 16.sp,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          Container(
            decoration: BoxDecoration(
              color: fillColor ?? AppColor.iconsColor.withOpacity(0.05),
              border: Border.all(color: AppColor.textColor.withOpacity(0.05)),
              borderRadius: AppUtils.kBorderRadius12,
            ),
            child: TextFormField(
              validator: validator,
              textCapitalization: TextCapitalization.sentences,
              readOnly: readOnly,
              enabled: enabled ?? true,
              autofocus: autofocus ?? false,
              focusNode: focusNode,
              obscureText: obscureText ?? false,
              controller: controller,
              onTap: onTap,
              onSaved: (value) {
                if (nextFocus != null) {
                  FocusScope.of(context).requestFocus(nextFocus);
                }
              },
              style: style ??
                  const TextStyle(
                    fontSize: 14,
                    height: 16 / 14,
                    fontWeight: FontWeight.w400,
                  ),
              textInputAction: nextFocus != null ? TextInputAction.next : inputAction ?? TextInputAction.done,
              onChanged: onChanged,
              onFieldSubmitted: onFieldSubmitted,
              decoration: InputDecoration(
                fillColor: fillColor ?? AppColor.iconsColor.withOpacity(0.005),
                filled: true,
                suffixIcon: suffixIcon,
                prefixIcon: prefixIcon,
                errorText: showError ? errorText : null,
                errorStyle: const TextStyle(fontSize: 13),
                hintText: hintText,
                contentPadding: contentPadding ??
                    EdgeInsets.symmetric(
                      horizontal: 10.w,
                      vertical: 10.h,
                    ),
                prefixText: prefixText,
                prefixStyle: prefixStyle,
                border: OutlineInputBorder(
                  borderRadius: AppUtils.kBorderRadius12,
                ),
                isDense: true,
                focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.transparent)),
                enabledBorder: OutlineInputBorder(
                  borderRadius: AppUtils.kBorderRadius12,
                  borderSide: BorderSide(color: Colors.transparent),
                ),
                disabledBorder: OutlineInputBorder(
                  borderRadius: AppUtils.kBorderRadius12,
                  borderSide: BorderSide(color: Colors.transparent),
                ),
              ),
              cursorColor: context.theme.colorScheme.primary,
              keyboardType: keyboardType,
              maxLines: 10,
              minLines: 1,
              inputFormatters: inputFormatters,
              onEditingComplete: onComplete,
            ),
          ),
        ],
      );
}
