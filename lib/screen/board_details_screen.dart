import 'package:deck_ng/component/drawer_widget.dart';
import 'package:deck_ng/component/list_view_card_item_widget.dart';
import 'package:deck_ng/component/my_app_bar_widget.dart';
import 'package:deck_ng/controller/board_details_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BoardDetailsScreen extends StatelessWidget {
  final controller = Get.find<BoardDetailsController>();

  BoardDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const MyAppBar(title: Text("Boards details")),
        ),
        drawer: const DrawerWidget(),
        body: SafeArea(
          child: Container(
              color: Colors.lightBlue,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                      child: RefreshIndicator(
                          onRefresh: controller.refreshData,
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(30),
                                    topRight: Radius.circular(30))),
                            margin: const EdgeInsets.only(top: 25),
                            child: Obx(() => controller.isLoading.value
                                ? const Center(child: Text('loading'))
                                : Column(
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                            child:
                                                CupertinoSlidingSegmentedControl(
                                                    groupValue: controller
                                                        .selectedStackId,
                                                    children: controller.myTabs,
                                                    onValueChanged: (i) {
                                                      controller
                                                          .selectStack(i!);
                                                    }),
                                          )
                                        ],
                                      ),
                                      Expanded(child: GestureDetector(
                                          onPanUpdate: (details) {
                                            // Swiping in right direction.
                                            if (details.delta.dx > 0) {
                                              print ("swipe right");
                                            }

                                            // Swiping in left direction.
                                            if (details.delta.dx < 0) {
                                              print ("swipe left");
                                            }
                                          },
                                          child: ListView.builder(
                                            itemCount: controller.selectedStackData != null
                                                ? controller.selectedStackData!.cards.length
                                                : 0,
                                            itemBuilder: (context, index) {
                                              return ListViewCardItem(
                                                  data: controller.selectedStackData != null
                                                      ? controller.selectedStackData!.cards[index]
                                                      : null);
                                            },
                                          ),
                                        ),)
                                    ],
                                  )),
                          )))
                ],
              )),
        ));
  }
}
