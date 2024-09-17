import 'package:deck_ng/model/board.dart';
import 'package:deck_ng/service/impl/board_service_impl.dart';
import 'package:deck_ng/service/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'board_service_test.mocks.dart';

@GenerateMocks([HttpService])
void main() {
  group('boardGroup', () {
    setUpAll(() async {
      TestWidgetsFlutterBinding.ensureInitialized();
    });

    test('returns all boards if the http call completes successfully',
        () async {
      final httpServiceMock = Get.put<HttpService>(MockHttpService());
      final BoardService boardRepo = Get.put<BoardService>(BoardServiceImpl());

      var resp = [Board(title: 'foo', id: 1)].map((e) => e.toJson()).toList();
      when(httpServiceMock
              .getListResponse('/index.php/apps/deck/api/v1/boards'))
          .thenAnswer((_) async => resp);

      expect(await boardRepo.getAllBoards(), isA<List<Board>>());
    });

    test('throws an exception if the http call completes with an error', () {
      final httpServiceMock = Get.put<HttpService>(MockHttpService());
      final BoardService boardRepo = Get.put<BoardService>(BoardServiceImpl());

      // Use Mockito to return an unsuccessful response when it calls the provided http.Client.
      when(httpServiceMock
              .getListResponse('/index.php/apps/deck/api/v1/boards'))
          .thenAnswer((_) async => throw Exception('Not Found'));

      expect(boardRepo.getAllBoards(), throwsException);
    });

    test('throws an exception if the http response contains invalid JSON',
        () async {
      final httpServiceMock = Get.put<HttpService>(MockHttpService());
      final BoardService boardRepo = Get.put<BoardService>(BoardServiceImpl());

      // Simulate an invalid JSON response by throwing a FormatException
      when(httpServiceMock
              .getListResponse('/index.php/apps/deck/api/v1/boards'))
          .thenThrow(const FormatException('Invalid JSON'));

      expect(boardRepo.getAllBoards(), throwsA(isA<FormatException>()));
    });
  });
}
