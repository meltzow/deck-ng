import 'dart:convert';

import 'package:deck_ng/model/account.dart';
import 'package:deck_ng/model/board.dart';
import 'package:deck_ng/service/Iauth_service.dart';
import 'package:deck_ng/service/http_service.dart';
import 'package:dio/dio.dart' as dio;
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'http_service_test.mocks.dart';

@GenerateMocks([IAuthService])
@GenerateNiceMocks([MockSpec<dio.Dio>()])
void main() {
  late dio.Dio dioClient;
  late DioAdapter dioAdapter;

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

    test('returns all boards if the http call completes successfully',
        () async {
      final authServiceMock = Get.put<IAuthService>(MockIAuthService());
      final dio.Dio getConnectMock = Get.put<dio.Dio>(MockDio());
      final HttpService service = Get.put(HttpService());

      dioAdapter.onGet(
          'http://192.168.178.59:8080/index.php/apps/deck/api/v1/boards',
          (server) => server.reply(
                200,
                jsonEncode(Board(title: 'foo', id: 1).toJson()),
                // Adds one-sec delay to reply method.
                // Basically, I'd wait for one second before returning reply data.
                // See -> issue:[106] & pr:[126]
                delay: const Duration(seconds: 1),
              ));

      when(authServiceMock.getAccount()).thenAnswer((realInvocation) => Future(
          () => Account(
              username: 'username',
              authData: 'authData',
              url: 'url',
              isAuthenticated: true)));

      expect(await service.getResponse('/index.php/apps/deck/api/v1/boards'),
          isA<Map<String, dynamic>>());
    });

    // test('throws an exception if the http call completes with an error', () {
    //   final httpServiceMock = Get.put<IHttpService>(MockIHttpService());
    //   final BoardRepositoryImpl boardRepo =
    //       Get.put<BoardRepositoryImpl>(BoardRepositoryImpl());
    //
    //   // Use Mockito to return an unsuccessful response when it calls the
    //   // provided http.Client.
    //   when(httpServiceMock.getResponse('/index.php/apps/deck/api/v1/boards'))
    //       .thenAnswer((_) async => Exception('Not Found'));
    //
    //   expect(boardRepo.getAllBoards(), throwsException);
    // });

    // test('returns a boards if the http call completes successfully', () async {
    //   getIt.unregister<http.Client>();
    //   getIt.registerSingleton<http.Client>(MockClient());
    //   final client = getIt<http.Client>();
    //   final BoardRepository boardRepo = getIt<BoardRepository>();
    //
    //   // Use Mockito to return a successful response when it calls the
    //   // provided http.Client.
    //   when(client.get(
    //           Uri.parse(
    //               "http://192.168.178.59:8080/index.php/apps/deck/api/v1/boards/1"),
    //           headers: anyNamed('headers')))
    //       .thenAnswer((_) async =>
    //           http.Response('{"title": "foobar mock", "id": 33}', 200));
    //
    //   expect(await boardRepo.getBoard(1), isA<Board>());
    // });
  });
}
