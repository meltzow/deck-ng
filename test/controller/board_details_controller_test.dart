import 'package:deck_ng/controller/board_details_controller.dart';
import 'package:deck_ng/controller/board_overview_controller.dart';
import 'package:deck_ng/model/board.dart';
import 'package:deck_ng/model/card.dart';
import 'package:deck_ng/model/stack.dart';
import 'package:deck_ng/service/Iboard_service.dart';
import 'package:deck_ng/service/Istack_service.dart';
import 'package:get/get.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'board_details_controller_test.mocks.dart';

@GenerateMocks([IBoardService, IStackService])
void main() {
  test('select first available stack',
      () async {
    IBoardService boardRepositoryImplMock =
        Get.put<IBoardService>(MockIBoardService());
    var stackServiceMock = Get.put<IStackService>(MockIStackService());
    final controller = Get.put(BoardDetailsController());


    controller.boardId = 1;
    expect(controller.boardId, 1);
    expect(controller.stackData, []);

    var resp = Board(title: 'foo', id: 1);
    var stack = Stack(title: "offen", cards: [Card(title: "issue1", id: 1)], id: 1);
    var respStack = [stack];
    when(boardRepositoryImplMock.getBoard(1)).thenAnswer((_) async => resp);
    when(stackServiceMock.getAll(1)).thenAnswer((_) async => respStack);

    expect(controller.selectedStackId, 0);

    await controller.refreshData();

    expect(controller.selectedStackData, stack);
    expect(controller.selectedStackId, 1);

  });

}
