import 'package:catcher/catcher.dart';
import 'package:deck_ng/controller/board_details_controller.dart';
import 'package:deck_ng/controller/board_overview_controller.dart';
import 'package:deck_ng/controller/card_details_controller.dart';
import 'package:deck_ng/screen/board_details_screen.dart';
import 'package:deck_ng/screen/board_overview_screen.dart';
import 'package:deck_ng/screen/card_details_screen.dart';
import 'package:deck_ng/screen/login_screen.dart';
import 'package:deck_ng/service/Iauth_service.dart';
import 'package:deck_ng/service/Iboard_service.dart';
import 'package:deck_ng/service/Icard_service.dart';
import 'package:deck_ng/service/Icredential_service.dart';
import 'package:deck_ng/service/Ihttp_service.dart';
import 'package:deck_ng/service/Istack_service.dart';
import 'package:deck_ng/service/impl/auth_repository_impl.dart';
import 'package:deck_ng/service/impl/board_repository_impl.dart';
import 'package:deck_ng/service/impl/card_service_impl.dart';
import 'package:deck_ng/service/impl/credential_service_impl.dart';
import 'package:deck_ng/service/impl/http_service.dart';
import 'package:deck_ng/service/impl/stack_repository_impl.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';

Future<void> main() async {
  await initServices();
  // runApp(const MyApp());

  var snackHandler = SnackbarHandler(
    const Duration(seconds: 5),
    backgroundColor: Colors.red,
    elevation: 2,
    margin: const EdgeInsets.all(16),
    padding: const EdgeInsets.all(16),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    behavior: SnackBarBehavior.floating,
    // action: SnackBarAction(
    //     label: "Button",
    //     onPressed: () {
    //       print("Click!");
    //     }),
    textStyle: const TextStyle(
      color: Colors.white,
      fontSize: 16,
    ),
  );

  /// STEP 1. Create catcher configuration.
  /// Debug configuration with dialog report mode and console handler. It will show dialog and once user accepts it, error will be shown   /// in console.
  CatcherOptions debugOptions =
      CatcherOptions(DialogReportMode(), [ConsoleHandler(), snackHandler]);

  /// Release configuration. Same as above, but once user accepts dialog, user will be prompted to send email with crash to support.
  CatcherOptions releaseOptions =
      CatcherOptions(DialogReportMode(), [snackHandler]);

  /// STEP 2. Pass your root widget (MyApp) along with Catcher configuration:
  Catcher(
      rootWidget: MyApp(),
      debugConfig: debugOptions,
      releaseConfig: releaseOptions);
}

/// Is a smart move to make your Services intiialize before you run the Flutter app.
/// as you can control the execution flow (maybe you need to load some Theme configuration,
/// apiKey, language defined by the User... so load SettingService before running ApiService.
/// so GetMaterialApp() doesnt have to rebuild, and takes the values directly.
Future<void> initServices() async {
  print('starting services ...');

  await Get.putAsync<ICredentialService>(() => CredentialServiceImpl().init());
  Get.lazyPut<IHttpService>(() => HttpService());
  Get.lazyPut<IAuthService>(() => AuthRepositoryImpl());
  Get.lazyPut<IBoardService>(() => BoardRepositoryImpl());
  Get.lazyPut<IStackService>(() => StackRepositoryImpl());
  Get.lazyPut<Dio>(() => Dio());
  Get.lazyPut<ICardService>(() => CardServiceImpl());
}

class MyApp extends StatelessWidget {
  String? initialRoute;
  bool debugShowCheckedModeBanner;

  MyApp({super.key, this.initialRoute, this.debugShowCheckedModeBanner = true});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: debugShowCheckedModeBanner,
      navigatorKey: Catcher.navigatorKey,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: initialRoute ?? '/auth/login',
      getPages: [
        GetPage(
            name: '/',
            page: () => const BoardOverviewScreen(),
            binding: BindingsBuilder(() {
              Get.put<BoardOverviewController>(BoardOverviewController());
            })),
        GetPage(
          name: '/boards/details',
          page: () => BoardDetailsScreen(),
          binding: BindingsBuilder(() {
            Get.lazyPut<BoardDetailsController>(() => BoardDetailsController());
          }),
        ),
        GetPage(
          name: '/cards/details',
          page: () => CardDetailsScreen(),
          binding: BindingsBuilder(() {
            Get.lazyPut<CardDetailsController>(() => CardDetailsController());
          }),
        ),
        GetPage(
          name: '/auth/login',
          page: () => const LoginScreen(),
        ),
      ],
    );
  }
}
