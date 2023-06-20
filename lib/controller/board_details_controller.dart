import 'package:deck_ng/model/board.dart';
import 'package:deck_ng/model/stack.dart' as NC;
import 'package:deck_ng/service/board_repository_impl.dart';
import 'package:deck_ng/service/stack_repository_impl.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class BoardDetailsController extends GetxController {
  final Rxn<Board> _boardsData = Rxn<Board>();
  final Rx<List<NC.Stack>> _stackData = Rx<List<NC.Stack>>([]);
  int? _boardId;
  final Rxn<int> _selectedStack = Rxn(0);

  Map<int, Widget> myTabs = const <int, Widget>{
    0: Text("Item 1"),
    1: Text("Item 2")
  };

  final BoardRepositoryImpl _boardRepository = Get.find<BoardRepositoryImpl>();
  final StackRepositoryImpl _stackRepository = Get.find<StackRepositoryImpl>();

  Board? get boardData => _boardsData.value;
  int? get selectedStack => _selectedStack.value;

  NC.Stack? get selectedStackData => _stackData.value.isNotEmpty
      ? _stackData.value
          .firstWhere((element) => element.id == _selectedStack.value)
      : null;

  set boardId(int? value) => _boardId = value;
  List<NC.Stack>? get stackData => _stackData.value;

  @override
  void onReady() async {
    super.onReady();
    _boardId = Get.arguments['boardId'] as int;
    await refreshData();
  }

  Future<void> refreshData() async {
    _boardsData.value = await _boardRepository.getBoard(_boardId!);
    _stackData.value = (await _stackRepository.getAll(_boardId!))!;
  }

  Future<void> selectStack(int stackId) async {
    _selectedStack.value = stackId;
  }
}
