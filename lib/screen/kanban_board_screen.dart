import 'package:deck_ng/component/list_view_card_item_widget.dart';
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
          title: Text("Boards details".tr),
          actions: [
            IconButton(
              icon: Icon(
                Icons.refresh,
                color: Theme.of(context).colorScheme.primary,
                size: 22,
              ),
              onPressed: () {
                controller.refreshData();
              },
            ),
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
                              // header: Container(),
                              footer: Container(),
                              title: controller.stackData[stackIndex].title,
                              items: List.generate(
                                controller.stackData[stackIndex].cards!.length,
                                (cardIndex) => Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(4),
                                      border: Border.all(
                                        color: Colors.grey.shade200,
                                      )),
                                  padding: const EdgeInsets.all(8.0),
                                  child: ListViewCardItem(
                                      data: controller.stackData[stackIndex]
                                          .cards?[cardIndex],
                                      index: cardIndex,
                                      boardId: controller.boardId),
                                  //
                                  // Text(
                                  //     controller.stackData[stackIndex]
                                  //         .cards[cardIndex].title,
                                  //     style: const TextStyle(
                                  //         fontSize: 16,
                                  //         color: Colors.black,
                                  //         fontWeight: FontWeight.w500)),
                                ),
                              )),
                        ),
                        backgroundColor: Colors.white,
                        displacementY: 400,
                        displacementX: 400,
                        textStyle: const TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.w500),
                      )))));
  }
}
