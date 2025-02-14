import 'package:deck_ng/app_routes.dart';
import 'package:deck_ng/model/board.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BoardItemWidget extends StatelessWidget {
  final Board board;

  const BoardItemWidget({super.key, required this.board});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.toNamed(
        AppRoutes.kanbanBoard,
        parameters: {'boardId': board.id.toString()},
      ),
      child: ListTile(
        shape: const RoundedRectangleBorder(
          side: BorderSide(
            width: 1,
          ),
          borderRadius: BorderRadius.all(Radius.circular(12.0)),
        ),
        title: Text(
          board.title,
        ),
        leading: CircleAvatar(backgroundColor: board.boardColor),
        subtitle: Text(
            "${board.stacks.length} stacks, ${board.lastModified} lastmodified"),
      ),
    );
  }
}
