import 'package:deck_ng/my_app.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();

  MyApp(debugShowCheckedModeBanner: kDebugMode ? true : false);

}
