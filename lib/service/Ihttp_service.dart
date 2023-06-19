import 'package:deck_ng/model/board.dart';

abstract class IHttpService {
  Future<Map<String, dynamic>> getResponse(String path);

  Future<List<Board>> getAllBoards();
}
