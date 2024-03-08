import 'package:deck_ng/service/Iauth_service.dart';
import 'package:deck_ng/service/Icredential_service.dart';
import 'package:deck_ng/service/impl/auth_service_impl.dart';
import 'package:dio/dio.dart' as dio;
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:mockito/annotations.dart';
import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';

import 'auth_service_test.mocks.dart';
import 'fake_provider.dart';
import 'http_matcher.dart';

@GenerateMocks([IStorageService])
void main() {
  late IStorageService credServiceMock;
  late dio.Dio dioClient;
  late DioAdapter dioAdapter;

  group('authServiceGroup', () {
    setUpAll(() async {
      TestWidgetsFlutterBinding.ensureInitialized();
      PathProviderPlatform.instance = FakePathProviderPlatform();
    });

    setUp(() {
      credServiceMock = Get.put<IStorageService>(MockIStorageService());
      dioClient = Get.put(dio.Dio());
      dioAdapter = DioAdapter(
        dio: dioClient,
        matcher: const FullHttpRequestDataMatcher(),
      );
    });

    test('trivial test of getAccount', () async {
      final IAuthService authService = Get.put<IAuthService>(AuthServiceImpl());
    });

    // test('returns login successfully - all request successfully', () async {
    //   var resp = LoginPollInfo(Poll('token', 'endpoint'), 'login');
    //   when(httpService.post('http://localhost:1234/login', false))
    //       .thenAnswer((_) async => resp.toJson());
    //
    //   var loginCredentials =
    //       LoginCredentials('foobarserver', 'foobarusername', 'foobarpassword');
    //
    //   var ops = dio.RequestOptions();
    //
    //   when(httpService.retry<LoginCredentials>(any, null)).thenAnswer(
    //       (_) async => dio.Response<LoginCredentials>(
    //           data: loginCredentials, requestOptions: ops, statusCode: 200));
    //
    //   when(credServiceMock.saveCredentials(
    //           'foobarserver', 'foobarusername', 'foobarpassword', true))
    //       .thenAnswer((_) async => {});
    //
    //   final IAuthService authService =
    //       Get.put<IAuthService>(AuthServiceImpl());
    //
    //   expect(await authService.login('http://localhost:1234/login'), isTrue);
    // });
    //
    // test('returns login successfully - wait 3 times for loginCredentials',
    //     () async {
    //   var resp = LoginPollInfo(Poll('token', 'endpoint'), 'login');
    //   when(httpService.post('http://localhost:1234/login', false))
    //       .thenAnswer((_) async => resp.toJson());
    //
    //   var loginCredentials =
    //       LoginCredentials('foobarserver', 'foobarusername', 'foobarpassword');
    //
    //   var ops = dio.RequestOptions(
    //       path: resp.poll.endpoint,
    //       queryParameters: {'token': resp.poll.token},
    //       method: 'post');
    //
    //   when(httpService.retry<LoginCredentials>(ops, null)).thenAnswer(
    //       (_) async => dio.Response<LoginCredentials>(
    //           data: loginCredentials, requestOptions: ops, statusCode: 200));
    //
    //   final IAuthService authService =
    //       Get.put<IAuthService>(AuthServiceImpl());
    //
    //   expect(await authService.login('http://localhost:1234/login'), isTrue);
    // });
  });
}
