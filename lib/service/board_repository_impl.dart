import 'package:deck_ng/model/board.dart';
import 'package:deck_ng/service/Ihttp_service.dart';
import 'package:get/get.dart';

class BoardRepositoryImpl extends GetxService {
  final httpService = Get.find<IHttpService>();

  Future<List<Board>> getAllBoards() async {
    dynamic response = await httpService.getListResponse(
      "/index.php/apps/deck/api/v1/boards",
    );
    final dynamic t = response;
    List<Board> mediaList =
        (t as List).map((item) => Board.fromJson(item)).toList();
    return mediaList;
  }

  Future<Board> getBoard(int boardId) async {
    dynamic response = await httpService
        .getResponse("/index.php/apps/deck/api/v1/boards/$boardId");
    Board board = Board.fromJson(response);
    return board;
  }
}
