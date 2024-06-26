import 'package:appflowy_board/appflowy_board.dart';
import 'package:deck_ng/component/drawer_widget.dart';
import 'package:deck_ng/component/list_view_card_item_widget.dart';
import 'package:deck_ng/controller/kanban_board_controller.dart';
import 'package:deck_ng/model/card.dart' as NC;
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CardItem extends AppFlowyGroupItem {
  final NC.Card card;
  CardItem(this.card);

  @override
  String get id => card.id.toString();
}

class KanbanBoardScreen extends StatelessWidget {
  final KanbanBoardController controller = Get.find<KanbanBoardController>();

  KanbanBoardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerWidget(),
      appBar: AppBar(
        title: const Text('Kanban Board'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: controller.refreshData,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Obx(() {
          if (controller.isLoading.value) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return _buildAppFlowyBoard(context);
        }),
      ),
    );
  }

  Widget _buildAppFlowyBoard(BuildContext context) {
    final config = AppFlowyBoardConfig(
      groupBackgroundColor: Theme.of(context).colorScheme.background,
      stretchGroupHeight: true,
    );

    return AppFlowyBoard(
      config: config,
      controller: controller.boardController,
      headerBuilder: (context, columnData) {
        return AppFlowyGroupHeader(
          addIcon: const Icon(Icons.add),
          onAddButtonClick: () async {
            String? title;
            title = await showDialog<String>(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                title: const Text('New card'),
                content: TextField(
                  onChanged: (value) => title = value,
                  decoration: const InputDecoration(hintText: "Card title"),
                ),
                actions: <Widget>[
                  TextButton(
                    onPressed: () => Navigator.pop(context, title),
                    child: const Text('OK'),
                  ),
                ],
              ),
            );
            if (title != null) {
              Get.find<KanbanBoardController>()
                  .createCard(int.parse(columnData.id), title!);
            }
          },
          title: Expanded(
            child: Row(
              children: [
                Text(
                  columnData.headerData.groupName,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const Spacer(),
              ],
            ),
          ),
          height: 50,
          margin: config.groupMargin,
        );
      },
      cardBuilder: (context, group, groupItem) {
        final cardItem = groupItem as CardItem;
        return Align(
          key: Key(groupItem.id),
          alignment: Alignment.centerLeft,
          child: ListViewCardItem(
            data: cardItem.card,
            boardId: controller.boardId,
          ),
        );
      },
      groupConstraints: const BoxConstraints.tightFor(width: 240),
    );
  }
}
