import 'package:deck_ng/controller/controller.dart';
import 'package:get/get.dart';
import 'package:test/test.dart';

void main() {
  test(
      '''Test the state of the reactive variable "name" across all of its lifecycles''',
      () {
    /// You can test the controller without the lifecycle,
    /// but it's not recommended unless you're not using
    ///  GetX dependency injection
    final controller = Get.put(Controller());
    expect(controller.count.value, 0);

    /// If you are using it, you can test everything,
    /// including the state of the application after each lifecycle.
    Get.put(controller); // onInit was called
    expect(controller.count.value, 0);

    /// Test your functions
    controller.increment();
    expect(controller.count.value, 1);

    /// onClose was called
    Get.delete<Controller>();

    expect(controller.count.value, 1);
  });
}
