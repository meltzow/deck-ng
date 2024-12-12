import 'package:deck_ng/app_routes.dart';
import 'package:deck_ng/card/card_details_controller.dart';
import 'package:deck_ng/card/card_details_screen.dart';
import 'package:deck_ng/model/card.dart' as nc;
import 'package:deck_ng/model/models.dart';
import 'package:deck_ng/model/stack.dart' as ncstack;
import 'package:deck_ng/my_app.dart';
import 'package:deck_ng/service/services.dart';
import 'package:deck_ng/service/tracking_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'card_details_screen_test.mocks.dart';
import 'test_helpers.dart';

class MockCardDetailsController extends CardDetailsController with Mock {
  var card = Rxn<nc.Card?>(null);
  var board = Rxn<Board?>(null);
  var users = <User>[].obs;
  var attachments = <Attachment>[].obs;
  var labels = <Label>[].obs;
  var selectedLabels = <Label>[].obs;
}

@GenerateMocks([
  StorageService,
  AuthService,
  BoardService,
  StackService,
  CardService,
  NotificationService,
  TrackingService
])
void main() {
  late CardDetailsController cardDetailsControllerMock;
  late StorageService storageServiceMock;
  late AuthService authServiceMock;
  late BoardService boardServiceMock;
  late StackService stackServiceMock;
  late CardService cardServiceMock;
  late NotificationService notificationServiceMock;

  setUp(() {
    Get.testMode = true;
    stackServiceMock = Get.put<StackService>(MockStackService());
    authServiceMock = Get.put<AuthService>(MockAuthService());
    storageServiceMock = Get.put<StorageService>(MockStorageService());
    cardServiceMock = Get.put<CardService>(MockCardService());
    boardServiceMock = Get.put<BoardService>(MockBoardService());
    notificationServiceMock =
        Get.put<NotificationService>(MockNotificationService());
    Get.put<TrackingService>(MockTrackingService());

    Get.parameters = <String, String>{
      'boardId': '1',
      'stackId': '1',
      'cardId': '1'
    };
  });

  tearDown(() {
    Get.reset();
  });

  testWidgets('show a simple card', (tester) async {
    setupMockAccount(storageServiceMock, authServiceMock);

    when(cardServiceMock.getCard(1, 1, 1)).thenAnswer((_) =>
        Future.value(nc.Card(title: 'seeding carrots', id: 1, stackId: 1)));

    when(boardServiceMock.getBoard(1)).thenAnswer(
        (realInvocation) => (Future.value(Board(title: 'garden', id: 1))));

    when(stackServiceMock.getAll(1)).thenAnswer((_) => Future.value(
        [ncstack.Stack(title: 'todo', boardId: 1, id: 1, cards: [])]));

    cardDetailsControllerMock =
        Get.put<CardDetailsController>(MockCardDetailsController());
    await tester.pumpWidget(GetMaterialApp(home: CardDetailsScreen()));

    await tester.pumpWidget(const MyApp(debugShowCheckedModeBanner: false));
    Get.toNamed(AppRoutes.cardDetails);
    //await Future.delayed(const Duration(seconds: 1), () {});
    await tester.pumpAndSettle();

    // Verify the counter starts at 0.
    expect(find.text('Card Details'), findsOneWidget);
    expect(find.text('Save'), findsOneWidget);

    // // Finds the floating action button to tap on.
    // final fab = find.byKey(const Key('increment'));
    //
    // // Emulate a tap on the floating action button.
    // await tester.tap(fab);
    //
    // // Trigger a frame.
    // await tester.pumpAndSettle();
    //
    // // Verify the counter increments by 1.
    // expect(find.text('0'), findsNothing);
    // expect(find.text('1'), findsOneWidget);
  });
}
