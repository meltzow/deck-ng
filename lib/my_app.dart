import 'package:catcher_2/catcher_2.dart';
import 'package:deck_ng/controller/board_details_controller.dart';
import 'package:deck_ng/controller/card_details_controller.dart';
import 'package:deck_ng/controller/dashboard_controller.dart';
import 'package:deck_ng/dart_define.gen.dart';
import 'package:deck_ng/l10n/translation.dart';
import 'package:deck_ng/screen/card_details_screen.dart';
import 'package:deck_ng/screen/dashboard_screen.dart';
import 'package:deck_ng/screen/kanban_board_screen.dart';
import 'package:deck_ng/screen/login_screen.dart';
import 'package:deck_ng/screen/oss_licenses_screen.dart';
import 'package:deck_ng/screen/settings_screen.dart';
import 'package:deck_ng/service/Istorage_service.dart';
import 'package:deck_ng/service/guard.dart';
import 'package:deck_ng/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wiredash/wiredash.dart';

class MyApp extends StatelessWidget {
  final String? initialRoute;
  final bool debugShowCheckedModeBanner;
  final storageService = Get.find<IStorageService>();

  MyApp({super.key, this.initialRoute, this.debugShowCheckedModeBanner = true});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Wiredash(
        projectId: 'deck-ng-te1kmcw',
        secret: DartDefine.wiredashSecret,
        psOptions: const PsOptions(
          // collectMetaData: (metaData) async =>
          // metaData..userEmail = 'dash@wiredash.io',
          // frequency: Duration(days: 90), // default
          // initialDelay: Duration(days: 7), // default
          initialDelay: Duration.zero, // disable initial delay
          // minimumAppStarts: 3, // default
          minimumAppStarts: 0, // disable minimum app starts
        ),
        collectMetaData: (metaData) => metaData..custom['language'] = 'de',
        child: GetMaterialApp(
          debugShowCheckedModeBanner: debugShowCheckedModeBanner,
          navigatorKey: Catcher2.navigatorKey,
          translations: Translation(),
          locale: storageService.hasSettings()
              ? Locale(storageService.getSetting()!.language)
              : Get.deviceLocale,
          fallbackLocale: const Locale('en'),
          supportedLocales: Translation.appLanguages
              .map((e) => e['locale'] as Locale)
              .toList(),
          title: 'deck NG',
          theme: myTheme,
          initialRoute: initialRoute ?? '/',
          getPages: [
            GetPage(
                name: '/',
                page: () => DashboardScreen(),
                middlewares: [
                  Guard(), // Add the middleware here
                ],
                binding: BindingsBuilder(() {
                  Get.put<DashboardController>(DashboardController());
                })),
            GetPage(
              name: '/boards/details',
              page: () => KanbanBoardScreen(),
              middlewares: [
                Guard(), // Add the middleware here
              ],
              binding: BindingsBuilder(() {
                Get.lazyPut<BoardDetailsController>(
                    () => BoardDetailsController());
              }),
            ),
            GetPage(
              name: '/cards/details',
              page: () => CardDetailsScreen(),
              middlewares: [
                Guard(), // Add the middleware here
              ],
              binding: BindingsBuilder(() {
                Get.lazyPut<CardDetailsController>(
                    () => CardDetailsController());
              }),
            ),
            GetPage(
              name: '/auth/login',
              page: () => LoginScreen(),
            ),
            GetPage(
              name: '/licenses',
              page: () => const OssLicensesPage(),
            ),
            GetPage(
              name: '/settings',
              page: () => SettingScreen(),
            ),
          ],
        ));
  }
}
