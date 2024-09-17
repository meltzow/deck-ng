import 'package:deck_ng/model/board.dart';
import 'package:deck_ng/service/services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashboardData {
  late String valueName;
  late int count;
  late IconData icon;

  DashboardData.name(this.valueName, this.count, this.icon);

  DashboardData(
      {required this.valueName,
      required this.count,
      this.icon = Icons.favorite});
}

class DashboardController extends GetxController {
  var boardCount = 0.obs;
  var stackCount = 0.obs;
  var taskCount = 0.obs;

  final RxBool isLoading = RxBool(true);
  final RxString errorMessage = ''.obs;
  var boards = <Board>[].obs;
  final Rx<List<DashboardData>> _dashboardData = Rx<List<DashboardData>>([]);

  final BoardService _boardService = Get.find<BoardService>();
  final StackService _stackService = Get.find<StackService>();

  List<DashboardData> get dashboardData => _dashboardData.value;

  @override
  void onReady() async {
    fetchData();
    return super.onReady();
  }

  Future<void> fetchData() async {
    isLoading.value = true;
    errorMessage.value = '';
    try {
      boards.value = (await _boardService.getAllBoards()).obs;
      _dashboardData.value = (await _computeDashboard()).obs;

      boardCount.value = boards.length;
      stackCount.value =
          boards.fold(0, (sum, board) => sum + board.stacks.length);
      taskCount.value = boards.fold(
          0,
          (sum, board) =>
              sum +
              board.stacks.fold(0, (sum, stack) => sum + stack.cards.length));
    } catch (e) {
      errorMessage.value = 'Failed to fetch data: ${e.toString()}';
    } finally {
      isLoading.value = false;
    }
  }

  Future<List<DashboardData>> _computeDashboard() async {
    var stackCount = 0;
    var taskCount = 0;
    for (var board in boards.value) {
      var stacks = await _stackService.getAll(board.id);
      board.stacks = stacks!;
      for (var stack in stacks) {
        stackCount++;
        for (var card in stack.cards) {
          taskCount++;
        }
      }
    }

    return [
      DashboardData(
          valueName: '# Boards',
          count: boards.value.length,
          icon: Icons.view_timeline_outlined),
      DashboardData(
          valueName: '# stack',
          count: stackCount,
          icon: Icons.width_normal_outlined),
      DashboardData(
          valueName: '# tasks',
          count: taskCount,
          icon: Icons.check_circle_outline)
    ];
  }
}
