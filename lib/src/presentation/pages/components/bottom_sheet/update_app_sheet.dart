import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sovchilar_mobile/src/config/themes/themes.dart';
import 'package:sovchilar_mobile/src/core/extension/extension.dart';
import '../../../../core/utils/utils.dart';

class AppUpdateBottomSheetWidget extends StatefulWidget {
  const AppUpdateBottomSheetWidget({
    super.key,
    this.onPressLater,
    required this.isForceUpdate,
    required this.link,
  });

  final void Function()? onPressLater;
  final bool isForceUpdate;
  final String link;

  @override
  State<AppUpdateBottomSheetWidget> createState() => _AppUpdateBottomSheetWidgetState();
}

class _AppUpdateBottomSheetWidgetState extends State<AppUpdateBottomSheetWidget> {
  static const _channel = MethodChannel('apk_installer');
  String progress = '';
  String filePath = '';

  @override
  Widget build(BuildContext context) => PopScope(
        canPop: false,
        child: SafeArea(
          minimum: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'new_version'.tr(),
                textAlign: TextAlign.center,
              ),
              AppUtils.kGap8,
              Text(
                'Sovchilik O‘zbekiston',
                textAlign: TextAlign.center,
              ),
              AppUtils.kGap16,
              ElevatedButton(
                style: OutlinedButton.styleFrom(backgroundColor: AppColor.mainWomenColor),
                onPressed: progress.isNotEmpty
                    ? () {}
                    : () {
                        downloadApk();
                      },
                child: progress.isNotEmpty ? Text('${'downloaded'.tr()} $progress') : Text('update'.tr()),
              ),
              if (!widget.isForceUpdate) AppUtils.kGap8,
              if (!widget.isForceUpdate && progress.isEmpty)
                TextButton(
                  onPressed: widget.onPressLater,
                  child: Text(
                    'skip'.tr(),
                    style: TextStyle(
                      fontSize: 13.sp,
                      color: AppColor.mainWomenColor,
                    ),
                  ),
                ),
            ],
          ),
        ),
      );

  Future<void> downloadApk() async {
    var status = await Permission.requestInstallPackages.request();
    if (status.isGranted) {
      if (progress.isNotEmpty) return;
      try {
        Dio dio = Dio();

        final directory = await getExternalStorageDirectory();
        filePath = '${directory?.path}/downloaded-app.apk';

        await dio.download(
          widget.link,
          filePath,
          onReceiveProgress: (received, total) {
            if (total != -1) {
              if (progress != '${(received / total * 100).toStringAsFixed(0)}%') {
                setState(() {
                  progress = '${(received / total * 100).toStringAsFixed(0)}%';
                });
              }
            }
          },
        );

        await _channel.invokeMethod('installApk', {'apkPath': filePath});
      } catch (e) {
        progress = '';
        setState(() {});
        debugPrint('Faylni yuklab olishda xato yuz berdi: $e');
      }
    } else {
      progress = '';
      setState(() {});
      debugPrint("Install permission denied");
    }
  }
}
