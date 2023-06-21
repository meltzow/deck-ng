import 'package:deck_ng/controller/board_overview_controller.dart';
import 'package:deck_ng/model/board.dart';
import 'package:deck_ng/service/Iauth_service.dart';
import 'package:deck_ng/service/Iboard_service.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'board_overview_controller_test.mocks.dart';

@GenerateMocks([IAuthService, IBoardService])
void main() {
  test(
      '''Test the state of the reactive variable "boardDataCount" across all of its lifecycles''',
      () async {
    IAuthService authServiceMock = Get.put<IAuthService>(MockIAuthService());
    Get.put<Dio>(Dio());
    IBoardService boardRepositoryImplMock =
        Get.put<IBoardService>(MockIBoardService());
    final controller = Get.put(BoardOverviewController());
    expect(controller.boardDataCount, 0);

    /// If you are using it, you can test everything,
    /// including the state of the application after each lifecycle.
    Get.put(controller); // onInit was called
    expect(controller.boardDataCount, 0);

    var resp = [Board(title: 'foo', id: 1)];
    when(boardRepositoryImplMock.getAllBoards()).thenAnswer((_) async => resp);
    controller.onReady();

    /// Test your functions
    await controller.refreshData();
    expect(controller.boardDataCount, 1);

    /// onClose was called
    Get.delete<BoardOverviewController>();

    expect(controller.boardDataCount, 1);
  });
}
