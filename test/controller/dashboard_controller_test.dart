import 'package:deck_ng/controller/dashboard_controller.dart';
import 'package:deck_ng/model/models.dart';
import 'package:deck_ng/service/services.dart';
import 'package:deck_ng/service/tracking_service.dart';
import 'package:get/get.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'dashboard_controller_test.mocks.dart';

@GenerateMocks([AuthService, BoardService, StackService, TrackingService])
void main() {
  TrackingService trackingServiceMock = MockTrackingService();
  setUp(() {
    Get.testMode = true;
    Get.put<TrackingService>(trackingServiceMock);
    Get.put<AuthService>(MockAuthService());
  });

  tearDown(() {
    Get.reset();
  });

  test(
      '''Test the state of the reactive variable "boardDataCount" across all of its lifecycles''',
      () async {
    BoardService boardRepositoryImplMock =
        Get.put<BoardService>(MockBoardService());
    StackService stackServiceMock = Get.put<StackService>(MockStackService());
    final controller = Get.put(DashboardController());
    expect(controller.boardCount.value, 0);

    /// If you are using it, you can test everything,
    /// including the state of the application after each lifecycle.
    Get.put(controller); // onInit was called
    expect(controller.boardCount.value, 0);

    var resp = [Board(title: 'foo', id: 1)];
    when(boardRepositoryImplMock.getAllBoards()).thenAnswer((_) async => resp);
    when(stackServiceMock.getAll(1))
        .thenAnswer((_) async => [Stack(title: 'title', boardId: 1, id: 1)]);
    when(trackingServiceMock.modifyMetaData()).thenAnswer((_) async {});
    controller.onReady();

    /// Test your functions
    await controller.fetchData();
    expect(controller.boardCount.value, 1);

    /// onClose was called
    Get.delete<DashboardController>();

    expect(controller.boardCount.value, 1);
  });

  test('fetchData updates the state correctly', () async {
    // Mock services
    BoardService boardServiceMock = Get.put<BoardService>(MockBoardService());
    StackService stackServiceMock = Get.put<StackService>(MockStackService());

    // Create the controller
    final controller = Get.put(DashboardController());

    // Set up mock responses
    var boards = [Board(title: 'foo', id: 1)];
    var stacks = [
      Stack(
          title: 'title',
          boardId: 1,
          id: 1,
          cards: [Card(title: 'card1', stackId: 1)])
    ];
    when(boardServiceMock.getAllBoards()).thenAnswer((_) async => boards);
    when(stackServiceMock.getAll(1)).thenAnswer((_) async => stacks);

    // Call fetchData
    await controller.fetchData();

    // Verify state changes
    expect(controller.boardCount.value, 1);
    expect(controller.stackCount.value, 1);
    expect(controller.taskCount.value, 1);
    expect(controller.isLoading.value, false);
    expect(controller.boards.length, 1);
    expect(controller.dashboardData.length, 3);
    expect(controller.dashboardData[0].count, 1); // # Boards
    expect(controller.dashboardData[1].count, 1); // # stack
    expect(controller.dashboardData[2].count, 1); // # tasks
  });
}
