import 'package:deck_ng/controller/dashboard_controller.dart';
import 'package:deck_ng/model/models.dart';
import 'package:deck_ng/service/services.dart';
import 'package:get/get.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'dashboard_controller_test.mocks.dart';

@GenerateMocks([AuthService, BoardService, StackService])
void main() {
  test(
      '''Test the state of the reactive variable "boardDataCount" across all of its lifecycles''',
      () async {
    BoardService boardRepositoryImplMock =
        Get.put<BoardService>(MockBoardService());
    StackService stackServiceMock = Get.put<StackService>(MockStackService());
    final controller = Get.put(DashboardController());
    expect(controller.boardCount, 0);

    /// If you are using it, you can test everything,
    /// including the state of the application after each lifecycle.
    Get.put(controller); // onInit was called
    expect(controller.boardCount, 0);

    var resp = [Board(title: 'foo', id: 1)];
    when(boardRepositoryImplMock.getAllBoards()).thenAnswer((_) async => resp);
    when(stackServiceMock.getAll(1))
        .thenAnswer((_) async => [Stack(title: 'title', boardId: 1, id: 1)]);
    controller.onReady();

    /// Test your functions
    await controller.fetchData();
    expect(controller.boardCount, 1);

    /// onClose was called
    Get.delete<DashboardController>();

    expect(controller.boardCount, 1);
  });
}
