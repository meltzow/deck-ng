import 'package:deck_ng/model/board.dart';
import 'package:deck_ng/service/Iauth_service.dart';
import 'package:deck_ng/service/board_repository_impl.dart';
import 'package:get/get.dart';

class Controller extends GetxController {
  List<Board>? _boardsData;

  final BoardRepositoryImpl _boardRepository = Get.find<BoardRepositoryImpl>();
  final IAuthService _authRepository = Get.find<IAuthService>();

  @override
  void onInit() async {
    super.onInit();
    await _authRepository.saveCredentials(
        "http://localhost:8080", "admin", "admin", true);
    _boardsData = await _boardRepository.getAllBoards();
  }

  var count = 0.obs;
  void increment() {
    count++;
  }
}
