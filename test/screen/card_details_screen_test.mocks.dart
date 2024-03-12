// Mocks generated by Mockito 5.4.4 from annotations
// in deck_ng/test/screen/card_details_screen_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i6;

import 'package:deck_ng/model/board.dart' as _i2;
import 'package:deck_ng/model/models.dart' as _i3;
import 'package:deck_ng/service/Iauth_service.dart' as _i4;
import 'package:deck_ng/service/Iboard_service.dart' as _i5;
import 'package:deck_ng/service/Icard_service.dart' as _i7;
import 'package:deck_ng/service/Istack_service.dart' as _i9;
import 'package:deck_ng/service/Istorage_service.dart' as _i8;
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

class _FakeBoard_0 extends _i1.SmartFake implements _i2.Board {
  _FakeBoard_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeCard_1 extends _i1.SmartFake implements _i3.Card {
  _FakeCard_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeAssignment_2 extends _i1.SmartFake implements _i3.Assignment {
  _FakeAssignment_2(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeCapabilities_3 extends _i1.SmartFake implements _i4.Capabilities {
  _FakeCapabilities_3(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [IBoardService].
///
/// See the documentation for Mockito's code generation for more information.
class MockIBoardService extends _i1.Mock implements _i5.IBoardService {
  MockIBoardService() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i6.Future<List<_i2.Board>> getAllBoards() => (super.noSuchMethod(
        Invocation.method(
          #getAllBoards,
          [],
        ),
        returnValue: _i6.Future<List<_i2.Board>>.value(<_i2.Board>[]),
      ) as _i6.Future<List<_i2.Board>>);

  @override
  _i6.Future<_i2.Board> getBoard(int? boardId) => (super.noSuchMethod(
        Invocation.method(
          #getBoard,
          [boardId],
        ),
        returnValue: _i6.Future<_i2.Board>.value(_FakeBoard_0(
          this,
          Invocation.method(
            #getBoard,
            [boardId],
          ),
        )),
      ) as _i6.Future<_i2.Board>);
}

/// A class which mocks [ICardService].
///
/// See the documentation for Mockito's code generation for more information.
class MockICardService extends _i1.Mock implements _i7.ICardService {
  MockICardService() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i6.Future<_i3.Card> createCard(
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
        returnValue: _i6.Future<_i3.Card>.value(_FakeCard_1(
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
      ) as _i6.Future<_i3.Card>);

  @override
  _i6.Future<_i3.Card> updateCard(
    int? boardId,
    int? stackId,
    int? cardId,
    _i3.Card? card,
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
        returnValue: _i6.Future<_i3.Card>.value(_FakeCard_1(
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
      ) as _i6.Future<_i3.Card>);

  @override
  _i6.Future<_i3.Card> getCard(
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
        returnValue: _i6.Future<_i3.Card>.value(_FakeCard_1(
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
      ) as _i6.Future<_i3.Card>);

  @override
  _i6.Future<void> deleteCard(
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
        returnValue: _i6.Future<void>.value(),
        returnValueForMissingStub: _i6.Future<void>.value(),
      ) as _i6.Future<void>);

  @override
  _i6.Future<_i3.Card> reorderCard(
    int? boardId,
    int? oldStackId,
    int? cardId,
    _i3.Card? card,
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
        returnValue: _i6.Future<_i3.Card>.value(_FakeCard_1(
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
      ) as _i6.Future<_i3.Card>);

  @override
  _i6.Future<void> assignLabel2Card(
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
        returnValue: _i6.Future<void>.value(),
        returnValueForMissingStub: _i6.Future<void>.value(),
      ) as _i6.Future<void>);

  @override
  _i6.Future<void> removeLabel2Card(
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
        returnValue: _i6.Future<void>.value(),
        returnValueForMissingStub: _i6.Future<void>.value(),
      ) as _i6.Future<void>);

  @override
  _i6.Future<_i3.Assignment> assignUser2Card(
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
        returnValue: _i6.Future<_i3.Assignment>.value(_FakeAssignment_2(
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
      ) as _i6.Future<_i3.Assignment>);

  @override
  _i6.Future<_i3.Assignment> unassignUser2Card(
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
        returnValue: _i6.Future<_i3.Assignment>.value(_FakeAssignment_2(
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
      ) as _i6.Future<_i3.Assignment>);
}

/// A class which mocks [IStorageService].
///
/// See the documentation for Mockito's code generation for more information.
class MockIStorageService extends _i1.Mock implements _i8.IStorageService {
  MockIStorageService() {
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
  dynamic saveAccount(_i3.Account? account) =>
      super.noSuchMethod(Invocation.method(
        #saveAccount,
        [account],
      ));

  @override
  bool hasSettings() => (super.noSuchMethod(
        Invocation.method(
          #hasSettings,
          [],
        ),
        returnValue: false,
      ) as bool);

  @override
  dynamic saveSetting(_i3.Setting? setting) =>
      super.noSuchMethod(Invocation.method(
        #saveSetting,
        [setting],
      ));
}

/// A class which mocks [IAuthService].
///
/// See the documentation for Mockito's code generation for more information.
class MockIAuthService extends _i1.Mock implements _i4.IAuthService {
  MockIAuthService() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i6.Future<bool> login(
    String? serverUrl,
    String? username,
    String? password,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #login,
          [
            serverUrl,
            username,
            password,
          ],
        ),
        returnValue: _i6.Future<bool>.value(false),
      ) as _i6.Future<bool>);

  @override
  _i6.Future<_i4.Capabilities> checkServer(String? serverUrl) =>
      (super.noSuchMethod(
        Invocation.method(
          #checkServer,
          [serverUrl],
        ),
        returnValue: _i6.Future<_i4.Capabilities>.value(_FakeCapabilities_3(
          this,
          Invocation.method(
            #checkServer,
            [serverUrl],
          ),
        )),
      ) as _i6.Future<_i4.Capabilities>);

  @override
  bool isAuth() => (super.noSuchMethod(
        Invocation.method(
          #isAuth,
          [],
        ),
        returnValue: false,
      ) as bool);
}

/// A class which mocks [IStackService].
///
/// See the documentation for Mockito's code generation for more information.
class MockIStackService extends _i1.Mock implements _i9.IStackService {
  MockIStackService() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i6.Future<List<_i3.Stack>?> getAll(int? boardId) => (super.noSuchMethod(
        Invocation.method(
          #getAll,
          [boardId],
        ),
        returnValue: _i6.Future<List<_i3.Stack>?>.value(),
      ) as _i6.Future<List<_i3.Stack>?>);
}
