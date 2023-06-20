import 'package:deck_ng/component/list_view_card_item_widget.dart';
import 'package:deck_ng/component/my_app_bar_widget.dart';
import 'package:deck_ng/controller/board_details_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ScreenArguments {
  final int boardId;
  final String message;

  ScreenArguments(this.boardId, this.message);
}

class BoardDetailsScreen extends StatelessWidget {
  final controller = Get.find<BoardDetailsController>();

  BoardDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MyAppBar(
                title: Text('board details '),
              ),
              Row(
                children: [
                  Expanded(
                    child: CupertinoSlidingSegmentedControl(
                        groupValue: controller.selectedStack,
                        children: controller.myTabs,
                        onValueChanged: (i) {
                          controller.selectStack(i!);
                        }),
                  )
                ],
              ),
              Expanded(
                  child: RefreshIndicator(
                onRefresh: () async {
                  controller.refreshData();
                },
                child: ListView.builder(
                  itemCount: controller.selectedStackData != null
                      ? controller.selectedStackData!.cards.length
                      : 0,
                  itemBuilder: (context, index) {
                    if (controller.stackData != null) {
                      return ListViewCardItem(
                          data: controller.selectedStackData != null
                              ? controller.selectedStackData!.cards[index]
                              : null);
                    }
                  },
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }
}
