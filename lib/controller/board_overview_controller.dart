import 'package:deck_ng/model/board.dart';
import 'package:deck_ng/service/Iboard_service.dart';
import 'package:get/get.dart';

class DashboardData {
  late String valueName;
  late int count;

  DashboardData.name(this.valueName, this.count);

  DashboardData({required this.valueName, required this.count});
}

class BoardOverviewController extends GetxController {
  final RxBool isLoading = RxBool(true);
  final Rx<List<Board>> _boardsData = Rx<List<Board>>([]);

  final IBoardService _boardRepository = Get.find<IBoardService>();

  List<Board> get boardData => _boardsData.value;
  int get boardDataCount => _boardsData.value.length;

  List<DashboardData> get dashboardData => computeDashboard();

  @override
  void onReady() async {
    refreshData();
    return super.onReady();
  }

  Future<void> refreshData() async {
    isLoading.value = true;
    _boardsData.value = (await _boardRepository.getAllBoards()).obs;
    isLoading.value = false;
  }

  List<DashboardData> computeDashboard() {
    return [DashboardData(valueName: 'count Boards', count: 13)];
  }
}
