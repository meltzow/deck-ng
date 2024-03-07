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
import 'package:deck_ng/service/guard.dart';
import 'package:deck_ng/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wiredash/wiredash.dart';

class MyApp extends StatelessWidget {
  final String? initialRoute;
  final bool debugShowCheckedModeBanner;
  final locale = const Locale('en', 'US');

  const MyApp(
      {super.key, this.initialRoute, this.debugShowCheckedModeBanner = true});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Wiredash(
        projectId: 'deck-ng-te1kmcw',
        secret: DartDefine.wiredashSecret,
        collectMetaData: (metaData) => metaData..custom['serverUrl'] = 'foobar',
        child: GetMaterialApp(
          debugShowCheckedModeBanner: debugShowCheckedModeBanner,
          navigatorKey: Catcher2.navigatorKey,
          translations: Translation(),
          locale: locale,
          fallbackLocale: const Locale('en', 'US'),
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
          ],
        ));
  }
}
