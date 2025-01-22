part of '../register_page.dart';

mixin RegisterMixin on State<RegisterPage> {
  late final GlobalKey<FormState> formKey;

  late final ScrollController _scrollController;

  late final TextEditingController phoneController;

  late final TextEditingController passwordController;

  late final TextEditingController confirmPasswordController;

  late final TextEditingController dateController;

  late final FocusNode phoneFocus;

  late final FocusNode passwordFocus;

  DateTime? now;
  String _gender = 'MALE';
  int age = 0;
  String? selectDate;

  bool autoValidate = false;

  bool appBarShow = false;

  @override
  void initState() {
    formKey = GlobalKey<FormState>();

    _scrollController = ScrollController();
    _scrollController.addListener(
      () {
        if (_scrollController.position.pixels > 40) {
          setState(() {
            appBarShow = true;
          });
        } else if (appBarShow) {
          setState(() {
            appBarShow = false;
          });
        }
      },
    );

    phoneController = TextEditingController();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
    dateController = TextEditingController();

    phoneFocus = FocusNode();
    passwordFocus = FocusNode();
    super.initState();
  }

  Future<void> showCustomDatePicker() async {
    if (dateController.text.isEmpty) {
      selectDate = DateFormat('dd-MM-yyyy').format(DateTime(DateTime.now().year - 22));
      dateController.text = DateFormat('dd-MM-yyyy').format(now ?? DateTime(DateTime.now().year - 22));
    }
    await customModalBottomSheet<dynamic>(
      context: context,
      builder: (_, __) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 300,
              child: CupertinoDatePicker(
                mode: CupertinoDatePickerMode.date,
                onDateTimeChanged: (date) {
                  now = date;
                  selectDate = DateFormat('dd-MM-yyyy').format(date);
                  dateController.text = DateFormat('dd-MM-yyyy').format(date);
                  setState(() {});
                },
                initialDateTime: now != null ? now! : DateTime(DateTime.now().year - 22),
                minimumYear: (DateTime.now().year) - 100,
                maximumYear: (DateTime.now().year) - 22,
              ),
            ),
            Padding(
              padding: AppUtils.kPaddingHorizontal16,
              child: SafeArea(
                child: AppButton(
                  onPressed: () {
                    context.pop();
                  },
                  title: 'save'.tr(),
                  width: 1.sw,
                  borderRadius: AppUtils.kBorderRadius12,
                ),
              ),
            ),
            12.verticalSpace,
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    formKey.currentState?.dispose();
    phoneController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    dateController.dispose();
    phoneFocus.dispose();
    passwordFocus.dispose();
    super.dispose();
  }
}
