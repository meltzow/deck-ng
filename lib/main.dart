import 'package:catcher/catcher.dart';
import 'package:deck_ng/binding/auth_binding.dart';
import 'package:deck_ng/controller/LoginController.dart';
import 'package:deck_ng/controller/board_details_controller.dart';
import 'package:deck_ng/screen/board_details_screen.dart';
import 'package:deck_ng/screen/board_overview_screen.dart';
import 'package:deck_ng/screen/login_screen.dart';
import 'package:deck_ng/service/impl/auth_repository_impl.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<void> main() async {
  await initServices();
  // runApp(const MyApp());

  var snackHandler = SnackbarHandler(
    const Duration(seconds: 5),
    backgroundColor: Colors.red,
    elevation: 2,
    margin: EdgeInsets.all(16),
    padding: EdgeInsets.all(16),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    behavior: SnackBarBehavior.floating,
    // action: SnackBarAction(
    //     label: "Button",
    //     onPressed: () {
    //       print("Click!");
    //     }),
    textStyle: TextStyle(
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
      rootWidget: const MyApp(),
      debugConfig: debugOptions,
      releaseConfig: releaseOptions);
}

/// Is a smart move to make your Services intiialize before you run the Flutter app.
/// as you can control the execution flow (maybe you need to load some Theme configuration,
/// apiKey, language defined by the User... so load SettingService before running ApiService.
/// so GetMaterialApp() doesnt have to rebuild, and takes the values directly.
Future<void> initServices() async {
  print('starting services ...');

  /// Here is where you put get_storage, hive, shared_pref initialization.
  /// or moor connection, or whatever that's async.
  await Get.putAsync(() => AuthRepositoryImpl().init());
  print('All services started...');
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      navigatorKey: Catcher.navigatorKey,
      title: 'Flutter Demo',
      initialBinding: AuthBinding(),
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a blue toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/auth/login',
      getPages: [
        GetPage(name: '/', page: () => BoardOverviewScreen()),
        GetPage(
          name: '/boards/details',
          page: () => BoardDetailsScreen(),
          binding: BindingsBuilder(() {
            Get.lazyPut<BoardDetailsController>(() => BoardDetailsController());
          }),
        ),
        GetPage(
          name: '/auth/login',
          page: () => LoginScreen(),
          binding: BindingsBuilder(() {
            Get.lazyPut<LoginController>(() => LoginController());
          }),
        ),
      ],
    );
  }
}
