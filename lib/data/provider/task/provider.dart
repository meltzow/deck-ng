import 'package:deck_ng/service/services.dart';
import 'package:get/get.dart';

import '../../models/task.dart';

class TaskProvider {
  final StorageService _storage = Get.find<StorageService>();

  List<Task> readTasks() {
    var tasks = <Task>[];
    // jsonDecode(_storage.read(taskKey).toString()).forEach(
    //   (element) => tasks.add(Task.fromJson(element)),
    // );
    return tasks;
  }

  void writeTasks(List<Task> tasks) {
    // _storage.write(taskKey, jsonEncode(tasks));
  }
}
