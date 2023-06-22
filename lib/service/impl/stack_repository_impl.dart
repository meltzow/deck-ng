import 'package:deck_ng/model/stack.dart';
import 'package:deck_ng/service/Ihttp_service.dart';
import 'package:deck_ng/service/Istack_service.dart';
import 'package:get/get.dart';

class StackRepositoryImpl extends GetxService implements IStackService {
  IHttpService get httpService => Get.find<IHttpService>();

  @override
  Future<List<Stack>?> getAll(int boardId) async {
    dynamic response = await httpService
        .getListResponse("/index.php/apps/deck/api/v1/boards/$boardId/stacks");
    List<Stack> mediaList =
        (response as List).map((tagJson) => Stack.fromJson(tagJson)).toList();
    return mediaList;
  }
}
