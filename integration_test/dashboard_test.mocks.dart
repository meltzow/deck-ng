// Mocks generated by Mockito 5.4.5 from annotations
// in deck_ng/integration_test/dashboard_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:deck_ng/model/models.dart' as _i2;
import 'package:deck_ng/service/board_service.dart' as _i5;
import 'package:deck_ng/service/notification_service.dart' as _i7;
import 'package:deck_ng/service/stack_service.dart' as _i6;
import 'package:deck_ng/service/storage_service.dart' as _i3;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: must_be_immutable
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

/// A class which mocks [StorageService].
///
/// See the documentation for Mockito's code generation for more information.
class MockStorageService extends _i1.Mock implements _i3.StorageService {
  @override
  bool hasAccount() => (super.noSuchMethod(
        Invocation.method(
          #hasAccount,
          [],
        ),
        returnValue: false,
        returnValueForMissingStub: false,
      ) as bool);

  @override
  bool hasSettings() => (super.noSuchMethod(
        Invocation.method(
          #hasSettings,
          [],
        ),
        returnValue: false,
        returnValueForMissingStub: false,
      ) as bool);

  @override
  _i4.Future<void> saveSetting(_i2.Setting? setting) => (super.noSuchMethod(
        Invocation.method(
          #saveSetting,
          [setting],
        ),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);
}

/// A class which mocks [BoardService].
///
/// See the documentation for Mockito's code generation for more information.
class MockBoardService extends _i1.Mock implements _i5.BoardService {
  @override
  _i4.Future<List<_i2.Board>> getAllBoards() => (super.noSuchMethod(
        Invocation.method(
          #getAllBoards,
          [],
        ),
        returnValue: _i4.Future<List<_i2.Board>>.value(<_i2.Board>[]),
        returnValueForMissingStub:
            _i4.Future<List<_i2.Board>>.value(<_i2.Board>[]),
      ) as _i4.Future<List<_i2.Board>>);

  @override
  _i4.Future<_i2.Board> getBoard(int? boardId) => (super.noSuchMethod(
        Invocation.method(
          #getBoard,
          [boardId],
        ),
        returnValue: _i4.Future<_i2.Board>.value(_FakeBoard_0(
          this,
          Invocation.method(
            #getBoard,
            [boardId],
          ),
        )),
        returnValueForMissingStub: _i4.Future<_i2.Board>.value(_FakeBoard_0(
          this,
          Invocation.method(
            #getBoard,
            [boardId],
          ),
        )),
      ) as _i4.Future<_i2.Board>);
}

/// A class which mocks [StackService].
///
/// See the documentation for Mockito's code generation for more information.
class MockStackService extends _i1.Mock implements _i6.StackService {
  @override
  _i4.Future<List<_i2.Stack>?> getAll(int? boardId) => (super.noSuchMethod(
        Invocation.method(
          #getAll,
          [boardId],
        ),
        returnValue: _i4.Future<List<_i2.Stack>?>.value(),
        returnValueForMissingStub: _i4.Future<List<_i2.Stack>?>.value(),
      ) as _i4.Future<List<_i2.Stack>?>);
}

/// A class which mocks [NotificationService].
///
/// See the documentation for Mockito's code generation for more information.
class MockNotificationService extends _i1.Mock
    implements _i7.NotificationService {
  @override
  dynamic successMsg(
    String? title,
    String? message,
  ) =>
      super.noSuchMethod(
        Invocation.method(
          #successMsg,
          [
            title,
            message,
          ],
        ),
        returnValueForMissingStub: null,
      );

  @override
  dynamic errorMsg(
    String? s,
    String? t,
  ) =>
      super.noSuchMethod(
        Invocation.method(
          #errorMsg,
          [
            s,
            t,
          ],
        ),
        returnValueForMissingStub: null,
      );
}
