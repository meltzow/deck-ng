import 'package:deck_ng/model/board.dart';
import 'package:deck_ng/service/Ihttp_service.dart';
import 'package:deck_ng/service/board_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'board_service_test.mocks.dart';

@GenerateMocks([IHttpService])
void main() {
  group('boardGroup', () {
    setUpAll(() async {
      TestWidgetsFlutterBinding.ensureInitialized();
    });

    test('returns all boards if the http call completes successfully',
        () async {
      final httpServiceMock = Get.put<IHttpService>(MockIHttpService());
      final BoardRepositoryImpl boardRepo =
          Get.put<BoardRepositoryImpl>(BoardRepositoryImpl());

      var resp = [Board(title: 'foo', id: 1)].map((e) => e.toJson()).toList();
      when(httpServiceMock
              .getListResponse('/index.php/apps/deck/api/v1/boards'))
          .thenAnswer((_) async => resp);

      expect(await boardRepo.getAllBoards(), isA<List<Board>>());
    });

    test('throws an exception if the http call completes with an error', () {
      final httpServiceMock = Get.put<IHttpService>(MockIHttpService());
      final BoardRepositoryImpl boardRepo =
          Get.put<BoardRepositoryImpl>(BoardRepositoryImpl());

      // Use Mockito to return an unsuccessful response when it calls the provided http.Client.
      when(httpServiceMock
              .getListResponse('/index.php/apps/deck/api/v1/boards'))
          .thenAnswer((_) async => throw Exception('Not Found'));

      expect(boardRepo.getAllBoards(), throwsException);
    });

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
