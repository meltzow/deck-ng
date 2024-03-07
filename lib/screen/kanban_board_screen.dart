import 'package:deck_ng/component/drawer_widget.dart';
import 'package:deck_ng/component/list_view_card_item_widget.dart';
import 'package:deck_ng/controller/board_details_controller.dart';
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
        drawer: const DrawerWidget(),
        appBar: AppBar(
          title: Text("Boards details".tr),
          actions: [
            IconButton(
              icon: const Icon(
                Icons.refresh,
              ),
              onPressed: () {
                controller.refreshData();
              },
            ),
            // IconButton(
            //   onPressed: () {
            //     showModalBottomSheet(
            //         context: context,
            //         isScrollControlled: true,
            //         builder: (context) => SingleChildScrollView(
            //               child: Container(
            //                   padding: EdgeInsets.only(
            //                       bottom:
            //                           MediaQuery.of(context).viewInsets.bottom),
            //                   child: AddTaskScreen(
            //                     onAddTaskClicked: (title) =>
            //                         controller.addCard(title),
            //                   )),
            //             ));
            //   },
            //   icon: const Icon(Icons.add),
            // ),
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
                        onItemReorder: (oldCardIndex, newCardIndex,
                                oldListIndex, newListIndex) =>
                            controller.cardReorderHandler(oldCardIndex,
                                newCardIndex, oldListIndex, newListIndex),
                        List.generate(
                          controller.stackData.length,
                          (stackIndex) => BoardListsData(
                              backgroundColor:
                                  Theme.of(context).scaffoldBackgroundColor,
                              header: Container(
                                width: 250,
                                padding: const EdgeInsets.only(
                                    left: 0, bottom: 12, top: 12),
                                alignment: Alignment.centerLeft,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      controller.stackData[stackIndex].title ??
                                          '',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                              footer: Container(),
                              items: List.generate(
                                controller.stackData[stackIndex].cards.length,
                                (cardIndex) => Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  padding: const EdgeInsets.all(8.0),
                                  child: ListViewCardItem(
                                      data: controller.stackData[stackIndex]
                                          .cards[cardIndex],
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
                        displacementY: 400,
                        displacementX: 400,
                        textStyle: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500),
                        listDecoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                                width: 1,
                                color: Theme.of(context)
                                    .colorScheme
                                    .background)))))));
  }
}
