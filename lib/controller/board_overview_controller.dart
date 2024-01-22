import 'package:deck_ng/model/board.dart';
import 'package:deck_ng/service/Iboard_service.dart';
import 'package:get/get.dart';

class BoardOverviewController extends GetxController {
  final RxBool isLoading = RxBool(true);
  final Rx<List<Board>> _boardsData = Rx<List<Board>>([]);

  final IBoardService _boardRepository = Get.find<IBoardService>();

  List<Board> get boardData => _boardsData.value;
  int get boardDataCount => _boardsData.value.length;

  @override
  void onReady() async {
    await refreshData();
    return super.onReady();
  }

  Future<void> refreshData() async {
    isLoading.value = true;
    _boardsData.value = (await _boardRepository.getAllBoards()).obs;
    isLoading.value = false;
  }
}
