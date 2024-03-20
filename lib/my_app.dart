import 'package:catcher_2/catcher_2.dart';
import 'package:deck_ng/app_routes.dart';
import 'package:deck_ng/controller/card_details_controller.dart';
import 'package:deck_ng/controller/dashboard_controller.dart';
import 'package:deck_ng/controller/kanban_board_controller.dart';
import 'package:deck_ng/controller/login_controller.dart';
import 'package:deck_ng/controller/settings_controller.dart';
import 'package:deck_ng/dart_define.gen.dart';
import 'package:deck_ng/l10n/translation.dart';
import 'package:deck_ng/screen/card_details_screen.dart';
import 'package:deck_ng/screen/dashboard_screen.dart';
import 'package:deck_ng/screen/kanban_board_screen.dart';
import 'package:deck_ng/screen/login_screen.dart';
import 'package:deck_ng/screen/oss_licenses_screen.dart';
import 'package:deck_ng/screen/settings_screen.dart';
import 'package:deck_ng/service/Iauth_service.dart';
import 'package:deck_ng/service/Iboard_service.dart';
import 'package:deck_ng/service/Icard_service.dart';
import 'package:deck_ng/service/Ihttp_service.dart';
import 'package:deck_ng/service/Inotification_service.dart';
import 'package:deck_ng/service/Istack_service.dart';
import 'package:deck_ng/service/Istorage_service.dart';
import 'package:deck_ng/service/guard.dart';
import 'package:deck_ng/service/impl/auth_service_impl.dart';
import 'package:deck_ng/service/impl/board_service_impl.dart';
import 'package:deck_ng/service/impl/card_service_impl.dart';
import 'package:deck_ng/service/impl/http_service.dart';
import 'package:deck_ng/service/impl/notification_service_impl.dart';
import 'package:deck_ng/service/impl/stack_repository_impl.dart';
import 'package:deck_ng/service/impl/storage_service_impl.dart';
import 'package:deck_ng/theme.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wiredash/wiredash.dart';

class MyApp extends StatelessWidget {
  final String? initialRoute;
  List<GetPage>? initialPages;
  final bool debugShowCheckedModeBanner;
  static final navigatorKey = GlobalKey<NavigatorState>();

  MyApp(
      {super.key,
      this.initialRoute,
      this.debugShowCheckedModeBanner = true,
      this.initialPages});

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
          locale: Get.deviceLocale,
          fallbackLocale: const Locale('en'),
          supportedLocales: Translation.appLanguages
              .map((e) => e['locale'] as Locale)
              .toList(),
          title: 'deck NG',
          theme: myTheme,
          initialRoute: initialRoute ?? AppRoutes.home,
          initialBinding: InitialBinding(),
          getPages: initialPages ??
              [
                GetPage(
                    name: AppRoutes.home,
                    page: () => DashboardScreen(),
                    middlewares: [
                      Guard(), // Add the middleware here
                    ],
                    binding: BindingsBuilder(() {
                      Get.lazyPut<IHttpService>(() => HttpService());
                      Get.lazyPut<IBoardService>(() => BoardServiceImpl());
                      Get.lazyPut<IStackService>(() => StackRepositoryImpl());
                      Get.lazyPut<DashboardController>(
                          () => DashboardController());
                    })),
                GetPage(
                  parameters: const {'boardId': '22'},
                  name: AppRoutes.kanbanBoard,
                  page: () => KanbanBoardScreen(),
                  middlewares: [
                    Guard(), // Add the middleware here
                  ],
                  binding: BindingsBuilder(() {
                    Get.lazyPut<IHttpService>(() => HttpService());
                    Get.lazyPut<IBoardService>(() => BoardServiceImpl());
                    Get.lazyPut<IStackService>(() => StackRepositoryImpl());
                    Get.lazyPut<ICardService>(() => CardServiceImpl());
                    Get.lazyPut<KanbanBoardController>(
                        () => KanbanBoardController());
                  }),
                ),
                GetPage(
                  name: AppRoutes.cardDetails,
                  page: () => CardDetailsScreen(),
                  middlewares: [
                    Guard(), // Add the middleware here
                  ],
                  binding: BindingsBuilder(() {
                    Get.lazyPut<IHttpService>(() => HttpService());
                    Get.lazyPut<IBoardService>(() => BoardServiceImpl());
                    Get.lazyPut<ICardService>(() => CardServiceImpl());
                    Get.lazyPut<CardDetailsController>(
                        () => CardDetailsController());
                  }),
                ),
                GetPage(
                    name: AppRoutes.login,
                    page: () => LoginScreen(),
                    binding: BindingsBuilder(() {
                      Get.lazyPut<INotificationService>(
                          () => NotificationService());
                      Get.lazyPut<LoginController>(() => LoginController());
                    })),
                GetPage(
                  name: AppRoutes.licenses,
                  page: () => const OssLicensesPage(),
                ),
                GetPage(
                    name: AppRoutes.settings,
                    page: () => SettingScreen(),
                    binding: BindingsBuilder(() {
                      Get.lazyPut<INotificationService>(
                          () => NotificationService());
                      Get.lazyPut<SettingsController>(
                          () => SettingsController());
                    })),
              ],
        ));
  }
}

class InitialBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<Dio>(Dio());
    Get.put<IAuthService>(AuthServiceImpl());
    Get.put<IStorageService>(StorageServiceImpl());
  }
}
