// Mocks generated by Mockito 5.4.4 from annotations
// in deck_ng/integration_test/board_overview_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i5;

import 'package:deck_ng/model/account.dart' as _i3;
import 'package:deck_ng/service/Icredential_service.dart' as _i7;
import 'package:deck_ng/service/Ihttp_service.dart' as _i4;
import 'package:deck_ng/service/impl/retry.dart' as _i6;
import 'package:dio/dio.dart' as _i2;
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

class _FakeResponse_0<T1> extends _i1.SmartFake implements _i2.Response<T1> {
  _FakeResponse_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeAccount_1 extends _i1.SmartFake implements _i3.Account {
  _FakeAccount_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [IHttpService].
///
/// See the documentation for Mockito's code generation for more information.
class MockIHttpService extends _i1.Mock implements _i4.IHttpService {
  MockIHttpService() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i5.Future<Map<String, dynamic>> get(String? path) => (super.noSuchMethod(
        Invocation.method(
          #get,
          [path],
        ),
        returnValue:
            _i5.Future<Map<String, dynamic>>.value(<String, dynamic>{}),
      ) as _i5.Future<Map<String, dynamic>>);

  @override
  _i5.Future<List<dynamic>> getListResponse(String? path) =>
      (super.noSuchMethod(
        Invocation.method(
          #getListResponse,
          [path],
        ),
        returnValue: _i5.Future<List<dynamic>>.value(<dynamic>[]),
      ) as _i5.Future<List<dynamic>>);

  @override
  _i5.Future<Map<String, dynamic>> post(
    String? path, [
    dynamic body,
    bool? useAccount,
  ]) =>
      (super.noSuchMethod(
        Invocation.method(
          #post,
          [
            path,
            body,
            useAccount,
          ],
        ),
        returnValue:
            _i5.Future<Map<String, dynamic>>.value(<String, dynamic>{}),
      ) as _i5.Future<Map<String, dynamic>>);

  @override
  _i5.Future<Map<String, dynamic>> put(
    String? path,
    dynamic body,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #put,
          [
            path,
            body,
          ],
        ),
        returnValue:
            _i5.Future<Map<String, dynamic>>.value(<String, dynamic>{}),
      ) as _i5.Future<Map<String, dynamic>>);

  @override
  _i5.Future<_i2.Response<T>> retry<T>(
    _i2.RequestOptions? ops, [
    _i6.RetryOptions? retryOptions,
  ]) =>
      (super.noSuchMethod(
        Invocation.method(
          #retry,
          [
            ops,
            retryOptions,
          ],
        ),
        returnValue: _i5.Future<_i2.Response<T>>.value(_FakeResponse_0<T>(
          this,
          Invocation.method(
            #retry,
            [
              ops,
              retryOptions,
            ],
          ),
        )),
      ) as _i5.Future<_i2.Response<T>>);
}

/// A class which mocks [ICredentialService].
///
/// See the documentation for Mockito's code generation for more information.
class MockICredentialService extends _i1.Mock
    implements _i7.ICredentialService {
  MockICredentialService() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i5.Future<_i3.Account> getAccount() => (super.noSuchMethod(
        Invocation.method(
          #getAccount,
          [],
        ),
        returnValue: _i5.Future<_i3.Account>.value(_FakeAccount_1(
          this,
          Invocation.method(
            #getAccount,
            [],
          ),
        )),
      ) as _i5.Future<_i3.Account>);

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
        returnValue: _i8.dummyValue<String>(
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
