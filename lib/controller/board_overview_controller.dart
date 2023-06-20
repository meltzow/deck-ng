import 'package:deck_ng/model/board.dart';
import 'package:deck_ng/service/board_repository_impl.dart';
import 'package:get/get.dart';

class BoardOverviewController extends GetxController {
  final Rx<List<Board>> _boardsData = Rx<List<Board>>([]);

  final BoardRepositoryImpl _boardRepository = Get.find<BoardRepositoryImpl>();

  List<Board> get boardData => _boardsData.value ?? [];
  int get boardDataCount => _boardsData.value.length ?? 0;

  @override
  void onReady() async {
    super.onReady();
    _boardsData.value = (await _boardRepository.getAllBoards()).obs;
  }

  Future<void> refreshData() async {
    _boardsData.value = (await _boardRepository.getAllBoards()).obs;
  }
}
