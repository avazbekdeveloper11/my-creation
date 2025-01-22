import 'dart:async';
import 'package:flutter/material.dart';
import 'package:sovchilar_mobile/src/config/router/app_routes.dart';
import 'package:sovchilar_mobile/src/config/themes/themes.dart';
import 'package:sovchilar_mobile/src/core/extension/extension.dart';
import '../../../../core/connectivity/internet_connection_checker.dart';
import '../../../../core/platform/network_info.dart';
import '../../../../injector_container.dart';

class InternetConnectionPage extends StatefulWidget {
  const InternetConnectionPage({super.key});

  @override
  InternetConnectionPageState createState() => InternetConnectionPageState();
}

class InternetConnectionPageState extends State<InternetConnectionPage> {
  late NetworkInfo networkInfo;
  late StreamSubscription<InternetConnectionStatus> listener;

  @override
  void initState() {
    super.initState();
    networkInfo = sl<NetworkInfo>();
    listener = networkInfo.onStatusChange.listen(_updateConnectionStatus);
  }

  Future<void> _updateConnectionStatus(InternetConnectionStatus status) async {
    switch (status) {
      case InternetConnectionStatus.connected:
        Navigator.of(context).pop();
      case InternetConnectionStatus.disconnected:
        break;
    }
  }

  @override
  void dispose() {
    unawaited(listener.cancel());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => PopScope(
        canPop: false,
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'no_internet_access'.tr(),
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 12),
              Text(
                'check_your_internet_connection'.tr(),
                style: TextStyle(
                  color: Color(0xff818C99),
                  fontSize: 17,
                  fontWeight: FontWeight.w400,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          bottomNavigationBar: SafeArea(
            minimum: const EdgeInsets.all(16),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: localSource.accessToken.isNotEmpty ? AppColor.mainColor : AppColor.mainMenColor),
              child: Text('try_again'.tr()),
              onPressed: () async {
                await Future<void>.delayed(const Duration(milliseconds: 300));
                final isConnected = await networkInfo.isConnected;
                if (isConnected) {
                  if (!context.mounted) return;
                  Navigator.of(context).pop();
                }
              },
            ),
          ),
        ),
      );
}
