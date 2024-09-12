import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(path: '.env')
abstract class Env {
  @EnviedField(varName: 'WIREDASH_SECRET', obfuscate: true)
  static final String WIREDASH_SECRET = _Env.WIREDASH_SECRET;

  @EnviedField(varName: 'WIREDASH_PROJECT_ID')
  static final String WIREDASH_PROJECT_ID = _Env.WIREDASH_PROJECT_ID;
}
