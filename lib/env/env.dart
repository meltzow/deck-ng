import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(path: '.env')
abstract class Env {
  @EnviedField(varName: 'WIREDASH_SECRET', obfuscate: true)
  static final String WIREDASH_SECRET = _Env.WIREDASH_SECRET;
}
