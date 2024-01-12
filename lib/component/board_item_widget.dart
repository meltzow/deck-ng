import 'package:deck_ng/model/board.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BoardItemWidget extends StatelessWidget {
  final Board board;

  const BoardItemWidget({super.key, required this.board});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: <Widget>[
          ListTile(
            title: Text(
              board.title,
            ),
            subtitle: Text(board.color.toString()),
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
