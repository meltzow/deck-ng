import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(path: '.env')
abstract class Env {
  @EnviedField(varName: 'WIREDASH_SECRET', obfuscate: true)
  static final String WIREDASH_SECRET = _Env.WIREDASH_SECRET;

  @EnviedField(varName: 'WIREDASH_SECRET_TEST', obfuscate: true)
  static final String WIREDASH_SECRET_TEST = _Env.WIREDASH_SECRET_TEST;
}
