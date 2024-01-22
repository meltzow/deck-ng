import 'package:catcher/catcher.dart';
import 'package:deck_ng/env.dart';
import 'package:deck_ng/my_app.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  BuildEnvironment.init(flavor: BuildFlavor.production);
  assert(env != null);

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
      rootWidget: MyApp(debugShowCheckedModeBanner: false),
      debugConfig: debugOptions,
      releaseConfig: releaseOptions);
}
