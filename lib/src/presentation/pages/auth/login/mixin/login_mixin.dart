part of 'package:sovchilar_mobile/src/presentation/pages/auth/login/login_page.dart';

mixin LoginMixin on State<LoginPage> {
  late final GlobalKey<FormState> formKey;
  late final TextEditingController phoneController;
  late final TextEditingController passwordController;
  late final FocusNode phoneFocus;
  late final FocusNode passwordFocus;
  bool autoValidate = false;
  late final DeviceInfoPlugin deviceInfo;
  late final String deviceId;
  late final String deviceName;
  late final String deviceType;
  late final String deviceOsVersion;
  late final String firebaseToken;

  @override
  void initState() {
    deviceInfo = DeviceInfoPlugin();
    getDeviceAllData();
    formKey = GlobalKey<FormState>();
    phoneController = TextEditingController();
    passwordController = TextEditingController();
    phoneFocus = FocusNode();
    passwordFocus = FocusNode();

    super.initState();
  }

  Future<void> getDeviceAllData() async {
    FirebaseMessaging.instance.getToken().then(
      (firebaseToken) {
        if (firebaseToken != null) {
          localSource.setDeviceData(fcmToken: firebaseToken);
        }
      },
    );
    if (localSource.deviceName.isEmpty &&
        localSource.deviceId.isEmpty &&
        localSource.deviceOsVersion.isEmpty &&
        localSource.deviceType.isEmpty) {
      if (Theme.of(rootNavigatorKey.currentContext!).platform == TargetPlatform.iOS) {
        var iosInfo = await deviceInfo.iosInfo;
        deviceId = iosInfo.identifierForVendor ?? 'unknown';
        deviceName = iosInfo.name;
        deviceOsVersion = iosInfo.systemVersion;
        deviceType = "IOS";
      } else if (Theme.of(rootNavigatorKey.currentContext!).platform == TargetPlatform.android) {
        var androidInfo = await deviceInfo.androidInfo;
        deviceId = androidInfo.id;
        deviceName = androidInfo.model;
        deviceOsVersion = androidInfo.version.release;
        deviceType = "ANDROID";
        firebaseToken = await FirebaseMessaging.instance.getToken() ?? '';
      } else {
        deviceId = "unknown";
        deviceName = "unknown";
        deviceOsVersion = "unknown";
        deviceType = "unknown";
        firebaseToken = "unknown";
      }

      localSource.setDeviceData(
        deviceId: deviceId,
        deviceName: deviceName,
        deviceType: deviceType,
        deviceOsVersion: deviceOsVersion,
        fcmToken: firebaseToken,
      );
    }
  }

  @override
  void dispose() {
    formKey.currentState?.dispose();
    phoneController.dispose();
    passwordController.dispose();
    phoneFocus.dispose();
    passwordFocus.dispose();
    super.dispose();
  }
}
