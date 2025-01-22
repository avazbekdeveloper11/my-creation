import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sovchilar_mobile/src/config/router/app_routes.dart';
import 'package:sovchilar_mobile/src/config/themes/themes.dart';
import 'package:sovchilar_mobile/src/core/extension/extension.dart';
import 'package:sovchilar_mobile/src/core/utils/utils.dart';
import 'package:sovchilar_mobile/src/injector_container.dart';

class ChangeLanguageWidget extends StatelessWidget {
  const ChangeLanguageWidget({super.key});

  @override
  Widget build(BuildContext context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: AppUtils.kPaddingHorizontal16,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'app_language'.tr(),
                    style: context.textStyle.appBarTitle,
                  ),
                  GestureDetector(
                    onTap: () {
                      context.pop();
                    },
                    child: const Icon(Icons.close),
                  ),
                ],
              ),
            ),
            AppUtils.kGap12,
            ListTile(
              title: Text(
                'O\'zbekcha',
                style: context.textStyle.regularCallout,
              ),
              onTap: () async {
                context.setLocale(const Locale('uz'));
                await localSource.setLocale('uz').then(
                  (value) {
                    updateLanguageHeader();
                    context.pop();
                  },
                );
              },
              trailing: context.locale.languageCode == 'uz'
                  ? Icon(
                      Icons.check,
                      color: localSource.hasProfile ? AppColor.mainColor : AppColor.mainWomenColor,
                    )
                  : null,
            ),
            AppUtils.kDivider,
            ListTile(
              title: Text(
                'Ўзбекча',
                style: context.textStyle.regularCallout,
              ),
              onTap: () async {
                context.setLocale(const Locale('oz'));
                await localSource.setLocale('oz').then(
                  (value) {
                    updateLanguageHeader();
                    context.pop();
                  },
                );
              },
              trailing: context.locale.languageCode == 'oz'
                  ? Icon(
                      Icons.check,
                      color: localSource.hasProfile ? AppColor.mainColor : AppColor.mainWomenColor,
                    )
                  : null,
            ),
            AppUtils.kDivider,
            ListTile(
              title: Text(
                'Русский',
                style: context.textStyle.regularCallout,
              ),
              onTap: () async {
                context.setLocale(const Locale('ru'));
                await localSource.setLocale('ru').then(
                  (value) {
                    updateLanguageHeader();
                    context.pop();
                  },
                );
              },
              trailing: context.locale.languageCode == 'ru'
                  ? Icon(
                      Icons.check,
                      color: localSource.hasProfile ? AppColor.mainColor : AppColor.mainWomenColor,
                    )
                  : null,
            ),
          ],
        ),
      );

  void updateLanguageHeader() {
    sl<Dio>().options.headers['X-User-Language'] = {
          'uz': 'UZ_LATIN',
          'ru': 'RU',
          'oz': 'UZ_CYRIL',
        }[localSource.locale] ??
        'UZ_LATIN';
  }
}
