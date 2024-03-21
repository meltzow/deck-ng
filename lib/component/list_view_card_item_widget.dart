import 'package:deck_ng/app_routes.dart';
import 'package:deck_ng/model/card.dart' as NC;
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ListViewCardItem extends StatelessWidget {
  final NC.Card? data;
  final int boardId;

  const ListViewCardItem(
      {super.key, required this.data, required this.boardId});

  @override
  Widget build(BuildContext context) {
    return Card(
        child: ListTile(
      title: Text(
        data != null ? data!.title : "",
      ),
      trailing: const Icon(Icons.drag_handle),
      onTap: () {
        // When the user taps the button,
        // navigate to a named route and
        // provide the arguments as an optional
        // parameter.
        Get.toNamed(
          AppRoutes.cardDetails,
          parameters: {
            'boardId': boardId.toString(),
            'stackId': data!.stackId.toString(),
            'cardId': data!.id.toString()
          },
        );
      },
    ));
  }
}
