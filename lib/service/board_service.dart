import 'package:deck_ng/model/board.dart';

abstract class BoardService {
  Future<List<Board>> getAllBoards();

  Future<Board> getBoard(int boardId);
}
