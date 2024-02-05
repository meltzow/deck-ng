@TestOn('vm')
import 'dart:math';

import 'package:deck_ng/model/account.dart';
import 'package:deck_ng/model/board.dart';
import 'package:deck_ng/service/Iauth_service.dart';
import 'package:deck_ng/service/Icredential_service.dart';
import 'package:deck_ng/service/impl/http_service.dart';
import 'package:deck_ng/service/impl/retry.dart';
import 'package:dio/dio.dart' as dio;
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'http_matcher.dart';
import 'http_service_test.mocks.dart';

@GenerateMocks([IAuthService, IStorageService])
void main() {
  late dio.Dio dioClient;
  late DioAdapter dioAdapter;

  group('httpServiceGroup', () {
    setUpAll(() async {
      TestWidgetsFlutterBinding.ensureInitialized();
    });

    setUp(() {
      dioClient = Get.put(dio.Dio());
      dioAdapter = DioAdapter(
        dio: dioClient,
        matcher: const FullHttpRequestDataMatcher(),
      );
    });

    test(
        'depending on header changes (increment) delivering different statuscodes',
        () async {
      final dioclient = Get.find<dio.Dio>();

      dioAdapter.onPost('https://mock.codes/400', (server) {
        return server.reply(
          400,
          null,
          delay: const Duration(milliseconds: 10),
        );
      }, headers: {RetryOptions.retryHeader: 1});

      dioAdapter.onPost('https://mock.codes/400', (server) {
        return server.reply(
          400,
          null,
          delay: const Duration(milliseconds: 10),
        );
      }, headers: {RetryOptions.retryHeader: 2});

      dioAdapter.onPost('https://mock.codes/400', (server) {
        return server.reply(
          200,
          (dio.RequestOptions options) => Random().nextDouble(),
          delay: const Duration(milliseconds: 10),
        );
      }, headers: {RetryOptions.retryHeader: 3});

      try {
        await dioclient.post<dynamic>('https://mock.codes/400',
            options: dio.Options(headers: {RetryOptions.retryHeader: 1}));
        fail("dio exception expected");
      } on dio.DioException catch (error) {
        print(error);
        expect(error, isNotNull);
        expect(error.response, isNotNull);
        expect(error.response!.statusCode, 400);
      }

      try {
        await dioclient.post<dynamic>('https://mock.codes/400',
            options: dio.Options(headers: {RetryOptions.retryHeader: 2}));
        fail("dio exception expected");
      } on dio.DioException catch (error) {
        print(error);
        expect(error, isNotNull);
        expect(error.response, isNotNull);
        expect(error.response!.statusCode, 400);
      }

      var resp3 = await dioclient.post<dynamic>('https://mock.codes/400',
          options: dio.Options(headers: {RetryOptions.retryHeader: 3}));
      expect(resp3.statusCode, 200);

      final authServiceMock = Get.put<IAuthService>(MockIAuthService());
      Get.put<IStorageService>(MockIStorageService());
      final HttpService service = Get.put(HttpService());
      var response;
      try {
        var ops =
            dio.RequestOptions(method: 'POST', path: 'https://mock.codes/400');
        response = await service.retry(
            ops, const RetryOptions(delayFactor: Duration(milliseconds: 10)));

        expect(response, isA());
        expect(response.statusCode, 200);
      } on dio.DioException catch (error) {
        fail("no exception expected");
      }
    });

    test('test simple GET Request by getting all boards', () async {
      final credServiceMock =
          Get.put<IStorageService>(MockIStorageService());
      final HttpService service = Get.put(HttpService());

      dioAdapter.onGet(
          'http://url.foo/index.php/apps/deck/api/v1/boards',
          (server) => server.reply(
                200,
                Board(title: 'foo', id: 1).toJson(),
                delay: const Duration(milliseconds: 10),
              ));

      when(credServiceMock.getAccount()).thenReturn(Account(
              'username',
               'foobar',
               'authData',
               'http://url.foo',
               true));

      var response = await service.get('/index.php/apps/deck/api/v1/boards');
      expect(response, isA<Map<String, dynamic>>());
      expect(response['title'], "foo");
    });

    test('test retrying after waiting until third successfully request',
        () async {
      Get.put<IAuthService>(MockIAuthService());

      final HttpService service = Get.put(HttpService());
      dioAdapter.onPost('http://url.foo/index.php/apps/deck/api/v1/boards',
          (server) {
        return server.reply(
          400,
          null,
        );
      });

      dioAdapter.onPost('http://url.foo/index.php/apps/deck/api/v1/boards',
          (server) {
        return server.reply(200, null);
      }, headers: {RetryOptions.retryHeader: 3});

      var response;
      try {
        var ops = dio.RequestOptions(
            method: 'POST',
            path: 'http://url.foo/index.php/apps/deck/api/v1/boards');

        var retryOps =
            const RetryOptions(delayFactor: Duration(milliseconds: 10));
        response = await service.retry(ops, retryOps);

        expect(response, isA());
        expect(response.statusCode, 200);
      } on dio.DioException catch (error) {
        fail("no exception expected");
      }
    });

    test(
        'test retrying but without successfully request, max attempts are reached',
        () async {
      Get.put<IAuthService>(MockIAuthService());

      final HttpService service = Get.put(HttpService());
      dioAdapter.onPost('http://url.foo/index.php/apps/deck/api/v1/boards',
          (server) {
        return server.reply(
          400,
          null,
        );
      });

      var response;
      try {
        var ops = dio.RequestOptions(
            method: 'POST',
            path: 'http://url.foo/index.php/apps/deck/api/v1/boards');

        var retryOps =
            const RetryOptions(delayFactor: Duration(milliseconds: 10));
        response = await service.retry(ops, retryOps);

        fail("no successfully response expected");
      } on dio.DioException catch (error) {
        expect(error, isNotNull);
        expect(error.response!.statusCode, 400);
      }
    });
  });
}
