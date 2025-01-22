part of 'app_routes.dart';

sealed class Routes {
  Routes._();

  static const String initial = '/';

  /// main
  static const String main = '/main';
  static const String internetConnection = '/internet_connection';

  /// profile
  static const String aboutUs = '/about_us';
  static const String settings = '/settings';
  static const String userDetailScreen = '/user_detail_screen';

  static const String pinCode = '/pinCode';
  static const String forgotOtp = '/forgot_otp';

  /// auth
  static const String auth = '/auth';
  static const String confirmCode = '/confirm_code';
  static const String register = '/register';

  static const String createPinCode = '/create_pin_code';

  static const String filter = '/filter';

  static const String createQuestionnaire = '/create_questionnaire';

  static const String otpPage = '/otp_page';

  // static const String faceDetector = '/face_detector';

  static const String imageUpload = '/image_upload';

  static const String editProfile = '/edit_profile';

  static const String forgotPassword = '/forgot_password';

  static var chat = '/chat';
}
