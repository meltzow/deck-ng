// Mocks generated by Mockito 5.4.4 from annotations
// in deck_ng/test/controller/card_details_controller_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:deck_ng/model/models.dart' as _i2;
import 'package:deck_ng/service/board_service.dart' as _i6;
import 'package:deck_ng/service/card_service.dart' as _i3;
import 'package:deck_ng/service/notification_service.dart' as _i5;
import 'package:deck_ng/service/tracking_service.dart' as _i7;
import 'package:mockito/mockito.dart' as _i1;
import 'package:mockito/src/dummies.dart' as _i8;

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

class _FakeCard_0 extends _i1.SmartFake implements _i2.Card {
  _FakeCard_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeAssignment_1 extends _i1.SmartFake implements _i2.Assignment {
  _FakeAssignment_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeAttachment_2 extends _i1.SmartFake implements _i2.Attachment {
  _FakeAttachment_2(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeBoard_3 extends _i1.SmartFake implements _i2.Board {
  _FakeBoard_3(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [CardService].
///
/// See the documentation for Mockito's code generation for more information.
class MockCardService extends _i1.Mock implements _i3.CardService {
  MockCardService() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.Card> createCard(
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
        returnValue: _i4.Future<_i2.Card>.value(_FakeCard_0(
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
      ) as _i4.Future<_i2.Card>);

  @override
  _i4.Future<_i2.Card> updateCard(
    int? boardId,
    int? stackId,
    int? cardId,
    _i2.Card? card,
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
        returnValue: _i4.Future<_i2.Card>.value(_FakeCard_0(
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
      ) as _i4.Future<_i2.Card>);

  @override
  _i4.Future<_i2.Card> getCard(
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
        returnValue: _i4.Future<_i2.Card>.value(_FakeCard_0(
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
      ) as _i4.Future<_i2.Card>);

  @override
  _i4.Future<void> deleteCard(
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
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);

  @override
  _i4.Future<_i2.Card> reorderCard(
    int? boardId,
    int? oldStackId,
    int? cardId,
    _i2.Card? card,
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
        returnValue: _i4.Future<_i2.Card>.value(_FakeCard_0(
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
      ) as _i4.Future<_i2.Card>);

  @override
  _i4.Future<void> assignLabel2Card(
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
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);

  @override
  _i4.Future<void> removeLabel2Card(
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
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);

  @override
  _i4.Future<_i2.Assignment> assignUser2Card(
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
        returnValue: _i4.Future<_i2.Assignment>.value(_FakeAssignment_1(
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
      ) as _i4.Future<_i2.Assignment>);

  @override
  _i4.Future<_i2.Assignment> unassignUser2Card(
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
        returnValue: _i4.Future<_i2.Assignment>.value(_FakeAssignment_1(
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
      ) as _i4.Future<_i2.Assignment>);

  @override
  _i4.Future<_i2.Attachment> addAttachmentToCard(
    int? boardId,
    int? stackId,
    int? cardId,
    _i2.Attachment? attachment,
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
        returnValue: _i4.Future<_i2.Attachment>.value(_FakeAttachment_2(
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
      ) as _i4.Future<_i2.Attachment>);
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

/// A class which mocks [BoardService].
///
/// See the documentation for Mockito's code generation for more information.
class MockBoardService extends _i1.Mock implements _i6.BoardService {
  MockBoardService() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<List<_i2.Board>> getAllBoards() => (super.noSuchMethod(
        Invocation.method(
          #getAllBoards,
          [],
        ),
        returnValue: _i4.Future<List<_i2.Board>>.value(<_i2.Board>[]),
      ) as _i4.Future<List<_i2.Board>>);

  @override
  _i4.Future<_i2.Board> getBoard(int? boardId) => (super.noSuchMethod(
        Invocation.method(
          #getBoard,
          [boardId],
        ),
        returnValue: _i4.Future<_i2.Board>.value(_FakeBoard_3(
          this,
          Invocation.method(
            #getBoard,
            [boardId],
          ),
        )),
      ) as _i4.Future<_i2.Board>);
}

/// A class which mocks [TrackingService].
///
/// See the documentation for Mockito's code generation for more information.
class MockTrackingService extends _i1.Mock implements _i7.TrackingService {
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
        returnValue: _i8.dummyValue<String>(
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
