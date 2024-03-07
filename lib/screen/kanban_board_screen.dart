import 'package:appflowy_board/appflowy_board.dart';
import 'package:deck_ng/component/drawer_widget.dart';
import 'package:deck_ng/controller/board_details_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TextItem extends AppFlowyGroupItem {
  final String s;
  TextItem(this.s);

  @override
  String get id => s;
}

class KanbanBoardScreen extends StatelessWidget {
  final controller = Get.find<BoardDetailsController>();

  KanbanBoardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final config = AppFlowyBoardConfig(
      groupBackgroundColor: Theme.of(context).colorScheme.background,
      stretchGroupHeight: true,
    );

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
                    : AppFlowyBoard(
                        config: config,
                        controller: controller.boardController,
                        headerBuilder: (context, columnData) {
                          return AppFlowyGroupHeader(
                            title: SizedBox(
                                width: 60,
                                child: Text(columnData.headerData.groupName)),
                            height: 50,
                            margin: config.groupPadding,
                          );
                        },
                        cardBuilder: (context, group, groupItem) {
                          final textItem = groupItem as TextItem;
                          return Align(
                            key: Key(groupItem.id),
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 30),
                              child: Text(textItem.s),
                            ),
                          );
                        },
                        groupConstraints:
                            const BoxConstraints.tightFor(width: 240),
                      )))));
  }
}

extension HexColor on Color {
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}
