part of '../forgot_password_page.dart';

mixin ForgotPasswordMixin on State<ForgotPasswordPage> {
  late final GlobalKey<FormState> formKey;

  late final TextEditingController phoneController;

  bool autoValidate = false;

  @override
  void initState() {
    formKey = GlobalKey<FormState>();
    phoneController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    formKey.currentState?.dispose();
    phoneController.dispose();
    super.dispose();
  }
}
