import 'package:deck_ng/model/board.dart';
import 'package:deck_ng/model/stack.dart' as NC;
import 'package:deck_ng/service/Iboard_service.dart';
import 'package:deck_ng/service/Istack_service.dart';
import 'package:deck_ng/service/impl/stack_repository_impl.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class BoardDetailsController extends GetxController {
  final Rxn<Board> _boardsData = Rxn<Board>();
  final Rx<List<NC.Stack>> _stackData = Rx<List<NC.Stack>>([]);
  late final int _boardId;
  final Rxn<int> _selectedStackId = Rxn(0);
  final RxBool isLoading = RxBool(true);

  int get boardId => _boardId;

  Map<int, Widget> get myTabs {
    Map<int, Widget> m = <int, Widget>{};
    for (var element in _stackData.value) {
      m[element.id] = Text(element.title);
    }
    return m;
  }

  final IBoardService _boardRepository = Get.find<IBoardService>();
  final IStackService _stackRepository = Get.find<IStackService>();

  Board? get boardData => _boardsData.value;
  int? get selectedStackId => _selectedStackId.value;

  NC.Stack? get selectedStackData => _stackData.value.isNotEmpty
      ? _stackData.value
          .firstWhere((element) => element.id == _selectedStackId.value)
      : null;

  @visibleForTesting
  set boardId(int value) => _boardId = value;
  List<NC.Stack>? get stackData => _stackData.value;

  @override
  void onReady() async {
    super.onReady();
    _boardId = Get.arguments['boardId'] as int;
    await refreshData();
  }

  Future<void> refreshData() async {
    isLoading.value = true;
    _boardsData.value = await _boardRepository.getBoard(_boardId);
    _stackData.value = (await _stackRepository.getAll(_boardId))!;
    _selectedStackId.value = _stackData.value[0].id;
    isLoading.value = false;
  }

  Future<void> selectStack(int stackId) async {
    _selectedStackId.value = stackId;
  }
}
