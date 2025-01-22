import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../../core/constants/constants.dart';
import '../../core/utils/utils.dart';

final class LocalSource {
  const LocalSource(this.box);

  final Box<dynamic> box;

  Future<void> setHasProfile({required bool value}) async => _setBool(AppKeys.hasProfile, value);
  bool get hasProfile => _getBool(AppKeys.hasProfile, false);

  Future<void> setPhotoShow({required bool value}) async => _setBool(AppKeys.photoShowType, value);
  bool get photoShowType => _getBool(AppKeys.photoShowType, false);

  Future<void> setVerified({required bool isVerified}) async => _setBool(AppKeys.isVerified, isVerified);
  bool get isVerified => _getBool(AppKeys.isVerified, false);

  Future<void> setHasImage({required bool hasImage}) async => _setBool(AppKeys.hasImage, hasImage);
  bool get hasImage => _getBool(AppKeys.hasImage, false);

  Future<void> setRequiredQuestionnaire({required bool value}) async => _setBool(AppKeys.requiredQuestionnaire, value);
  bool get requiredQuestionnaire => _getBool(AppKeys.requiredQuestionnaire, true);

  Future<void> setDateOfBirth({required String dateOfBirth}) async => _setString(AppKeys.dateOfBirth, dateOfBirth);
  String get dateOfBirth => _getString(AppKeys.dateOfBirth);

  Future<void> setProfileId({required String profileId}) async => _setString(AppKeys.profileId, profileId);
  String get profileId => _getString(AppKeys.profileId);

  Future<void> setPinCode({
    required String pinCode,
  }) async {
    await box.put(AppKeys.pinCode, pinCode);
  }

  Future<void> setUser({
    String? firstName,
    String? lastName,
    String? accessToken,
    String? refreshToken,
    String? userId,
    String? gender,
    String? password,
    String? age,
    String? phone,
    String? profileId,
    String? status,
  }) async {
    if (firstName?.isNotEmpty ?? false) await _setString(AppKeys.firstName, firstName);
    if (lastName?.isNotEmpty ?? false) await _setString(AppKeys.lastName, lastName);
    if (accessToken?.isNotEmpty ?? false) await _setString(AppKeys.accessToken, accessToken);
    if (refreshToken?.isNotEmpty ?? false) await _setString(AppKeys.refreshToken, refreshToken);
    if (userId?.isNotEmpty ?? false) await _setString(AppKeys.userId, userId);
    if (gender?.isNotEmpty ?? false) await _setString(AppKeys.gender, gender);
    if (password?.isNotEmpty ?? false) await _setString(AppKeys.password, password);
    if (age?.isNotEmpty ?? false) await _setString(AppKeys.age, age);
    if (phone?.isNotEmpty ?? false) await _setString(AppKeys.phone, phone);
    if (profileId?.isNotEmpty ?? false) await _setString(AppKeys.profileId, profileId);
    if (status?.isNotEmpty ?? false) await _setString(AppKeys.status, status);
  }

  Future<void> setUserId({required String userID}) async => _setString(AppKeys.userId, userID);
  String get userId => _getString(AppKeys.userId);

  String get firstName => _getString(AppKeys.firstName);
  String get lastName => _getString(AppKeys.lastName);
  String get gender => _getString(AppKeys.gender);
  String get phone => _getString(AppKeys.phone);
  String get password => _getString(AppKeys.password);
  String get status => _getString(AppKeys.status);

  Future<void> userClear() async {
    for (var key in [
      AppKeys.hasProfile,
      AppKeys.gender,
      AppKeys.phone,
      AppKeys.age,
      AppKeys.firstName,
      AppKeys.lastName,
      AppKeys.accessToken,
      AppKeys.refreshToken,
      AppKeys.userId,
      AppKeys.password,
    ]) {
      await box.delete(key);
    }
  }

  Future<void> setDeviceData({
    String? deviceId,
    String? deviceName,
    String? deviceType,
    String? deviceOsVersion,
    String? fcmToken,
  }) async {
    if (deviceId?.isNotEmpty ?? false) await _setString(AppKeys.deviceId, deviceId);
    if (deviceName?.isNotEmpty ?? false) await _setString(AppKeys.deviceName, deviceName);
    if (deviceType?.isNotEmpty ?? false) await _setString(AppKeys.deviceType, deviceType);
    if (deviceOsVersion?.isNotEmpty ?? false) await _setString(AppKeys.deviceOsVersion, deviceOsVersion);
    if (fcmToken?.isNotEmpty ?? false) await _setString(AppKeys.fcmToken, fcmToken);
  }

  String get deviceId => _getString(AppKeys.deviceId);
  String get deviceName => _getString(AppKeys.deviceName);
  String get deviceType => _getString(AppKeys.deviceType);
  String get deviceOsVersion => _getString(AppKeys.deviceOsVersion);
  String get fcmToken => _getString(AppKeys.fcmToken);

  Future<void> setAccessToken({required String accessToken}) async => _setString(AppKeys.accessToken, accessToken);
  String get accessToken => _getString(AppKeys.accessToken);
  String get refreshToken => _getString(AppKeys.refreshToken);
  String get pinCode => _getString(AppKeys.pinCode);

  Future<void> setLocale(String lang) async => _setString(AppKeys.languageCode, lang);
  String get locale => _getString(AppKeys.languageCode, defaultValue: defaultLocale);

  Locale get localeObj => switch (locale) {
        'ru' => Constants.ruLan,
        'uz' => Constants.uzLan,
        'oz' => Constants.ozLan,
        _ => Constants.ruLan,
      };

  Future<void> setLangSelected({required bool value}) async => _setBool(AppKeys.langSelected, value);
  bool get lanSelected => _getBool(AppKeys.langSelected, false);

  Future<void> setThemeMode(ThemeMode mode) async => _setString(AppKeys.themeMode, mode.name);
  ThemeMode get themeMode => switch (_getString(AppKeys.themeMode)) {
        'system' => ThemeMode.system,
        'light' => ThemeMode.light,
        'dark' => ThemeMode.dark,
        _ => ThemeMode.system,
      };

  Future<void> setKey(String key, String value) async => _setString(key, value);
  String getKey(String key) => _getString(key);
  Future<void> deleteKey(String key) async => box.delete(key);

  Future<void> clear() async => box.clear();

  Future<void> changeChuck() async => _setBool(AppKeys.chuck, !chuck);
  bool get chuck => _getBool(AppKeys.chuck, false);

  Map<String, dynamic> get filter =>
      jsonDecode(_getString(AppKeys.filterCache, defaultValue: '{}')) as Map<String, dynamic>;

  Future<void> _setString(String key, String? value) async => await box.put(key, value);
  String _getString(String key, {String defaultValue = ''}) => box.get(key, defaultValue: defaultValue) as String;

  Future<void> _setBool(String key, bool value) async => await box.put(key, value);
  bool _getBool(String key, bool defaultValue) => box.get(key, defaultValue: defaultValue) as bool;
}
