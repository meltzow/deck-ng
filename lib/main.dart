import 'package:deck_ng/env/env.dart';
import 'package:deck_ng/my_app.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';
import 'package:yaml/yaml.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final version = await getVersion();
  Env.VERSION = version;
  await GetStorage.init();

  runApp(const MyApp(debugShowCheckedModeBanner: kDebugMode ? true : false));
}

Future<String> getVersion() async {
  final content = await rootBundle.loadString('pubspec.yaml');
  final yamlMap = loadYaml(content);
  return yamlMap['version'];
}
