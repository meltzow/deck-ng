import 'package:deck_ng/env.dart';
import 'package:deck_ng/model/account.dart';
import 'package:deck_ng/service/Icredential_service.dart';
import 'package:deck_ng/service/impl/credential_service_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';

import 'fake_provider.dart';

const String kTemporaryPath = 'test/data/temporaryPath';
const String kApplicationSupportPath = 'test/data/applicationSupportPath';
const String kDownloadsPath = 'test/data/downloadsPath';
const String kLibraryPath = 'test/data/libraryPath';
const String kApplicationDocumentsPath = 'test/data/applicationDocumentsPath';
const String kExternalCachePath = 'test/data/externalCachePath';
const String kExternalStoragePath = 'test/data/externalStoragePath';

void main() {
  group('credentialServiceGroup', () {
    setUpAll(() async {
      TestWidgetsFlutterBinding.ensureInitialized();
      BuildEnvironment.init(flavor: BuildFlavor.staging);
    });

    setUp(() {
      PathProviderPlatform.instance = FakePathProviderPlatform();
    });

    test('simple save test', () async {
      await Get.putAsync<ICredentialService>(
          () => CredentialServiceImpl().init());
      final ICredentialService credentialService =
          Get.find<ICredentialService>();

      await credentialService.saveCredentials(
          'http://localhost:1234/login', 'username', 'password', true);

      var account = Account(
          username: 'username',
          password: 'password',
          authData: '',
          url: '',
          isAuthenticated: false);

      var savedAccount = await credentialService.getAccount();
      expect(savedAccount.password, account.password);
      expect(savedAccount.url, 'http://localhost:1234/login');
    });

    test('remove last "/"  if url ends with it', () async {
      await Get.putAsync<ICredentialService>(
          () => CredentialServiceImpl().init());
      final ICredentialService credentialService =
          Get.find<ICredentialService>();

      await credentialService.saveCredentials(
          'http://localhost:1234/login/', 'username', 'password', true);

      var account = Account(
          username: 'username',
          password: 'password',
          authData: '',
          url: '',
          isAuthenticated: false);

      var savedAccount = await credentialService.getAccount();
      expect(savedAccount.password, account.password);
      expect(savedAccount.url, 'http://localhost:1234/login');
    });
  });
}
