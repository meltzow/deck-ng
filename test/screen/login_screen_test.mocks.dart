// Mocks generated by Mockito 5.4.4 from annotations
// in deck_ng/test/screen/login_screen_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:deck_ng/model/models.dart' as _i5;
import 'package:deck_ng/service/auth_service.dart' as _i2;
import 'package:deck_ng/service/notification_service.dart' as _i6;
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

/// A class which mocks [StorageService].
///
/// See the documentation for Mockito's code generation for more information.
class MockStorageService extends _i1.Mock implements _i3.StorageService {
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
  _i4.Future<void> saveSetting(_i5.Setting? setting) => (super.noSuchMethod(
        Invocation.method(
          #saveSetting,
          [setting],
        ),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);
}

/// A class which mocks [AuthService].
///
/// See the documentation for Mockito's code generation for more information.
class MockAuthService extends _i1.Mock implements _i2.AuthService {
  MockAuthService() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<bool> login(
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
        returnValue: _i4.Future<bool>.value(false),
      ) as _i4.Future<bool>);

  @override
  _i4.Future<_i2.Capabilities> checkServer(String? serverUrl) =>
      (super.noSuchMethod(
        Invocation.method(
          #checkServer,
          [serverUrl],
        ),
        returnValue: _i4.Future<_i2.Capabilities>.value(_FakeCapabilities_0(
          this,
          Invocation.method(
            #checkServer,
            [serverUrl],
          ),
        )),
      ) as _i4.Future<_i2.Capabilities>);

  @override
  bool isAuth() => (super.noSuchMethod(
        Invocation.method(
          #isAuth,
          [],
        ),
        returnValue: false,
      ) as bool);
}

/// A class which mocks [NotificationService].
///
/// See the documentation for Mockito's code generation for more information.
class MockNotificationService extends _i1.Mock
    implements _i6.NotificationService {
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
