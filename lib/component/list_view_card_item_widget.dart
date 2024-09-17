import 'dart:math';

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
      title: Text(
        card != null ? card!.title : "",
      ),
      subtitle: Text(
        card != null &&
                card!.description != null &&
                card!.description!.isNotEmpty
            ? '${card!.description!.substring(0, min(30, card!.description!.length))} ...'
            : "",
      ),
      onTap: () {
        // When the user taps the button,
        // navigate to a named route and
        // provide the arguments as an optional
        // parameter.
        Get.toNamed(
          AppRoutes.cardDetails,
          parameters: {
            'boardId': boardId.toString(),
            'stackId': card!.stackId.toString(),
            'cardId': card!.id.toString()
          },
        );
      },
    ));
  }
}
