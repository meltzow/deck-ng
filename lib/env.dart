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
import 'package:get/get.dart';
import 'package:meta/meta.dart';

enum BuildFlavor { production, development, staging, testing }

class Environment {
  static late final BuildFlavor flavor;

  static Future<void> init({@required flavor}) async {
    Environment.flavor = flavor;
    await initServices();
  }

  static bool isDev() {
    return flavor == BuildFlavor.development;
  }

  static Future<void> initServices() async {
    await Get.putAsync<ICredentialService>(
        () => CredentialServiceImpl().init());

    if (Environment.isDev()) {
      ICredentialService service = Get.find<ICredentialService>();
      if (!service.hasAccount()) {
        service.saveCredentials(
            "http://192.168.178.49:8080", "admin", "admin", true);
      }
    }
    Get.lazyPut<IHttpService>(() => HttpService());
    Get.lazyPut<IAuthService>(() => AuthRepositoryImpl());
    Get.lazyPut<IBoardService>(() => BoardRepositoryImpl());
    Get.lazyPut<IStackService>(() => StackRepositoryImpl());
    Get.lazyPut<Dio>(() => Dio());
    Get.lazyPut<ICardService>(() => CardServiceImpl());
  }
}
