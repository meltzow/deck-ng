// Mocks generated by Mockito 5.4.4 from annotations
// in deck_ng/test/controller/dashboard_controller_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i7;

import 'package:deck_ng/model/board.dart' as _i3;
import 'package:deck_ng/model/stack.dart' as _i10;
import 'package:deck_ng/service/auth_service.dart' as _i2;
import 'package:deck_ng/service/board_service.dart' as _i8;
import 'package:deck_ng/service/stack_service.dart' as _i9;
import 'package:deck_ng/service/storage_service.dart' as _i4;
import 'package:deck_ng/service/tracking_service.dart' as _i11;
import 'package:get/get.dart' as _i6;
import 'package:mockito/mockito.dart' as _i1;
import 'package:mockito/src/dummies.dart' as _i12;
import 'package:uuid/uuid.dart' as _i5;

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

class _FakeStorageService_2 extends _i1.SmartFake
    implements _i4.StorageService {
  _FakeStorageService_2(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeUuid_3 extends _i1.SmartFake implements _i5.Uuid {
  _FakeUuid_3(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeInternalFinalCallback_4<T> extends _i1.SmartFake
    implements _i6.InternalFinalCallback<T> {
  _FakeInternalFinalCallback_4(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [AuthService].
///
/// See the documentation for Mockito's code generation for more information.
class MockAuthService extends _i1.Mock implements _i2.AuthService {
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
  _i7.Future<_i2.Capabilities> checkServer(String? serverUrl) =>
      (super.noSuchMethod(
        Invocation.method(
          #checkServer,
          [serverUrl],
        ),
        returnValue: _i7.Future<_i2.Capabilities>.value(_FakeCapabilities_0(
          this,
          Invocation.method(
            #checkServer,
            [serverUrl],
          ),
        )),
      ) as _i7.Future<_i2.Capabilities>);

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
class MockBoardService extends _i1.Mock implements _i8.BoardService {
  MockBoardService() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i7.Future<List<_i3.Board>> getAllBoards() => (super.noSuchMethod(
        Invocation.method(
          #getAllBoards,
          [],
        ),
        returnValue: _i7.Future<List<_i3.Board>>.value(<_i3.Board>[]),
      ) as _i7.Future<List<_i3.Board>>);

  @override
  _i7.Future<_i3.Board> getBoard(int? boardId) => (super.noSuchMethod(
        Invocation.method(
          #getBoard,
          [boardId],
        ),
        returnValue: _i7.Future<_i3.Board>.value(_FakeBoard_1(
          this,
          Invocation.method(
            #getBoard,
            [boardId],
          ),
        )),
      ) as _i7.Future<_i3.Board>);
}

/// A class which mocks [StackService].
///
/// See the documentation for Mockito's code generation for more information.
class MockStackService extends _i1.Mock implements _i9.StackService {
  MockStackService() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i7.Future<List<_i10.Stack>?> getAll(int? boardId) => (super.noSuchMethod(
        Invocation.method(
          #getAll,
          [boardId],
        ),
        returnValue: _i7.Future<List<_i10.Stack>?>.value(),
      ) as _i7.Future<List<_i10.Stack>?>);
}

/// A class which mocks [TrackingService].
///
/// See the documentation for Mockito's code generation for more information.
class MockTrackingService extends _i1.Mock implements _i11.TrackingService {
  MockTrackingService() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.StorageService get storageService => (super.noSuchMethod(
        Invocation.getter(#storageService),
        returnValue: _FakeStorageService_2(
          this,
          Invocation.getter(#storageService),
        ),
      ) as _i4.StorageService);

  @override
  _i5.Uuid get uuid => (super.noSuchMethod(
        Invocation.getter(#uuid),
        returnValue: _FakeUuid_3(
          this,
          Invocation.getter(#uuid),
        ),
      ) as _i5.Uuid);

  @override
  _i6.InternalFinalCallback<void> get onStart => (super.noSuchMethod(
        Invocation.getter(#onStart),
        returnValue: _FakeInternalFinalCallback_4<void>(
          this,
          Invocation.getter(#onStart),
        ),
      ) as _i6.InternalFinalCallback<void>);

  @override
  _i6.InternalFinalCallback<void> get onDelete => (super.noSuchMethod(
        Invocation.getter(#onDelete),
        returnValue: _FakeInternalFinalCallback_4<void>(
          this,
          Invocation.getter(#onDelete),
        ),
      ) as _i6.InternalFinalCallback<void>);

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
  void onInit() => super.noSuchMethod(
        Invocation.method(
          #onInit,
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
        returnValue: _i12.dummyValue<String>(
          this,
          Invocation.method(
            #determineBuildMode,
            [],
          ),
        ),
      ) as String);

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
}
