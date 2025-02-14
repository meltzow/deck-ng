// Mocks generated by Mockito 5.4.4 from annotations
// in deck_ng/test/licenses/card_details_screen_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i5;

import 'package:deck_ng/model/models.dart' as _i3;
import 'package:deck_ng/service/auth_service.dart' as _i2;
import 'package:deck_ng/service/board_service.dart' as _i6;
import 'package:deck_ng/service/card_service.dart' as _i8;
import 'package:deck_ng/service/notification_service.dart' as _i9;
import 'package:deck_ng/service/stack_service.dart' as _i7;
import 'package:deck_ng/service/storage_service.dart' as _i4;
import 'package:deck_ng/service/tracking_service.dart' as _i10;
import 'package:mockito/mockito.dart' as _i1;
import 'package:mockito/src/dummies.dart' as _i11;

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

class _FakeCapabilities_0 extends _i1.SmartFake implements _i2.Capabilities {
  _FakeCapabilities_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeBoard_1 extends _i1.SmartFake implements _i3.Board {
  _FakeBoard_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeCard_2 extends _i1.SmartFake implements _i3.Card {
  _FakeCard_2(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeAssignment_3 extends _i1.SmartFake implements _i3.Assignment {
  _FakeAssignment_3(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeAttachment_4 extends _i1.SmartFake implements _i3.Attachment {
  _FakeAttachment_4(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [StorageService].
///
/// See the documentation for Mockito's code generation for more information.
class MockStorageService extends _i1.Mock implements _i4.StorageService {
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
  _i5.Future<void> saveSetting(_i3.Setting? setting) => (super.noSuchMethod(
        Invocation.method(
          #saveSetting,
          [setting],
        ),
        returnValue: _i5.Future<void>.value(),
        returnValueForMissingStub: _i5.Future<void>.value(),
      ) as _i5.Future<void>);
}

/// A class which mocks [AuthService].
///
/// See the documentation for Mockito's code generation for more information.
class MockAuthService extends _i1.Mock implements _i2.AuthService {
  MockAuthService() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i5.Future<bool> login(
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
        returnValue: _i5.Future<bool>.value(false),
      ) as _i5.Future<bool>);

  @override
  _i5.Future<_i2.Capabilities> checkServer(String? serverUrl) =>
      (super.noSuchMethod(
        Invocation.method(
          #checkServer,
          [serverUrl],
        ),
        returnValue: _i5.Future<_i2.Capabilities>.value(_FakeCapabilities_0(
          this,
          Invocation.method(
            #checkServer,
            [serverUrl],
          ),
        )),
      ) as _i5.Future<_i2.Capabilities>);

  @override
  bool isAuth() => (super.noSuchMethod(
        Invocation.method(
          #isAuth,
          [],
        ),
        returnValue: false,
      ) as bool);
}

/// A class which mocks [BoardService].
///
/// See the documentation for Mockito's code generation for more information.
class MockBoardService extends _i1.Mock implements _i6.BoardService {
  MockBoardService() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i5.Future<List<_i3.Board>> getAllBoards() => (super.noSuchMethod(
        Invocation.method(
          #getAllBoards,
          [],
        ),
        returnValue: _i5.Future<List<_i3.Board>>.value(<_i3.Board>[]),
      ) as _i5.Future<List<_i3.Board>>);

  @override
  _i5.Future<_i3.Board> getBoard(int? boardId) => (super.noSuchMethod(
        Invocation.method(
          #getBoard,
          [boardId],
        ),
        returnValue: _i5.Future<_i3.Board>.value(_FakeBoard_1(
          this,
          Invocation.method(
            #getBoard,
            [boardId],
          ),
        )),
      ) as _i5.Future<_i3.Board>);
}

/// A class which mocks [StackService].
///
/// See the documentation for Mockito's code generation for more information.
class MockStackService extends _i1.Mock implements _i7.StackService {
  MockStackService() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i5.Future<List<_i3.Stack>?> getAll(int? boardId) => (super.noSuchMethod(
        Invocation.method(
          #getAll,
          [boardId],
        ),
        returnValue: _i5.Future<List<_i3.Stack>?>.value(),
      ) as _i5.Future<List<_i3.Stack>?>);
}

/// A class which mocks [CardService].
///
/// See the documentation for Mockito's code generation for more information.
class MockCardService extends _i1.Mock implements _i8.CardService {
  MockCardService() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i5.Future<_i3.Card> createCard(
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
        returnValue: _i5.Future<_i3.Card>.value(_FakeCard_2(
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
      ) as _i5.Future<_i3.Card>);

  @override
  _i5.Future<_i3.Card> updateCard(
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
        returnValue: _i5.Future<_i3.Card>.value(_FakeCard_2(
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
      ) as _i5.Future<_i3.Card>);

  @override
  _i5.Future<_i3.Card> getCard(
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
        returnValue: _i5.Future<_i3.Card>.value(_FakeCard_2(
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
      ) as _i5.Future<_i3.Card>);

  @override
  _i5.Future<void> deleteCard(
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
        returnValue: _i5.Future<void>.value(),
        returnValueForMissingStub: _i5.Future<void>.value(),
      ) as _i5.Future<void>);

  @override
  _i5.Future<_i3.Card> reorderCard(
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
        returnValue: _i5.Future<_i3.Card>.value(_FakeCard_2(
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
      ) as _i5.Future<_i3.Card>);

  @override
  _i5.Future<void> assignLabel2Card(
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
        returnValue: _i5.Future<void>.value(),
        returnValueForMissingStub: _i5.Future<void>.value(),
      ) as _i5.Future<void>);

  @override
  _i5.Future<void> removeLabel2Card(
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
        returnValue: _i5.Future<void>.value(),
        returnValueForMissingStub: _i5.Future<void>.value(),
      ) as _i5.Future<void>);

  @override
  _i5.Future<_i3.Assignment> assignUser2Card(
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
        returnValue: _i5.Future<_i3.Assignment>.value(_FakeAssignment_3(
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
      ) as _i5.Future<_i3.Assignment>);

  @override
  _i5.Future<_i3.Assignment> unassignUser2Card(
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
        returnValue: _i5.Future<_i3.Assignment>.value(_FakeAssignment_3(
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
      ) as _i5.Future<_i3.Assignment>);

  @override
  _i5.Future<_i3.Attachment> addAttachmentToCard(
    int? boardId,
    int? stackId,
    int? cardId,
    _i3.Attachment? attachment,
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
        returnValue: _i5.Future<_i3.Attachment>.value(_FakeAttachment_4(
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
      ) as _i5.Future<_i3.Attachment>);
}

/// A class which mocks [NotificationService].
///
/// See the documentation for Mockito's code generation for more information.
class MockNotificationService extends _i1.Mock
    implements _i9.NotificationService {
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

/// A class which mocks [TrackingService].
///
/// See the documentation for Mockito's code generation for more information.
class MockTrackingService extends _i1.Mock implements _i10.TrackingService {
  MockTrackingService() {
    _i1.throwOnMissingStub(this);
  }

  @override
  bool isOptedOut() => (super.noSuchMethod(
        Invocation.method(
          #isOptedOut,
          [],
        ),
        returnValue: false,
      ) as bool);

  @override
  void optOut() => super.noSuchMethod(
        Invocation.method(
          #optOut,
          [],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void optIn() => super.noSuchMethod(
        Invocation.method(
          #optIn,
          [],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void trackEvent(
    String? eventName, {
    Map<String, dynamic>? properties,
  }) =>
      super.noSuchMethod(
        Invocation.method(
          #trackEvent,
          [eventName],
          {#properties: properties},
        ),
        returnValueForMissingStub: null,
      );

  @override
  void onScreenEvent(String? screenName) => super.noSuchMethod(
        Invocation.method(
          #onScreenEvent,
          [screenName],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void onButtonClickedEvent(String? buttonName) => super.noSuchMethod(
        Invocation.method(
          #onButtonClickedEvent,
          [buttonName],
        ),
        returnValueForMissingStub: null,
      );

  @override
  String determineBuildMode() => (super.noSuchMethod(
        Invocation.method(
          #determineBuildMode,
          [],
        ),
        returnValue: _i11.dummyValue<String>(
          this,
          Invocation.method(
            #determineBuildMode,
            [],
          ),
        ),
      ) as String);

  @override
  void modifyMetaData() => super.noSuchMethod(
        Invocation.method(
          #modifyMetaData,
          [],
        ),
        returnValueForMissingStub: null,
      );
}
