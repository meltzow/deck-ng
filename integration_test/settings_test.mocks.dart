// Mocks generated by Mockito 5.4.4 from annotations
// in deck_ng/integration_test/settings_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:deck_ng/model/models.dart' as _i3;
import 'package:deck_ng/service/notification_service.dart' as _i4;
import 'package:deck_ng/service/storage_service.dart' as _i2;
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

/// A class which mocks [StorageService].
///
/// See the documentation for Mockito's code generation for more information.
class MockStorageService extends _i1.Mock implements _i2.StorageService {
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
  dynamic saveAccount(_i3.Account? account) => super.noSuchMethod(
        Invocation.method(
          #saveAccount,
          [account],
        ),
        returnValueForMissingStub: null,
      );

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
  dynamic saveSetting(_i3.Setting? setting) => super.noSuchMethod(
        Invocation.method(
          #saveSetting,
          [setting],
        ),
        returnValueForMissingStub: null,
      );
}

/// A class which mocks [NotificationService].
///
/// See the documentation for Mockito's code generation for more information.
class MockNotificationService extends _i1.Mock
    implements _i4.NotificationService {
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
