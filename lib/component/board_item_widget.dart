import 'package:deck_ng/model/board.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BoardItemWidget extends StatelessWidget {
  final Board board;

  const BoardItemWidget({super.key, required this.board});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.background,
      child: Column(
        children: <Widget>[
          ListTile(
            leading: CircleAvatar(
                foregroundColor: Color(int.parse(board.color!, radix: 16))),
            title: Text(
              board.title,
            ),
            onTap: () {
              Get.toNamed(
                '/boards/details',
                arguments: {'boardId': board.id},
              );
            },
          )
        ],
      ),
    );
  }
}
