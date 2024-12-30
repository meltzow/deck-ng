import 'package:deck_ng/home/dashboard_controller.dart';
import 'package:deck_ng/service/impl/http_service.dart';
import 'package:deck_ng/service/impl/nextcloud/board_service_impl.dart';
import 'package:deck_ng/service/impl/nextcloud/stack_repository_impl.dart';
import 'package:deck_ng/service/services.dart';
import 'package:get/get.dart';

import '../data/provider/task/provider.dart';
import '../data/services/storage/repository.dart';
import 'controller.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HttpService>(() => HttpServiceImpl());
    Get.lazyPut<BoardService>(() => BoardServiceImpl());
    Get.lazyPut<StackService>(() => StackRepositoryImpl());
    Get.lazyPut<DashboardController>(() => DashboardController());
    Get.lazyPut(
      () => HomeController(
        taskRepository: TaskRepository(
          taskProvider: TaskProvider(),
        ),
      ),
    );
  }
}
