part of 'constants.dart';

sealed class AppKeys {
  AppKeys._();

  static const String currentTransactionKey = 'current_transaction';
  static const String accessToken = 'access_token';
  static const String refreshToken = 'refresh_token';
  static const String languageCode = 'language_code';
  static const String themeMode = 'theme_mode';
  static const String favouriteDb = 'favourite_db';
  static const String userId = 'user_id';
  static const String password = 'password';
  static const String firstName = 'first_name';
  static const String lastName = 'last_name';
  static const String hasProfile = 'hasProfile';
  static const String requiredQuestionnaire = 'show_questionnaire';
  static const String hasImage = 'has_image';
  static const String gender = 'gender';
  static const String phone = 'phone';
  static const String age = 'age';
  static const String langSelected = 'email';
  static const String profileId = 'profileId';
  static const String pinCode = 'pin_code';
  static const String dateOfBirth = 'date_of_birth';

  static String homeCache = 'home_cache';
  static String filterCache = 'filter_cache';
  static String likesCache = 'likes_cache';
  static String placeCache = 'place_cache';
  static String parentPlaceCache = 'parent_place_cache';
  static String nationalityCache = 'nationality_cache';
  static String genderCache = 'gender_cache';
  static String profileCache = 'profile_cache';
  static String status = 'status_cache';

  static String deviceId = 'device_id';
  static String deviceName = 'device_name';
  static String deviceType = 'device_type';
  static String deviceOsVersion = 'device_os_version';
  static String fcmToken = 'fcm_token';
  static String sharedUser = 'shared_user';
  static String privacy = 'privacy';
  static const String chuck = 'chuck';
  static const String isVerified = 'is_verified';
  static const String photoShowType = 'photo_show_type';
}
