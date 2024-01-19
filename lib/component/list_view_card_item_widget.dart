import 'package:deck_ng/model/card.dart' as NC;
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ListViewCardItem extends StatelessWidget {
  final NC.Card? data;
  final int index;
  final int boardId;

  const ListViewCardItem(
      {super.key,
      required this.data,
      required this.index,
      required this.boardId});

  @override
  Widget build(BuildContext context) {
    return Card(
        child: ListTile(
      title: Text(
        data != null ? data!.title : "",
      ),
      trailing: ReorderableDragStartListener(
        //<-- add this to leading
        index: index,
        child: const Icon(Icons.drag_handle),
      ),
      onTap: () {
        // When the user taps the button,
        // navigate to a named route and
        // provide the arguments as an optional
        // parameter.
        print("tab on ${data!.title}");
        Get.toNamed(
          '/cards/details',
          arguments: {
            'boardId': boardId,
            'stackId': data!.stackId,
            'cardId': data!.id
          },
        );
      },
    ));
  }
}
