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
              '/boards/details',
              arguments: {'boardId': board.id},
            ),
        child: Column(children: [
          Card(
            color: board.color1,
            child: ListTile(
              title: Text(
                board.title,
              ),
            ),
          ),
          CircleAvatar(
              foregroundColor: Color(int.parse(board.color!, radix: 16)))
        ]));
  }
}
