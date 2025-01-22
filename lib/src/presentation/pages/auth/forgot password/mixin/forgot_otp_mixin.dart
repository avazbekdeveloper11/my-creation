part of '../forgot_otp.dart';

mixin ForgotOtpMixin on State<ForgotOtp> {
  late final GlobalKey<FormState> formKey;

  late final TextEditingController otpController;
  late final TextEditingController passwordController;
  late final TextEditingController confirmPasswordController;

  late final FocusNode otpFocus;
  late final FocusNode passwordFocus;
  late final FocusNode confirmPasswordFocus;

  bool autoValidate = false;

  @override
  void initState() {
    formKey = GlobalKey<FormState>();

    otpController = TextEditingController();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();

    otpFocus = FocusNode();
    passwordFocus = FocusNode();
    confirmPasswordFocus = FocusNode();
    super.initState();
  }
}
