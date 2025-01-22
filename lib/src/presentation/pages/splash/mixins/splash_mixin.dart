part of '../splash_page.dart';

mixin SplashMixin on State<SplashPage> {
  int remoteVersion = 0;
  int localVersion = 0;
  String link = '';
  String progress = '';

  late final DeviceInfoPlugin deviceInfo;
  late final String deviceId;
  late final String deviceName;
  late final String deviceType;
  late final String deviceOsVersion;
  late final String firebaseToken;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    if (!mounted) return;
    deviceInfo = DeviceInfoPlugin();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    Future.delayed(
      const Duration(seconds: 5),
      FlutterNativeSplash.remove,
    );
    getAppLastVersion().then(
      (value) async {
        AppVersionModel model = value;
        remoteVersion = model.version?.toVersion ?? 0;
        localVersion = packageInfo.version.toVersion;
        link = model.url ?? '';
        print(value);
        if (remoteVersion > localVersion) {
          await appUpdateBottomSheet(isForceUpdate: kDebugMode ? false : (model.required ?? false)).then(
            (v) {
              Future.delayed(splashPageAnimationDuration, () {
                if (localSource.hasProfile) {
                  context.pushReplacement(Routes.pinCode);
                } else {
                  context.pushReplacement(Routes.auth);
                }
              });
            },
          );
        } else {
          getDeviceAllData().then(
            (v) {
              Future.delayed(splashPageAnimationDuration, () {
                if (localSource.hasProfile) {
                  context.pushReplacement(Routes.pinCode);
                } else {
                  context.pushReplacement(Routes.auth);
                }
              });
            },
          );
        }
      },
    );
  }

  Future<AppVersionModel> getAppLastVersion() async {
    try {
      final Response response = await Dio().get(
        '${Constants.baseUrl}/api/apk',
      );

      return AppVersionModel.fromJson(response.data);
    } catch (e) {
      return AppVersionModel(status: e.toString());
    }
  }

  Future<void> appUpdateBottomSheet({
    required bool isForceUpdate,
  }) async {
    await customModalBottomSheet<bool>(
      context: rootNavigatorKey.currentContext!,
      enableDrag: false,
      builder: (_, controller) => AppUpdateBottomSheetWidget(
        link: link,
        isForceUpdate: isForceUpdate,
        onPressLater: () {
          rootNavigatorKey.currentContext!.pop();
        },
      ),
    );
  }

  Future<void> getDeviceAllData() async {
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
      );
    }
  }
}
