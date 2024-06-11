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
  final KanbanBoardController controller = Get.put(KanbanBoardController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerWidget(),
      appBar: AppBar(
        title: const Text('Kanban Board'),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: controller.refreshData,
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
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
          title: Text(
            columnData.headerData.groupName,
            style: TextStyle(fontWeight: FontWeight.bold),
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
      groupConstraints: BoxConstraints.tightFor(width: 240),
    );
  }
}
