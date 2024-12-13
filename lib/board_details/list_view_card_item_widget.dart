import 'package:deck_ng/app_routes.dart';
import 'package:deck_ng/model/card.dart' as NC;
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ListViewCardItem extends StatelessWidget {
  final NC.Card? card;
  final int boardId;

  const ListViewCardItem(
      {super.key, required this.card, required this.boardId});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(card != null ? card!.title : ""),
            const SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("# ${card != null ? card!.id.toString() : ''}"),
                if (card != null &&
                    card!.assignedUsers != null &&
                    card!.assignedUsers!.isNotEmpty)
                  CircleAvatar(
                    child: Text(
                      card!.assignedUsers!.first.participant.displayname[0],
                      style: const TextStyle(color: Colors.white),
                    ),
                    backgroundColor: Colors.blue,
                  )
                else
                  const CircleAvatar(
                    child: Icon(Icons.person_outline),
                    backgroundColor: Colors.grey,
                  ),
              ],
            ),
          ],
        ),
        onTap: () {
          Get.toNamed(
            AppRoutes.cardDetails,
            parameters: {
              'boardId': boardId.toString(),
              'stackId': card!.stackId.toString(),
              'cardId': card!.id.toString()
            },
          );
        },
      ),
    );
  }
}
