import 'package:deck_ng/service/Iauth_service.dart';
import 'package:deck_ng/service/Icredential_service.dart';
import 'package:deck_ng/service/Ihttp_service.dart';
import 'package:deck_ng/service/impl/auth_repository_impl.dart';
import 'package:dio/dio.dart' as dio;
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'auth_service_test.mocks.dart';

const String kTemporaryPath = 'test/data/temporaryPath';
const String kApplicationSupportPath = 'test/data/applicationSupportPath';
const String kDownloadsPath = 'test/data/downloadsPath';
const String kLibraryPath = 'test/data/libraryPath';
const String kApplicationDocumentsPath = 'test/data/applicationDocumentsPath';
const String kExternalCachePath = 'test/data/externalCachePath';
const String kExternalStoragePath = 'test/data/externalStoragePath';

@GenerateMocks([IHttpService, ICredentialService])
void main() {
  late IHttpService httpService;
  late ICredentialService credServiceMock;

  group('authServiceGroup', () {
    setUpAll(() async {
      TestWidgetsFlutterBinding.ensureInitialized();
    });

    setUp(() {
      credServiceMock = Get.put<ICredentialService>(MockICredentialService());
      httpService = Get.put(MockIHttpService());
      PathProviderPlatform.instance = FakePathProviderPlatform();
    });

    test('returns login successfully - all request successfully', () async {
      var resp = LoginPollInfo(Poll('token', 'endpoint'), 'login');
      when(httpService.post('http://localhost:1234/login', false))
          .thenAnswer((_) async => resp.toJson());

      var loginCredentials =
          LoginCredentials('foobarserver', 'foobarusername', 'foobarpassword');

      var ops = dio.RequestOptions();

      when(httpService.retry<LoginCredentials>(any, null)).thenAnswer(
          (_) async => dio.Response<LoginCredentials>(
              data: loginCredentials, requestOptions: ops, statusCode: 200));

      when(credServiceMock.saveCredentials(
              'foobarserver', 'foobarusername', 'foobarpassword', true))
          .thenAnswer((_) async => {});

      final IAuthService authService =
          Get.put<IAuthService>(AuthRepositoryImpl());

      expect(await authService.login('http://localhost:1234/login'), isTrue);
    });

    test('returns login successfully - wait 3 times for loginCredentials',
        () async {
      var resp = LoginPollInfo(Poll('token', 'endpoint'), 'login');
      when(httpService.post('http://localhost:1234/login', false))
          .thenAnswer((_) async => resp.toJson());

      var loginCredentials =
          LoginCredentials('foobarserver', 'foobarusername', 'foobarpassword');

      var ops = dio.RequestOptions(
          path: resp.poll.endpoint,
          queryParameters: {'token': resp.poll.token},
          method: 'post');

      when(httpService.retry<LoginCredentials>(ops, null)).thenAnswer(
          (_) async => dio.Response<LoginCredentials>(
              data: loginCredentials, requestOptions: ops, statusCode: 200));

      final IAuthService authService =
          Get.put<IAuthService>(AuthRepositoryImpl());

      expect(await authService.login('http://localhost:1234/login'), isTrue);
    });
  });
}

class FakePathProviderPlatform extends Fake
    with MockPlatformInterfaceMixin
    implements PathProviderPlatform {
  @override
  Future<String?> getTemporaryPath() async {
    return kTemporaryPath;
  }

  @override
  Future<String?> getApplicationSupportPath() async {
    return kApplicationSupportPath;
  }

  @override
  Future<String?> getLibraryPath() async {
    return kLibraryPath;
  }

  @override
  Future<String?> getApplicationDocumentsPath() async {
    return kApplicationDocumentsPath;
  }

  @override
  Future<String?> getExternalStoragePath() async {
    return kExternalStoragePath;
  }

  @override
  Future<List<String>?> getExternalCachePaths() async {
    return <String>[kExternalCachePath];
  }

  @override
  Future<List<String>?> getExternalStoragePaths({
    StorageDirectory? type,
  }) async {
    return <String>[kExternalStoragePath];
  }

  @override
  Future<String?> getDownloadsPath() async {
    return kDownloadsPath;
  }
}
