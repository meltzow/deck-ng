import 'package:deck_ng/core/utils/extensions.dart';
import 'package:deck_ng/modules/home/controller.dart';
import 'package:deck_ng/modules/home/widgets/add_card.dart';
import 'package:deck_ng/modules/home/widgets/task_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/values/colors.dart';
import '../report/view.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => IndexedStack(index: controller.tabIndex.value, children: [
          SafeArea(
            child: ListView(
              children: [
                Padding(
                  padding: EdgeInsets.all(4.0.wp),
                  child: Text(
                    'My Boards',
                    style: TextStyle(
                      fontSize: 24.0.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Obx(
                  () => GridView.count(
                    crossAxisCount: 2,
                    shrinkWrap: true,
                    physics: const ClampingScrollPhysics(),
                    children: [
                      ...controller.tasks.map((element) => LongPressDraggable(
                          data: element,
                          onDragStarted: () => controller.changeDeleting(true),
                          onDraggableCanceled: (velocity, offset) =>
                              controller.changeDeleting(false),
                          onDragEnd: (details) =>
                              controller.changeDeleting(false),
                          feedback: Opacity(
                            opacity: 0.5,
                            child: TaskCard(task: element),
                          ),
                          child: TaskCard(task: element))),
                      AddCard(),
                    ],
                  ),
                ),
              ],
            ),
          ),
          ReportPage(),
          ReportPage(),
          ReportPage(),
          ReportPage()
        ]),
      ),
      // floatingActionButton: DragTarget<Task>(
      //   builder: (_, __, ____) {
      //     return Obx(
      //       () => FloatingActionButton(
      //         onPressed: () {
      //           if (controller.tasks.isNotEmpty) {
      //             Get.to(() => AddDialog(), transition: Transition.downToUp);
      //           } else {
      //             EasyLoading.showInfo('Please create task first..');
      //           }
      //         },
      //         backgroundColor:
      //             controller.deleting.value ? Colors.red : darkGreen,
      //         child: Icon(controller.deleting.value ? Icons.delete : Icons.add),
      //       ),
      //     );
      //   },
      //   onAccept: (Task task) {
      //     controller.deleteTask(task);
      //     EasyLoading.showSuccess('Deleted');
      //   },
      // ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: Theme(
        data: ThemeData(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        child: Obx(
          () => BottomNavigationBar(
            onTap: (int index) => controller.changeTabIndex(index),
            currentIndex: controller.tabIndex.value,
            showSelectedLabels: true,
            showUnselectedLabels: true,
            selectedItemColor: darkGreen,
            items: const [
              BottomNavigationBarItem(
                label: 'Boards',
                icon: Icon(Icons.apps),
              ),
              BottomNavigationBarItem(
                label: 'Report',
                icon: Icon(Icons.add_chart),
              ),
              BottomNavigationBarItem(
                label: 'Accounts',
                icon: Icon(Icons.switch_account),
              ),
              // BottomNavigationBarItem(
              //   label: 'Setting',
              //   icon: Icon(Icons.settings),
              // )
            ],
          ),
        ),
      ),
    );
  }
}
