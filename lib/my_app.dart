import 'package:catcher_2/catcher_2.dart';
import 'package:deck_ng/controller/board_details_controller.dart';
import 'package:deck_ng/controller/board_overview_controller.dart';
import 'package:deck_ng/controller/card_details_controller.dart';
import 'package:deck_ng/screen/DashboardScreen.dart';
import 'package:deck_ng/screen/LoginScreen.dart';
import 'package:deck_ng/screen/card_details_screen.dart';
import 'package:deck_ng/screen/kanban_board_screen.dart';
import 'package:deck_ng/service/guard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';

class MyApp extends StatelessWidget {
  String? initialRoute;
  bool debugShowCheckedModeBanner;

  MyApp({super.key, this.initialRoute, this.debugShowCheckedModeBanner = true});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: debugShowCheckedModeBanner,
      navigatorKey: Catcher2.navigatorKey,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      title: 'deck NG',
      theme:
          ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue)),
      initialRoute: initialRoute ?? '/',
      getPages: [
        GetPage(
            name: '/',
            page: () => DashboardScreen(),
            middlewares: [
              Guard(), // Add the middleware here
            ],
            binding: BindingsBuilder(() {
              Get.put<BoardOverviewController>(BoardOverviewController());
            })),
        GetPage(
          name: '/boards/details',
          page: () => KanbanBoardScreen(),
          middlewares: [
            Guard(), // Add the middleware here
          ],
          binding: BindingsBuilder(() {
            Get.lazyPut<BoardDetailsController>(() => BoardDetailsController());
          }),
        ),
        GetPage(
          name: '/cards/details',
          page: () => CardDetailsScreen(),
          middlewares: [
            Guard(), // Add the middleware here
          ],
          binding: BindingsBuilder(() {
            Get.lazyPut<CardDetailsController>(() => CardDetailsController());
          }),
        ),
        GetPage(
          name: '/auth/login',
          page: () => LoginScreen(),
        ),
      ],
    );
  }
}
