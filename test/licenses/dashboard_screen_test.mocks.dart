// Mocks generated by Mockito 5.4.5 from annotations
// in deck_ng/test/licenses/dashboard_screen_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i6;
import 'dart:ui' as _i8;

import 'package:deck_ng/home/dashboard_controller.dart' as _i5;
import 'package:deck_ng/model/board.dart' as _i3;
import 'package:deck_ng/model/models.dart' as _i10;
import 'package:deck_ng/model/stack.dart' as _i9;
import 'package:deck_ng/service/services.dart' as _i4;
import 'package:deck_ng/service/tracking_service.dart' as _i11;
import 'package:get/get.dart' as _i2;
import 'package:get/get_state_manager/src/simple/list_notifier.dart' as _i7;
import 'package:mockito/mockito.dart' as _i1;
import 'package:mockito/src/dummies.dart' as _i12;

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

class _FakeRxInt_0 extends _i1.SmartFake implements _i2.RxInt {
  _FakeRxInt_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeRxBool_1 extends _i1.SmartFake implements _i2.RxBool {
  _FakeRxBool_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeRxString_2 extends _i1.SmartFake implements _i2.RxString {
  _FakeRxString_2(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeRxList_3<E> extends _i1.SmartFake implements _i2.RxList<E> {
  _FakeRxList_3(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeRx_4<T> extends _i1.SmartFake implements _i2.Rx<T> {
  _FakeRx_4(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeInternalFinalCallback_5<T> extends _i1.SmartFake
    implements _i2.InternalFinalCallback<T> {
  _FakeInternalFinalCallback_5(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeBoard_6 extends _i1.SmartFake implements _i3.Board {
  _FakeBoard_6(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeCapabilities_7 extends _i1.SmartFake implements _i4.Capabilities {
  _FakeCapabilities_7(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [DashboardController].
///
/// See the documentation for Mockito's code generation for more information.
class MockDashboardController extends _i1.Mock
    implements _i5.DashboardController {
  MockDashboardController() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.RxInt get boardCount => (super.noSuchMethod(
        Invocation.getter(#boardCount),
        returnValue: _FakeRxInt_0(
          this,
          Invocation.getter(#boardCount),
        ),
      ) as _i2.RxInt);

  @override
  set boardCount(_i2.RxInt? _boardCount) => super.noSuchMethod(
        Invocation.setter(
          #boardCount,
          _boardCount,
        ),
        returnValueForMissingStub: null,
      );

  @override
  _i2.RxInt get stackCount => (super.noSuchMethod(
        Invocation.getter(#stackCount),
        returnValue: _FakeRxInt_0(
          this,
          Invocation.getter(#stackCount),
        ),
      ) as _i2.RxInt);

  @override
  set stackCount(_i2.RxInt? _stackCount) => super.noSuchMethod(
        Invocation.setter(
          #stackCount,
          _stackCount,
        ),
        returnValueForMissingStub: null,
      );

  @override
  _i2.RxInt get taskCount => (super.noSuchMethod(
        Invocation.getter(#taskCount),
        returnValue: _FakeRxInt_0(
          this,
          Invocation.getter(#taskCount),
        ),
      ) as _i2.RxInt);

  @override
  set taskCount(_i2.RxInt? _taskCount) => super.noSuchMethod(
        Invocation.setter(
          #taskCount,
          _taskCount,
        ),
        returnValueForMissingStub: null,
      );

  @override
  _i2.RxBool get isLoading => (super.noSuchMethod(
        Invocation.getter(#isLoading),
        returnValue: _FakeRxBool_1(
          this,
          Invocation.getter(#isLoading),
        ),
      ) as _i2.RxBool);

  @override
  _i2.RxString get errorMessage => (super.noSuchMethod(
        Invocation.getter(#errorMessage),
        returnValue: _FakeRxString_2(
          this,
          Invocation.getter(#errorMessage),
        ),
      ) as _i2.RxString);

  @override
  _i2.RxList<_i3.Board> get boards => (super.noSuchMethod(
        Invocation.getter(#boards),
        returnValue: _FakeRxList_3<_i3.Board>(
          this,
          Invocation.getter(#boards),
        ),
      ) as _i2.RxList<_i3.Board>);

  @override
  set boards(_i2.RxList<_i3.Board>? _boards) => super.noSuchMethod(
        Invocation.setter(
          #boards,
          _boards,
        ),
        returnValueForMissingStub: null,
      );

  @override
  _i2.Rx<_i5.SortOption> get sortOption => (super.noSuchMethod(
        Invocation.getter(#sortOption),
        returnValue: _FakeRx_4<_i5.SortOption>(
          this,
          Invocation.getter(#sortOption),
        ),
      ) as _i2.Rx<_i5.SortOption>);

  @override
  set sortOption(_i2.Rx<_i5.SortOption>? _sortOption) => super.noSuchMethod(
        Invocation.setter(
          #sortOption,
          _sortOption,
        ),
        returnValueForMissingStub: null,
      );

  @override
  List<_i5.DashboardData> get dashboardData => (super.noSuchMethod(
        Invocation.getter(#dashboardData),
        returnValue: <_i5.DashboardData>[],
      ) as List<_i5.DashboardData>);

  @override
  _i2.InternalFinalCallback<void> get onStart => (super.noSuchMethod(
        Invocation.getter(#onStart),
        returnValue: _FakeInternalFinalCallback_5<void>(
          this,
          Invocation.getter(#onStart),
        ),
      ) as _i2.InternalFinalCallback<void>);

  @override
  _i2.InternalFinalCallback<void> get onDelete => (super.noSuchMethod(
        Invocation.getter(#onDelete),
        returnValue: _FakeInternalFinalCallback_5<void>(
          this,
          Invocation.getter(#onDelete),
        ),
      ) as _i2.InternalFinalCallback<void>);

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
  void sortBoards(_i5.SortOption? option) => super.noSuchMethod(
        Invocation.method(
          #sortBoards,
          [option],
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
  _i6.Future<void> fetchData() => (super.noSuchMethod(
        Invocation.method(
          #fetchData,
          [],
        ),
        returnValue: _i6.Future<void>.value(),
        returnValueForMissingStub: _i6.Future<void>.value(),
      ) as _i6.Future<void>);

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
  void onInit() => super.noSuchMethod(
        Invocation.method(
          #onInit,
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
  _i7.Disposer addListener(_i7.GetStateUpdate? listener) => (super.noSuchMethod(
        Invocation.method(
          #addListener,
          [listener],
        ),
        returnValue: () {},
      ) as _i7.Disposer);

  @override
  void removeListener(_i8.VoidCallback? listener) => super.noSuchMethod(
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
    _i8.VoidCallback? listener,
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
  _i7.Disposer addListenerId(
    Object? key,
    _i7.GetStateUpdate? listener,
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
      ) as _i7.Disposer);

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
class MockBoardService extends _i1.Mock implements _i4.BoardService {
  MockBoardService() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i6.Future<List<_i3.Board>> getAllBoards() => (super.noSuchMethod(
        Invocation.method(
          #getAllBoards,
          [],
        ),
        returnValue: _i6.Future<List<_i3.Board>>.value(<_i3.Board>[]),
      ) as _i6.Future<List<_i3.Board>>);

  @override
  _i6.Future<_i3.Board> getBoard(int? boardId) => (super.noSuchMethod(
        Invocation.method(
          #getBoard,
          [boardId],
        ),
        returnValue: _i6.Future<_i3.Board>.value(_FakeBoard_6(
          this,
          Invocation.method(
            #getBoard,
            [boardId],
          ),
        )),
      ) as _i6.Future<_i3.Board>);
}

/// A class which mocks [NotificationService].
///
/// See the documentation for Mockito's code generation for more information.
class MockNotificationService extends _i1.Mock
    implements _i4.NotificationService {
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
class MockStackService extends _i1.Mock implements _i4.StackService {
  MockStackService() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i6.Future<List<_i9.Stack>?> getAll(int? boardId) => (super.noSuchMethod(
        Invocation.method(
          #getAll,
          [boardId],
        ),
        returnValue: _i6.Future<List<_i9.Stack>?>.value(),
      ) as _i6.Future<List<_i9.Stack>?>);
}

/// A class which mocks [AuthService].
///
/// See the documentation for Mockito's code generation for more information.
class MockAuthService extends _i1.Mock implements _i4.AuthService {
  MockAuthService() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i6.Future<bool> login(
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
        returnValue: _i6.Future<bool>.value(false),
      ) as _i6.Future<bool>);

  @override
  _i6.Future<_i4.Capabilities> checkServer(String? serverUrl) =>
      (super.noSuchMethod(
        Invocation.method(
          #checkServer,
          [serverUrl],
        ),
        returnValue: _i6.Future<_i4.Capabilities>.value(_FakeCapabilities_7(
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
  _i6.Future<void> saveSetting(_i10.Setting? setting) => (super.noSuchMethod(
        Invocation.method(
          #saveSetting,
          [setting],
        ),
        returnValue: _i6.Future<void>.value(),
        returnValueForMissingStub: _i6.Future<void>.value(),
      ) as _i6.Future<void>);
}

/// A class which mocks [TrackingService].
///
/// See the documentation for Mockito's code generation for more information.
class MockTrackingService extends _i1.Mock implements _i11.TrackingService {
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
        returnValue: _i12.dummyValue<String>(
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
