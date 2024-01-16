import 'package:deck_ng/controller/board_details_controller.dart';
import 'package:deck_ng/screen/add_task_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kanban_board/custom/board.dart';
import 'package:kanban_board/models/inputs.dart';

class KanbanBoardScreen extends StatelessWidget {
  final controller = Get.find<BoardDetailsController>();

  KanbanBoardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xffffffff),
        appBar: AppBar(
          backgroundColor: const Color(0xff3a57e8),
          title: const Text(
            "Boards details",
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontStyle: FontStyle.normal,
              fontSize: 20,
              color: Color(0xfff9f9f9),
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {
                showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    builder: (context) => SingleChildScrollView(
                          child: Container(
                              padding: EdgeInsets.only(
                                  bottom:
                                      MediaQuery.of(context).viewInsets.bottom),
                              child: AddTaskScreen(
                                onAddTaskClicked: (title) =>
                                    controller.addCard(title),
                              )),
                        ));
              },
              icon: const Icon(Icons.add),
            ),
          ],
        ),
        body: RefreshIndicator(
            onRefresh: controller.refreshData,
            child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30))),
                margin: const EdgeInsets.only(top: 25),
                child: Obx(() => controller.isLoading.value
                    ? const Center(child: Text('loading'))
                    : KanbanBoard(
                        List.generate(
                          controller.stackData.length,
                          (stackIndex) => BoardListsData(
                              title: controller.stackData[stackIndex].title,
                              items: List.generate(
                                10,
                                (index) => Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(4),
                                      border: Border.all(
                                        color: Colors.grey.shade200,
                                      )),
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                      "Lorem ipsum dolor sit amet, sunt in culpa qui officia deserunt mollit anim id est laborum. $index",
                                      style: const TextStyle(
                                          fontSize: 16,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500)),
                                ),
                              )),
                        ),
                        backgroundColor: Colors.white,
                        displacementY: 124,
                        displacementX: 100,
                        textStyle: const TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.w500),
                      )))));
  }
}
