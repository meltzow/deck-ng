import 'package:deck_ng/service/Iauth_service.dart';
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

const String kTemporaryPath = 'temporaryPath';
const String kApplicationSupportPath = 'applicationSupportPath';
const String kDownloadsPath = 'downloadsPath';
const String kLibraryPath = 'libraryPath';
const String kApplicationDocumentsPath = 'applicationDocumentsPath';
const String kExternalCachePath = 'externalCachePath';
const String kExternalStoragePath = 'externalStoragePath';

@GenerateMocks([IHttpService])
void main() {
  late IHttpService httpService;

  group('authServiceGroup', () {
    setUpAll(() async {
      TestWidgetsFlutterBinding.ensureInitialized();
    });

    setUp(() {
      httpService = Get.put(MockIHttpService());
      PathProviderPlatform.instance = FakePathProviderPlatform();
    });

    test('returns login successfully - all request successfully', () async {
      var resp = LoginPollInfo(Poll('token', 'endpoint'), 'login');
      when(httpService.post('http://localhost:1234/login', false))
          .thenAnswer((_) async => resp.toJson());

      var loginCredentials =
          LoginCredentials('foobarserver', 'foobarusername', 'foobarpassword');

      var ops = dio.RequestOptions(
          path: resp.poll.endpoint,
          queryParameters: {'token': resp.poll.token},
          method: 'post');
      when(httpService.retry(
              path: ops.path,
              method: ops.method,
              queryParameters: ops.queryParameters))
          .thenAnswer((_) async => dio.Response<LoginCredentials>(
              data: loginCredentials, requestOptions: ops, statusCode: 200));

      final IAuthService authService =
          Get.put<IAuthService>(await AuthRepositoryImpl().init());

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

      var callCount = 0;
      when(httpService.retry<LoginCredentials>(
              path: ops.path,
              method: ops.method,
              queryParameters: ops.queryParameters))
          .thenAnswer((_) async => [
                dio.Response<LoginCredentials>(
                    data: loginCredentials,
                    requestOptions: ops,
                    statusCode: 400),
                dio.Response<LoginCredentials>(
                    data: loginCredentials,
                    requestOptions: ops,
                    statusCode: 400),
                dio.Response<LoginCredentials>(
                    data: loginCredentials,
                    requestOptions: ops,
                    statusCode: 200)
              ][callCount++]);

      final IAuthService authService =
          Get.put<IAuthService>(await AuthRepositoryImpl().init());

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
