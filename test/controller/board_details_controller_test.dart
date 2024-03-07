import 'package:deck_ng/controller/board_details_controller.dart';
import 'package:deck_ng/model/models.dart' as NC;
import 'package:deck_ng/service/Iboard_service.dart';
import 'package:deck_ng/service/Icard_service.dart';
import 'package:deck_ng/service/Inotification_service.dart';
import 'package:deck_ng/service/Istack_service.dart';
import 'package:get/get.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';


import 'board_details_controller_test.mocks.dart';

@GenerateMocks([IBoardService, IStackService, ICardService, INotificationService])
void main() {
  test('reorder must save old card with new order', () async {
    IBoardService boardRepositoryImplMock =
        Get.put<IBoardService>(MockIBoardService());
    var stackServiceMock = Get.put<IStackService>(MockIStackService());
    var cardServiceMock = Get.put<ICardService>(MockICardService());
    var notifyServiceMock = Get.put<INotificationService>(MockINotificationService());

    final controller = Get.put(BoardDetailsController());

    controller.boardId = 1;
    expect(controller.boardId, 1);
    expect(controller.stackData, []);

    var board = NC.Board(title: 'foo', id: 1);
    var stack =
        NC.Stack(title: "offen", id: 1, boardId: board.id);
    var card1 = NC.Card(title: "issue1", id: 1, stackId: 1);
    var card2 = NC.Card(title: "issue2", id: 2, stackId: 1);
    stack.cards = [card1, card2];
    var respStack = [stack];


    when(cardServiceMock.updateCard(board.id, stack.id, card1.id, card1)).thenAnswer((_) async => card1);
    when(notifyServiceMock.successMsg('Card', 'Card Updated Successfully')).thenReturn(null);
    controller.stackData = respStack;

    controller.reorder(0, 0, 1);

   // expect(controller.selectedStackData, stack);
   // expect(controller.selectedStackId, 1);
  });


  tearDown(() {
    Get.delete<BoardDetailsController>();
  });
}
