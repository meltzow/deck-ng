import 'package:deck_ng/component/board_item_widget.dart';
import 'package:deck_ng/component/drawer_widget.dart';
import 'package:deck_ng/controller/board_overview_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../component/my_app_bar_widget.dart';

class BoardOverviewScreen extends StatelessWidget {
  const BoardOverviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final BoardOverviewController controller =
        Get.put<BoardOverviewController>(BoardOverviewController());

    return Scaffold(
      appBar: AppBar(
        title: const MyAppBar(title: Text("Boards")),
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
                    child: Obx(
                      () => ListView.builder(
                        itemCount: controller.boardDataCount,
                        itemBuilder: (context, index) {
                          return BoardItemWidget(
                              board: controller.boardData[index]);
                        },
                      ),
                    )),
              ))
            ],
          ),
        ),
      ),
    );
  }
}
