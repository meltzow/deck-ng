import 'package:deck_ng/model/board.dart';
import 'package:deck_ng/service/Iboard_service.dart';
import 'package:get/get.dart';

class BoardOverviewController extends GetxController {
  final Rx<List<Board>> _boardsData = Rx<List<Board>>([]);

  final IBoardService _boardRepository = Get.find<IBoardService>();

  List<Board> get boardData => _boardsData.value ?? [];
  int get boardDataCount => _boardsData.value.length ?? 0;

  @override
  void onReady() async {
    super.onReady();
    await refreshData();
  }

  Future<void> refreshData() async {
    _boardsData.value = (await _boardRepository.getAllBoards()).obs;
  }
}
