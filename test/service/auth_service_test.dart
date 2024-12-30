import 'package:deck_ng/model/account.dart';
import 'package:deck_ng/service/impl/nextcloud/auth_service_impl.dart';
import 'package:deck_ng/service/services.dart';
import 'package:dio/dio.dart' as dio;
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';

import 'auth_service_test.mocks.dart';
import 'fake_provider.dart';
import 'http_matcher.dart';

@GenerateMocks([StorageService])
void main() {
  late StorageService storageServiceMock;
  late dio.Dio dioClient;
  late DioAdapter dioAdapter;

  group('authServiceGroup', () {
    setUpAll(() async {
      TestWidgetsFlutterBinding.ensureInitialized();
      PathProviderPlatform.instance = FakePathProviderPlatform();
    });

    setUp(() {
      storageServiceMock = Get.put<StorageService>(MockStorageService());
      dioClient = Get.put(dio.Dio());
      dioAdapter = DioAdapter(
        dio: dioClient,
        matcher: const FullHttpRequestDataMatcher(),
      );
    });

    tearDown(() {
      Get.reset();
    });

    test('login with a suburl', () async {
      final AuthService authService = Get.put<AuthService>(AuthServiceImpl());

      when(storageServiceMock.saveAccount(argThat(isA<Account>())))
          .thenAnswer((_) async => {});

      var resp = AppPassword(
          AppPasswordOcs(meta: Meta('', 200, ''), data: AppPasswordData('')));

      dioAdapter.onGet(
          'https://localhost:1234/nextcloud/ocs/v2.php/core/autocomplete/get?search=JOANNE%40EMAIL.ISP&itemType=%20&itemId=%20&shareTypes[]=8&limit=2',
          (server) {
        return server.reply(
          200,
          '',
          delay: const Duration(milliseconds: 10),
        );
      }, headers: {
        'accept': 'application/json',
        'user-agent': 'deckNG client',
        'authorization': 'Basic dXNlcm5hbWU6cGFzc3dvcmQ=',
        'OCS-APIREQUEST': 'true'
      });

      dioAdapter.onGet(
          'https://localhost:1234/nextcloud/ocs/v2.php/core/getapppassword',
          (server) {
        return server.reply(
          200,
          resp.toJson(),
          delay: const Duration(milliseconds: 10),
        );
      }, headers: {
        'accept': 'application/json',
        'user-agent': 'deckNG client',
        'authorization': 'Basic dXNlcm5hbWU6cGFzc3dvcmQ=',
        'OCS-APIREQUEST': 'true'
      });

      var success = await authService.login(
          'https://localhost:1234/nextcloud', 'username', 'password', '');

      expect(success, true);

      verify(storageServiceMock.saveAccount(argThat(isA<Account>()))).called(3);
    });

    test('login with a suburl which ends with "/"', () async {
      final AuthService authService = Get.put<AuthService>(AuthServiceImpl());

      when(storageServiceMock.saveAccount(argThat(isA<Account>())))
          .thenAnswer((_) async => {});

      dioAdapter.onGet(
          'https://localhost:1234/nextcloud/ocs/v2.php/core/autocomplete/get?search=JOANNE%40EMAIL.ISP&itemType=%20&itemId=%20&shareTypes[]=8&limit=2',
          (server) {
        return server.reply(
          200,
          '',
          delay: const Duration(milliseconds: 10),
        );
      }, headers: {
        'accept': 'application/json',
        'user-agent': 'deckNG client',
        'authorization': 'Basic dXNlcm5hbWU6cGFzc3dvcmQ=',
        'OCS-APIREQUEST': 'true'
      });

      var resp = AppPassword(
          AppPasswordOcs(meta: Meta('', 200, ''), data: AppPasswordData('')));

      dioAdapter.onGet(
          'https://localhost:1234/nextcloud/ocs/v2.php/core/getapppassword',
          (server) {
        return server.reply(
          200,
          resp.toJson(),
          delay: const Duration(milliseconds: 10),
        );
      }, headers: {
        'accept': 'application/json',
        'user-agent': 'deckNG client',
        'authorization': 'Basic dXNlcm5hbWU6cGFzc3dvcmQ=',
        'OCS-APIREQUEST': 'true'
      });

      var success = await authService.login(
          'https://localhost:1234/nextcloud/', 'username', 'password', '');

      expect(success, true);
      verify(storageServiceMock.saveAccount(argThat(
        predicate<Account>(
            (account) => account.url == 'https://localhost:1234/nextcloud'),
      ))).called(3);
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
