import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:sovchilar_mobile/src/core/extension/extension.dart';

part 'app_keys.dart';

sealed class Constants {
  Constants._();

  /// test
  static const baseUrl = !kDebugMode ? 'https://sovchilar-test.devops.uz' : 'https://sovchilar.devops.uz';

  // static final String appLink = Platform.isIOS
  //     ? 'https://apps.apple.com/us/app/q-watt-powerbank-sharing/id6444178516'
  //     : 'https://play.google.com/store/apps/details?id=com.q.watt';

  static const ruLan = Locale('ru', 'RU');
  static const uzLan = Locale('uz', 'UZ');
  static const ozLan = Locale('oz', 'UZ');

  static const List<String> languages = [
    "uzbek",
    "russian",
    "tajik",
    "kazakh",
    "karakalpak",
    "turkmen",
    "tatar",
    "kyrgyz",
    "uygur",
    "belarus",
    "ukrainian",
    "other"
    // "english",
    // "turkish",
    // "german",
    // "french",
    // "chinese",
    // "arabic",
    // "korean",
    // "persian",
    // "japanese"
  ];

  static const List<String> educationStatus = [
    "SECONDARY_EDUCATION",
    "COMPLETE_HIGHER_BACHELOR_EDUCATION",
    "COMPLETE_HIGHER_MASTER_EDUCATION"
  ];

  static const String appName = 'Sovchilik O‘zbekiston';
}

sealed class Urls {
  Urls._();

  static const String createQuestionnaire = '/api/profiles';
  static const String profiles = '/api/profiles';
  static const String profilesNear = '/api/profiles/near';
  static const String nationalities = '/api/nationalities';
  static const String getLikes = '/api/likes';
  static const String profilesById = '/api/profiles/';
  static const String likes = '/api/profile/like';
  static const String likeRemove = '/api/profile/like';
  static const String place = '/api/place/';
  static const String placeParent = '/api/place/parent';
  static const String genderTags = '/api/gender-tags/gender/';
  static const String getImage = '/api/profiles/';
  static const String createUrl = '/api/profiles/image';
  static const String verificationImgUrl = '/api/account/image';
  static const String deleteImage = '/api/profiles/image';
  static const String editProfile = '/api/profiles/v2/';
  static const String deleteProfile = '/api/profiles';

  static const String login = '/api/authenticate';
  static const String account = '/api/account';
  static const String register = '/api/register';
  static const String config = '/api/client/config';
  static const String sendOtpRegister = '/api/users/otp/send';
  static const String sendOtp = '/api/account/send/otp';
  static const String otpVerify = '/api/users/otp/verify';
  static const String sendOtpForgot = '/api/account/forgot-password/start';
  static const String verifyOtpForgot = '/api/account/forgot-password/verify';
  static const String matches = '/api/matches';
  static const String deviceId = '/api/devices';
  static const String refreshToken = '/api/refresh';
  static const String getPrivacy = '/api/agreement/latest';
  static const String visibility = '/api/profiles/image/visibility';
}

const Duration splashPageAnimationDuration = Duration(milliseconds: 1000);

const Duration animationDuration = Duration(milliseconds: 300);

class Mask {
  static MaskTextInputFormatter PHONE_NUMBER =
      MaskTextInputFormatter(mask: '(##) ###-##-##', filter: {'#': RegExp('[0-9]')});
  static MaskTextInputFormatter OTP_CODE = MaskTextInputFormatter(mask: '####', filter: {'#': RegExp('[0-9]')});
  static MaskTextInputFormatter GOV_NUMBER = MaskTextInputFormatter(
    mask: '## @ ### @@',
    filter: {'#': RegExp(r'\d'), '@': RegExp('[A-Z]')},
  );
}

bool canValidate(bool? val) => val != null && val;

String? appTextValidator(
  String? val, {
  bool? required,
  int? maxLength,
  int? minLength,
  String? regex,
  List<int>? availableLength,
  String? equalText,
  double? minAmount,
  double? maxAmount,
  String? confirm,
}) {
  if (canValidate(required) && (val == null || val.isEmpty)) {
    return 'please_complete_this_field'.tr();
  }
  if (maxLength != null && (val == null || val.length > maxLength)) {
    return "${'max_text_length'.tr()}: $maxLength";
  }
  if (minLength != null && (val == null || val.length < minLength)) {
    return "${'min_text_length'.tr()}: $minLength";
  }
  if (regex != null && (val == null || !RegExp(regex).hasMatch(val))) {
    return 'required_format_error'.tr();
  }
  if (availableLength != null && (val == null || !availableLength.contains(val.length))) {
    return "${'text_value_length'.tr()}: ${availableLength.map((e) => '$e')}";
  }
  if (equalText != null && (val == null || val != equalText)) {
    return 'password_not_suitable'.tr();
  }
  // if (minAmount != null && (val == null || double.parse(val) < minAmount)) {
  //   return "Min: ${currencyFormatter.format(minAmount)}";
  // }
  // if (maxAmount != null && (val == null || double.parse(val) > maxAmount)) {
  //   return "Max: ${currencyFormatter.format(maxAmount)}";
  // }

  return null;
}
