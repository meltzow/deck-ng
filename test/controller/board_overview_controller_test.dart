import 'package:deck_ng/controller/dashboard_controller.dart';
import 'package:deck_ng/model/board.dart';
import 'package:deck_ng/service/Iauth_service.dart';
import 'package:deck_ng/service/Iboard_service.dart';
import 'package:get/get.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'board_details_controller_test.mocks.dart';

@GenerateMocks([IAuthService, IBoardService])
void main() {
  test(
      '''Test the state of the reactive variable "boardDataCount" across all of its lifecycles''',
      () async {
    IBoardService boardRepositoryImplMock =
        Get.put<IBoardService>(MockIBoardService());
    final controller = Get.put(DashboardController());
    expect(controller.boardData.length, 0);

    /// If you are using it, you can test everything,
    /// including the state of the application after each lifecycle.
    Get.put(controller); // onInit was called
    expect(controller.boardData.length, 0);

    var resp = [Board(title: 'foo', id: 1)];
    when(boardRepositoryImplMock.getAllBoards()).thenAnswer((_) async => resp);
    controller.onReady();

    /// Test your functions
    await controller.refreshData();
    expect(controller.boardData.length, 1);

    /// onClose was called
    Get.delete<DashboardController>();

    expect(controller.boardData.length, 1);
  });
}
