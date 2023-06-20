import 'package:deck_ng/model/board.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BoardItemWidget extends StatelessWidget {
  final Board board;

  const BoardItemWidget({super.key, required this.board});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        board.title,
        style: TextStyle(
            decoration:
                board.archived != true ? TextDecoration.lineThrough : null),
      ),
      onTap: () {
        Get.toNamed(
          '/boards/details',
          arguments: {'boardId': board.id},
        );
      },
    );
  }
}
