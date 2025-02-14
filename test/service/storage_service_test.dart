import 'package:deck_ng/model/account.dart';
import 'package:deck_ng/service/impl/storage_service_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_storage/get_storage.dart';
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
      PathProviderPlatform.instance = FakePathProviderPlatform();
    });

    // setUp(() {
    //
    // });

    test('simple save test', () async {
      await GetStorage.init();

      var service = StorageServiceImpl();

      var account = Account(
          username: 'username',
          password: 'password',
          authData: '',
          url: 'http://localhost:1234/login',
          isAuthenticated: false);
      await service.saveAccount(account);

      var savedAccount = service.getAccount();
      expect(savedAccount?.password, account.password);
      expect(savedAccount?.url, 'http://localhost:1234/login');
    });
  });
}
