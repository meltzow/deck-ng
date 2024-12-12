// Mocks generated by Mockito 5.4.4 from annotations
// in deck_ng/test/screen/kanban_board_screen_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i7;
import 'dart:ui' as _i9;

import 'package:appflowy_board/appflowy_board.dart' as _i2;
import 'package:deck_ng/board/kanban_board_controller.dart' as _i6;
import 'package:deck_ng/model/models.dart' as _i4;
import 'package:deck_ng/service/services.dart' as _i5;
import 'package:get/get.dart' as _i3;
import 'package:get/get_state_manager/src/simple/list_notifier.dart' as _i8;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeAppFlowyBoardController_0 extends _i1.SmartFake
    implements _i2.AppFlowyBoardController {
  _FakeAppFlowyBoardController_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeRxBool_1 extends _i1.SmartFake implements _i3.RxBool {
  _FakeRxBool_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeInternalFinalCallback_2<T> extends _i1.SmartFake
    implements _i3.InternalFinalCallback<T> {
  _FakeInternalFinalCallback_2(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeBoard_3 extends _i1.SmartFake implements _i4.Board {
  _FakeBoard_3(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeCard_4 extends _i1.SmartFake implements _i4.Card {
  _FakeCard_4(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeAssignment_5 extends _i1.SmartFake implements _i4.Assignment {
  _FakeAssignment_5(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeAttachment_6 extends _i1.SmartFake implements _i4.Attachment {
  _FakeAttachment_6(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeCapabilities_7 extends _i1.SmartFake implements _i5.Capabilities {
  _FakeCapabilities_7(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [KanbanBoardController].
///
/// See the documentation for Mockito's code generation for more information.
class MockKanbanBoardController extends _i1.Mock
    implements _i6.KanbanBoardController {
  MockKanbanBoardController() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.AppFlowyBoardController get boardController => (super.noSuchMethod(
        Invocation.getter(#boardController),
        returnValue: _FakeAppFlowyBoardController_0(
          this,
          Invocation.getter(#boardController),
        ),
      ) as _i2.AppFlowyBoardController);

  @override
  set boardController(_i2.AppFlowyBoardController? _boardController) =>
      super.noSuchMethod(
        Invocation.setter(
          #boardController,
          _boardController,
        ),
        returnValueForMissingStub: null,
      );

  @override
  int get boardId => (super.noSuchMethod(
        Invocation.getter(#boardId),
        returnValue: 0,
      ) as int);

  @override
  set boardId(int? _boardId) => super.noSuchMethod(
        Invocation.setter(
          #boardId,
          _boardId,
        ),
        returnValueForMissingStub: null,
      );

  @override
  _i3.RxBool get isLoading => (super.noSuchMethod(
        Invocation.getter(#isLoading),
        returnValue: _FakeRxBool_1(
          this,
          Invocation.getter(#isLoading),
        ),
      ) as _i3.RxBool);

  @override
  set stackData(List<_i4.Stack>? stacks) => super.noSuchMethod(
        Invocation.setter(
          #stackData,
          stacks,
        ),
        returnValueForMissingStub: null,
      );

  @override
  List<_i4.Stack> get stackData => (super.noSuchMethod(
        Invocation.getter(#stackData),
        returnValue: <_i4.Stack>[],
      ) as List<_i4.Stack>);

  @override
  _i2.AppFlowyBoardController get boardCtl => (super.noSuchMethod(
        Invocation.getter(#boardCtl),
        returnValue: _FakeAppFlowyBoardController_0(
          this,
          Invocation.getter(#boardCtl),
        ),
      ) as _i2.AppFlowyBoardController);

  @override
  _i3.InternalFinalCallback<void> get onStart => (super.noSuchMethod(
        Invocation.getter(#onStart),
        returnValue: _FakeInternalFinalCallback_2<void>(
          this,
          Invocation.getter(#onStart),
        ),
      ) as _i3.InternalFinalCallback<void>);

  @override
  _i3.InternalFinalCallback<void> get onDelete => (super.noSuchMethod(
        Invocation.getter(#onDelete),
        returnValue: _FakeInternalFinalCallback_2<void>(
          this,
          Invocation.getter(#onDelete),
        ),
      ) as _i3.InternalFinalCallback<void>);

  @override
  bool get initialized => (super.noSuchMethod(
        Invocation.getter(#initialized),
        returnValue: false,
      ) as bool);

  @override
  bool get isClosed => (super.noSuchMethod(
        Invocation.getter(#isClosed),
        returnValue: false,
      ) as bool);

  @override
  bool get hasListeners => (super.noSuchMethod(
        Invocation.getter(#hasListeners),
        returnValue: false,
      ) as bool);

  @override
  int get listeners => (super.noSuchMethod(
        Invocation.getter(#listeners),
        returnValue: 0,
      ) as int);

  @override
  void onInit() => super.noSuchMethod(
        Invocation.method(
          #onInit,
          [],
        ),
        returnValueForMissingStub: null,
      );

  @override
  _i7.Future<void> refreshData() => (super.noSuchMethod(
        Invocation.method(
          #refreshData,
          [],
        ),
        returnValue: _i7.Future<void>.value(),
        returnValueForMissingStub: _i7.Future<void>.value(),
      ) as _i7.Future<void>);

  @override
  void reorder(
    int? selectedStackIndex,
    int? oldIndex,
    int? newIndex,
  ) =>
      super.noSuchMethod(
        Invocation.method(
          #reorder,
          [
            selectedStackIndex,
            oldIndex,
            newIndex,
          ],
        ),
        returnValueForMissingStub: null,
      );

  @override
  dynamic cardReorderHandler(
    int? oldCardIndex,
    int? newCardIndex,
    int? oldListId,
    int? newListId,
  ) =>
      super.noSuchMethod(Invocation.method(
        #cardReorderHandler,
        [
          oldCardIndex,
          newCardIndex,
          oldListId,
          newListId,
        ],
      ));

  @override
  void cardSuccessMsg() => super.noSuchMethod(
        Invocation.method(
          #cardSuccessMsg,
          [],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void createCard(
    int? stackId,
    String? title,
  ) =>
      super.noSuchMethod(
        Invocation.method(
          #createCard,
          [
            stackId,
            title,
          ],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void update([
    List<Object>? ids,
    bool? condition = true,
  ]) =>
      super.noSuchMethod(
        Invocation.method(
          #update,
          [
            ids,
            condition,
          ],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void onReady() => super.noSuchMethod(
        Invocation.method(
          #onReady,
          [],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void onClose() => super.noSuchMethod(
        Invocation.method(
          #onClose,
          [],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void $configureLifeCycle() => super.noSuchMethod(
        Invocation.method(
          #$configureLifeCycle,
          [],
        ),
        returnValueForMissingStub: null,
      );

  @override
  _i8.Disposer addListener(_i8.GetStateUpdate? listener) => (super.noSuchMethod(
        Invocation.method(
          #addListener,
          [listener],
        ),
        returnValue: () {},
      ) as _i8.Disposer);

  @override
  void removeListener(_i9.VoidCallback? listener) => super.noSuchMethod(
        Invocation.method(
          #removeListener,
          [listener],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void refresh() => super.noSuchMethod(
        Invocation.method(
          #refresh,
          [],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void refreshGroup(Object? id) => super.noSuchMethod(
        Invocation.method(
          #refreshGroup,
          [id],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void notifyChildrens() => super.noSuchMethod(
        Invocation.method(
          #notifyChildrens,
          [],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void removeListenerId(
    Object? id,
    _i9.VoidCallback? listener,
  ) =>
      super.noSuchMethod(
        Invocation.method(
          #removeListenerId,
          [
            id,
            listener,
          ],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void dispose() => super.noSuchMethod(
        Invocation.method(
          #dispose,
          [],
        ),
        returnValueForMissingStub: null,
      );

  @override
  _i8.Disposer addListenerId(
    Object? key,
    _i8.GetStateUpdate? listener,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #addListenerId,
          [
            key,
            listener,
          ],
        ),
        returnValue: () {},
      ) as _i8.Disposer);

  @override
  void disposeId(Object? id) => super.noSuchMethod(
        Invocation.method(
          #disposeId,
          [id],
        ),
        returnValueForMissingStub: null,
      );
}

/// A class which mocks [BoardService].
///
/// See the documentation for Mockito's code generation for more information.
class MockBoardService extends _i1.Mock implements _i5.BoardService {
  MockBoardService() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i7.Future<List<_i4.Board>> getAllBoards() => (super.noSuchMethod(
        Invocation.method(
          #getAllBoards,
          [],
        ),
        returnValue: _i7.Future<List<_i4.Board>>.value(<_i4.Board>[]),
      ) as _i7.Future<List<_i4.Board>>);

  @override
  _i7.Future<_i4.Board> getBoard(int? boardId) => (super.noSuchMethod(
        Invocation.method(
          #getBoard,
          [boardId],
        ),
        returnValue: _i7.Future<_i4.Board>.value(_FakeBoard_3(
          this,
          Invocation.method(
            #getBoard,
            [boardId],
          ),
        )),
      ) as _i7.Future<_i4.Board>);
}

/// A class which mocks [NotificationService].
///
/// See the documentation for Mockito's code generation for more information.
class MockNotificationService extends _i1.Mock
    implements _i5.NotificationService {
  MockNotificationService() {
    _i1.throwOnMissingStub(this);
  }

  @override
  dynamic successMsg(
    String? title,
    String? message,
  ) =>
      super.noSuchMethod(Invocation.method(
        #successMsg,
        [
          title,
          message,
        ],
      ));

  @override
  dynamic errorMsg(
    String? s,
    String? t,
  ) =>
      super.noSuchMethod(Invocation.method(
        #errorMsg,
        [
          s,
          t,
        ],
      ));
}

/// A class which mocks [StackService].
///
/// See the documentation for Mockito's code generation for more information.
class MockStackService extends _i1.Mock implements _i5.StackService {
  MockStackService() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i7.Future<List<_i4.Stack>?> getAll(int? boardId) => (super.noSuchMethod(
        Invocation.method(
          #getAll,
          [boardId],
        ),
        returnValue: _i7.Future<List<_i4.Stack>?>.value(),
      ) as _i7.Future<List<_i4.Stack>?>);
}

/// A class which mocks [CardService].
///
/// See the documentation for Mockito's code generation for more information.
class MockCardService extends _i1.Mock implements _i5.CardService {
  MockCardService() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i7.Future<_i4.Card> createCard(
    int? boardId,
    int? stackId,
    String? title,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #createCard,
          [
            boardId,
            stackId,
            title,
          ],
        ),
        returnValue: _i7.Future<_i4.Card>.value(_FakeCard_4(
          this,
          Invocation.method(
            #createCard,
            [
              boardId,
              stackId,
              title,
            ],
          ),
        )),
      ) as _i7.Future<_i4.Card>);

  @override
  _i7.Future<_i4.Card> updateCard(
    int? boardId,
    int? stackId,
    int? cardId,
    _i4.Card? card,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #updateCard,
          [
            boardId,
            stackId,
            cardId,
            card,
          ],
        ),
        returnValue: _i7.Future<_i4.Card>.value(_FakeCard_4(
          this,
          Invocation.method(
            #updateCard,
            [
              boardId,
              stackId,
              cardId,
              card,
            ],
          ),
        )),
      ) as _i7.Future<_i4.Card>);

  @override
  _i7.Future<_i4.Card> getCard(
    int? boardId,
    int? stackId,
    int? cardId,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #getCard,
          [
            boardId,
            stackId,
            cardId,
          ],
        ),
        returnValue: _i7.Future<_i4.Card>.value(_FakeCard_4(
          this,
          Invocation.method(
            #getCard,
            [
              boardId,
              stackId,
              cardId,
            ],
          ),
        )),
      ) as _i7.Future<_i4.Card>);

  @override
  _i7.Future<void> deleteCard(
    int? boardId,
    int? stackId,
    int? cardId,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #deleteCard,
          [
            boardId,
            stackId,
            cardId,
          ],
        ),
        returnValue: _i7.Future<void>.value(),
        returnValueForMissingStub: _i7.Future<void>.value(),
      ) as _i7.Future<void>);

  @override
  _i7.Future<_i4.Card> reorderCard(
    int? boardId,
    int? oldStackId,
    int? cardId,
    _i4.Card? card,
    int? newOrder,
    int? newStackId,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #reorderCard,
          [
            boardId,
            oldStackId,
            cardId,
            card,
            newOrder,
            newStackId,
          ],
        ),
        returnValue: _i7.Future<_i4.Card>.value(_FakeCard_4(
          this,
          Invocation.method(
            #reorderCard,
            [
              boardId,
              oldStackId,
              cardId,
              card,
              newOrder,
              newStackId,
            ],
          ),
        )),
      ) as _i7.Future<_i4.Card>);

  @override
  _i7.Future<void> assignLabel2Card(
    int? boardId,
    int? stackId,
    int? cardId,
    int? labelId,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #assignLabel2Card,
          [
            boardId,
            stackId,
            cardId,
            labelId,
          ],
        ),
        returnValue: _i7.Future<void>.value(),
        returnValueForMissingStub: _i7.Future<void>.value(),
      ) as _i7.Future<void>);

  @override
  _i7.Future<void> removeLabel2Card(
    int? boardId,
    int? stackId,
    int? cardId,
    int? labelId,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #removeLabel2Card,
          [
            boardId,
            stackId,
            cardId,
            labelId,
          ],
        ),
        returnValue: _i7.Future<void>.value(),
        returnValueForMissingStub: _i7.Future<void>.value(),
      ) as _i7.Future<void>);

  @override
  _i7.Future<_i4.Assignment> assignUser2Card(
    int? boardId,
    int? stackId,
    int? cardId,
    String? userId,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #assignUser2Card,
          [
            boardId,
            stackId,
            cardId,
            userId,
          ],
        ),
        returnValue: _i7.Future<_i4.Assignment>.value(_FakeAssignment_5(
          this,
          Invocation.method(
            #assignUser2Card,
            [
              boardId,
              stackId,
              cardId,
              userId,
            ],
          ),
        )),
      ) as _i7.Future<_i4.Assignment>);

  @override
  _i7.Future<_i4.Assignment> unassignUser2Card(
    int? boardId,
    int? stackId,
    int? cardId,
    String? userId,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #unassignUser2Card,
          [
            boardId,
            stackId,
            cardId,
            userId,
          ],
        ),
        returnValue: _i7.Future<_i4.Assignment>.value(_FakeAssignment_5(
          this,
          Invocation.method(
            #unassignUser2Card,
            [
              boardId,
              stackId,
              cardId,
              userId,
            ],
          ),
        )),
      ) as _i7.Future<_i4.Assignment>);

  @override
  _i7.Future<_i4.Attachment> addAttachmentToCard(
    int? boardId,
    int? stackId,
    int? cardId,
    _i4.Attachment? attachment,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #addAttachmentToCard,
          [
            boardId,
            stackId,
            cardId,
            attachment,
          ],
        ),
        returnValue: _i7.Future<_i4.Attachment>.value(_FakeAttachment_6(
          this,
          Invocation.method(
            #addAttachmentToCard,
            [
              boardId,
              stackId,
              cardId,
              attachment,
            ],
          ),
        )),
      ) as _i7.Future<_i4.Attachment>);
}

/// A class which mocks [AuthService].
///
/// See the documentation for Mockito's code generation for more information.
class MockAuthService extends _i1.Mock implements _i5.AuthService {
  MockAuthService() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i7.Future<bool> login(
    String? serverUrl,
    String? username,
    String? password,
    String? version,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #login,
          [
            serverUrl,
            username,
            password,
            version,
          ],
        ),
        returnValue: _i7.Future<bool>.value(false),
      ) as _i7.Future<bool>);

  @override
  _i7.Future<_i5.Capabilities> checkServer(String? serverUrl) =>
      (super.noSuchMethod(
        Invocation.method(
          #checkServer,
          [serverUrl],
        ),
        returnValue: _i7.Future<_i5.Capabilities>.value(_FakeCapabilities_7(
          this,
          Invocation.method(
            #checkServer,
            [serverUrl],
          ),
        )),
      ) as _i7.Future<_i5.Capabilities>);

  @override
  bool isAuth() => (super.noSuchMethod(
        Invocation.method(
          #isAuth,
          [],
        ),
        returnValue: false,
      ) as bool);
}

/// A class which mocks [StorageService].
///
/// See the documentation for Mockito's code generation for more information.
class MockStorageService extends _i1.Mock implements _i5.StorageService {
  MockStorageService() {
    _i1.throwOnMissingStub(this);
  }

  @override
  bool hasAccount() => (super.noSuchMethod(
        Invocation.method(
          #hasAccount,
          [],
        ),
        returnValue: false,
      ) as bool);

  @override
  bool hasSettings() => (super.noSuchMethod(
        Invocation.method(
          #hasSettings,
          [],
        ),
        returnValue: false,
      ) as bool);

  @override
  _i7.Future<void> saveSetting(_i4.Setting? setting) => (super.noSuchMethod(
        Invocation.method(
          #saveSetting,
          [setting],
        ),
        returnValue: _i7.Future<void>.value(),
        returnValueForMissingStub: _i7.Future<void>.value(),
      ) as _i7.Future<void>);
}
