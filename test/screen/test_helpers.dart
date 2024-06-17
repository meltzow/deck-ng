// test_helpers.dart
import 'package:deck_ng/model/models.dart';
import 'package:deck_ng/service/services.dart';
import 'package:mockito/mockito.dart';

void setupMockAccount(
    StorageService storageServiceMock, AuthService authServiceMock) {
  var resp = Account(
      username: 'admin',
      password: 'password',
      authData: 'authData',
      url: 'http://localhost',
      isAuthenticated: true);

  when(storageServiceMock.hasAccount()).thenReturn(true);
  when(storageServiceMock.getAccount()).thenReturn(resp);
  when(authServiceMock.getAccount()).thenReturn(resp);
  when(authServiceMock.isAuth()).thenReturn(true);
}
