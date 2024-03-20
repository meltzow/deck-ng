import 'package:deck_ng/model/stack.dart';

abstract class IStackService {
  Future<List<Stack>?> getAll(int boardId);
}
