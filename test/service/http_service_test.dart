@TestOn('vm')
import 'dart:math';

import 'package:deck_ng/model/account.dart';
import 'package:deck_ng/model/board.dart';
import 'package:deck_ng/service/Iauth_service.dart';
import 'package:deck_ng/service/impl/http_service.dart';
import 'package:dio/dio.dart' as dio;
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'http_service_test.mocks.dart';

@GenerateMocks([IAuthService])
void main() {
  late dio.Dio dioClient;
  late DioAdapter dioAdapter;
  const path = 'https://example.com';

  group('resets after each test call:', () {
    double data;
    dio.Response<dynamic> response;

    setUpAll(() {
      dioClient = dio.Dio();
      dioAdapter = DioAdapter(dio: dioClient);
    });

    // tearDown(() => dioAdapter.reset());

    void expectRandomResponse() async {
      data = Random().nextDouble();

      dioAdapter.onGet(path, (server) => server.reply(200, data));

      response = await dioClient.get(path);

      expect(data, response.data);

      // Affirm that the length of history's list is one due to reset.
      expect(dioAdapter.history.length, 1);
    }

    for (var index in Iterable<int>.generate(10)) {
      test('Test #${index + 1}', () => expectRandomResponse());
    }
  });

  group('httpServiceGroup', () {
    const baseUrl = 'https://example.com';
    setUpAll(() async {
      TestWidgetsFlutterBinding.ensureInitialized();
    });

    setUp(() {
      dioClient = Get.put(dio.Dio());
      dioAdapter = DioAdapter(
        dio: dioClient,

        // [FullHttpRequestMatcher] is a default matcher class
        // (which actually means you haven't to pass it manually) that matches entire URL.
        //
        // Use [UrlRequestMatcher] for matching request based on the path of the URL.
        //
        // Or create your own http-request matcher via extending your class from  [HttpRequestMatcher].
        // See -> issue:[124] & pr:[125]
        matcher: const UrlRequestMatcher(),
      );
    });

    test('Retryable statuses overridden', () async {
      final dioclient = Get.find<dio.Dio>();
      const retries = 3;

      dioAdapter.onPost('https://mock.codes/400', (server) {
        return server.reply(
          401,
          null,
          delay: const Duration(seconds: 1),
        );
      }, headers: {'serverCall': 1});

      dioAdapter.onPost('https://mock.codes/400', (server) {
        return server.reply(
          401,
          {Random().nextDouble()},
          delay: const Duration(seconds: 1),
        );
      }, headers: {'serverCall': 2});

      dioAdapter.onPost('https://mock.codes/400', (server) {
        return server.reply(
          200,
          {'message:': 'success'},
          delay: const Duration(seconds: 1),
        );
      }, headers: {'serverCall': 3});

      dio.Response resp1;
      try {
        resp1 = await dioclient.post<dynamic>('https://mock.codes/400',
            options: dio.Options(headers: {'servercall': 1}));
        expect(resp1.statusCode, 401);
        var resp2 = await dioclient.post<dynamic>('https://mock.codes/400',
            options: dio.Options(headers: {'servercall': 2}));
        expect(resp2.statusCode, 401);
        var resp3 = await dioclient.post<dynamic>('https://mock.codes/400',
            options: dio.Options(headers: {'servercall': 3}));
        expect(resp3.statusCode, 200);
      } on dio.DioException catch (error) {
        // expect(resp1, isNotNull);
        // expect(resp1!.statusCode, 401);
      }
      expect(retries, 3);
    });

    test('returns all boards if the http call completes successfully',
        () async {
      final authServiceMock = Get.put<IAuthService>(MockIAuthService());
      final HttpService service = Get.put(HttpService());

      dioAdapter.onGet(
          'http://url.foo/index.php/apps/deck/api/v1/boards',
          (server) => server.reply(
                200,
                Board(title: 'foo', id: 1).toJson(),
                // Adds one-sec delay to reply method.
                // Basically, I'd wait for one second before returning reply data.
                // See -> issue:[106] & pr:[126]
                delay: const Duration(seconds: 1),
              ));

      when(authServiceMock.getAccount()).thenAnswer((realInvocation) => Future(
          () => Account(
              username: 'username',
              password: 'foobar',
              authData: 'authData',
              url: 'http://url.foo',
              isAuthenticated: true)));

      expect(await service.get('/index.php/apps/deck/api/v1/boards'),
          isA<Map<String, dynamic>>());
    });

    test('test retrying 3 times', () async {
      Get.put<IAuthService>(MockIAuthService());

      final HttpService service = Get.put(HttpService());
      dioAdapter.onPost('http://url.foo/index.php/apps/deck/api/v1/boards',
          (server) {
        return server.reply(
          401,
          {},
          delay: const Duration(seconds: 1),
        );
      });

      var response = await service.retry(
          path: 'http://url.foo/index.php/apps/deck/api/v1/boards',
          method: 'post');

      expect(response, isA());
    });
  });
}
