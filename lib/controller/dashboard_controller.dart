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
  final RxBool isLoading = RxBool(true);
  final Rx<List<Board>> _boardsData = Rx<List<Board>>([]);
  final Rx<List<DashboardData>> _dashboardData = Rx<List<DashboardData>>([]);

  final BoardService _boardService = Get.find<BoardService>();
  final StackService _stackService = Get.find<StackService>();

  List<Board> get boardData => _boardsData.value;

  List<DashboardData> get dashboardData => _dashboardData.value;

  @override
  void onReady() async {
    refreshData();
    return super.onReady();
  }

  Future<void> refreshData() async {
    isLoading.value = true;
    _boardsData.value = (await _boardService.getAllBoards()).obs;
    _dashboardData.value = (await _computeDashboard()).obs;
    isLoading.value = false;
  }

  Future<List<DashboardData>> _computeDashboard() async {
    var stackCount = 0;
    var taskCount = 0;
    for (var board in _boardsData.value) {
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
          count: _boardsData.value.length,
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
