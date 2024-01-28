import 'package:deck_ng/service/Iauth_service.dart';
import 'package:deck_ng/service/Iboard_service.dart';
import 'package:deck_ng/service/Icard_service.dart';
import 'package:deck_ng/service/Icredential_service.dart';
import 'package:deck_ng/service/Ihttp_service.dart';
import 'package:deck_ng/service/Istack_service.dart';
import 'package:deck_ng/service/impl/auth_service_impl.dart';
import 'package:deck_ng/service/impl/board_service_impl.dart';
import 'package:deck_ng/service/impl/card_service_impl.dart';
import 'package:deck_ng/service/impl/credential_service_impl.dart';
import 'package:deck_ng/service/impl/http_service.dart';
import 'package:deck_ng/service/impl/stack_repository_impl.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';

enum BuildFlavor { production, development, staging }

BuildEnvironment? get env => _env;
BuildEnvironment? _env;

class BuildEnvironment {
  final BuildFlavor flavor;

  BuildEnvironment._init({required this.flavor});

  /// Sets up the top-level [env] getter on the first call only.
  static void init({@required flavor}) =>
      _env ??= BuildEnvironment._init(flavor: flavor);

  bool isDev() {
    return flavor == BuildFlavor.development;
  }
}

Future<void> initServices() async {
  print('starting services ...');

  await Get.putAsync<ICredentialService>(() => CredentialServiceImpl().init());
  Get.lazyPut<IHttpService>(() => HttpService());
  Get.lazyPut<IAuthService>(() => AuthServiceImpl());
  Get.lazyPut<IBoardService>(() => BoardServiceImpl());
  Get.lazyPut<IStackService>(() => StackRepositoryImpl());
  Get.lazyPut<Dio>(() => Dio());
  Get.lazyPut<ICardService>(() => CardServiceImpl());
}
