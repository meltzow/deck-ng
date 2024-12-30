import 'package:deck_ng/app_routes.dart';
import 'package:deck_ng/board_details/kanban_board_controller.dart';
import 'package:deck_ng/board_details/kanban_board_screen.dart';
import 'package:deck_ng/card_details/card_details_controller.dart';
import 'package:deck_ng/card_details/card_details_screen.dart';
import 'package:deck_ng/env/env.dart';
import 'package:deck_ng/guard.dart';
import 'package:deck_ng/l10n/translation.dart';
import 'package:deck_ng/licenses/oss_licenses_screen.dart';
import 'package:deck_ng/login/login_controller.dart';
import 'package:deck_ng/login/login_screen.dart';
import 'package:deck_ng/modules/home/binding.dart';
import 'package:deck_ng/modules/home/view.dart';
import 'package:deck_ng/privacy_policy/privacy_policy_controller.dart';
import 'package:deck_ng/privacy_policy/privacy_policy_screen.dart';
import 'package:deck_ng/service/impl/auth_service_impl.dart';
import 'package:deck_ng/service/impl/board_service_impl.dart';
import 'package:deck_ng/service/impl/card_service_impl.dart';
import 'package:deck_ng/service/impl/http_service.dart';
import 'package:deck_ng/service/impl/notification_service_impl.dart';
import 'package:deck_ng/service/impl/stack_repository_impl.dart';
import 'package:deck_ng/service/impl/storage_service_impl.dart';
import 'package:deck_ng/service/impl/tracking_service_impl.dart';
import 'package:deck_ng/service/services.dart';
import 'package:deck_ng/service/tracking_service.dart';
import 'package:deck_ng/settings/settings_controller.dart';
import 'package:deck_ng/settings/settings_screen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:posthog_flutter/posthog_flutter.dart';
import 'package:wiredash/wiredash.dart';

class MyApp extends StatelessWidget {
  final String? initialRoute;
  final List<GetPage>? initialPages;
  final bool debugShowCheckedModeBanner;
  static final navigatorKey = GlobalKey<NavigatorState>();

  const MyApp({
    super.key,
    this.initialRoute,
    this.debugShowCheckedModeBanner = true,
    this.initialPages,
  });

  @override
  Widget build(BuildContext context) {
    return Wiredash(
        projectId:
            Env.IS_PRODUCTION ? 'deck-ng-te1kmcw' : 'deck-ng-tests-7x6ml4x',
        secret:
            Env.IS_PRODUCTION ? Env.WIREDASH_SECRET : Env.WIREDASH_SECRET_TEST,
        psOptions: const PsOptions(
          initialDelay: Duration(days: 7),
          minimumAppStarts: 3,
        ),
        collectMetaData: (metaData) => metaData..custom['language'] = 'de',
        child: GetMaterialApp(
          navigatorObservers: [PosthogObserver()],
          debugShowCheckedModeBanner: debugShowCheckedModeBanner,
          translations: Translation(),
          locale: Get.deviceLocale,
          fallbackLocale: const Locale('en'),
          supportedLocales: const [
            Locale('en'), // English
            Locale('de'), // German
          ],
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          title: 'deck NG',
          initialRoute: initialRoute ?? AppRoutes.home,
          initialBinding: InitialBinding(),
          builder: EasyLoading.init(),
          getPages: initialPages ??
              [
                GetPage(
                    name: AppRoutes.home,
                    page: () => HomePage(),
                    //FIXME: Add the middleware here
                    // middlewares: [Guard()],
                    binding: HomeBinding()),
                GetPage(
                  name: AppRoutes.kanbanBoard,
                  page: () => KanbanBoardScreen(),
                  middlewares: [
                    Guard(), // Add the middleware here
                  ],
                  binding: BindingsBuilder(() {
                    Get.lazyPut<HttpService>(() => HttpServiceImpl());
                    Get.lazyPut<BoardService>(() => BoardServiceImpl());
                    Get.lazyPut<StackService>(() => StackRepositoryImpl());
                    Get.lazyPut<CardService>(() => CardServiceImpl());
                    Get.lazyPut<NotificationService>(
                        () => NotificationServiceImpl());
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
                    Get.lazyPut<HttpService>(() => HttpServiceImpl());
                    Get.lazyPut<BoardService>(() => BoardServiceImpl());
                    Get.lazyPut<CardService>(() => CardServiceImpl());
                    Get.lazyPut<NotificationService>(
                        () => NotificationServiceImpl());
                    Get.lazyPut<CardDetailsController>(
                        () => CardDetailsController());
                  }),
                ),
                GetPage(
                    name: AppRoutes.login,
                    page: () => LoginScreen(),
                    binding: BindingsBuilder(() {
                      Get.lazyPut<NotificationService>(
                          () => NotificationServiceImpl());
                      Get.lazyPut<LoginController>(() => LoginController());
                    })),
                GetPage(
                  name: AppRoutes.licenses,
                  page: () => const OssLicensesPage(),
                ),
                GetPage(
                  name: AppRoutes.privacyPolicy,
                  page: () => PrivacyPolicyScreen(),
                  binding: BindingsBuilder(() {
                    Get.lazyPut<PrivacyPolicyController>(
                        () => PrivacyPolicyController());
                  }),
                ),
                GetPage(
                    name: AppRoutes.settings,
                    page: () => SettingScreen(),
                    binding: BindingsBuilder(() {
                      Get.lazyPut<NotificationService>(
                          () => NotificationServiceImpl());
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
    Get.put<AuthService>(AuthServiceImpl());
    Get.put<StorageService>(StorageServiceImpl());
    Get.put<TrackingService>(TrackingServiceImpl());
  }
}
