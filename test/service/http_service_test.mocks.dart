// Mocks generated by Mockito 5.4.4 from annotations
// in deck_ng/test/service/http_service_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i3;

import 'package:deck_ng/service/Iauth_service.dart' as _i2;
import 'package:deck_ng/service/Icredential_service.dart' as _i4;
import 'package:mockito/mockito.dart' as _i1;
import 'package:mockito/src/dummies.dart' as _i5;

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

/// A class which mocks [IAuthService].
///
/// See the documentation for Mockito's code generation for more information.
class MockIAuthService extends _i1.Mock implements _i2.IAuthService {
  MockIAuthService() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i3.Future<bool> login(
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
        returnValue: _i3.Future<bool>.value(false),
      ) as _i3.Future<bool>);
}

/// A class which mocks [ICredentialService].
///
/// See the documentation for Mockito's code generation for more information.
class MockICredentialService extends _i1.Mock
    implements _i4.ICredentialService {
  MockICredentialService() {
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
  dynamic saveCredentials(
    String? url,
    String? username,
    String? password,
    bool? isAuth,
  ) =>
      super.noSuchMethod(Invocation.method(
        #saveCredentials,
        [
          url,
          username,
          password,
          isAuth,
        ],
      ));

  @override
  String computeAuth(
    dynamic username,
    dynamic password,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #computeAuth,
          [
            username,
            password,
          ],
        ),
        returnValue: _i5.dummyValue<String>(
          this,
          Invocation.method(
            #computeAuth,
            [
              username,
              password,
            ],
          ),
        ),
      ) as String);
}
