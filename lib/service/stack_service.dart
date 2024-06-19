import 'package:deck_ng/model/stack.dart';

abstract class StackService {
  Future<List<Stack>?> getAll(int boardId);
}
