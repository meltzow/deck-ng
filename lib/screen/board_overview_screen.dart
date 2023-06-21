import 'package:deck_ng/component/board_item_widget.dart';
import 'package:deck_ng/controller/board_overview_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../component/my_app_bar_widget.dart';

class BoardOverviewScreen extends StatelessWidget {
  final BoardOverviewController controller =
      Get.find<BoardOverviewController>();

  BoardOverviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(() => MyAppBar(title: Text("${controller.boardDataCount}"))),
      ),
      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text('Boards'),
            ),
            ListTile(
              title: const Text('Item 1'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Item 2'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              builder: (context) => SingleChildScrollView(
                    child: Container(
                      padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom),
                      // child: AddTaskScreen(
                      //   onAddTaskClicked: viewModel.onAddTaskClicked,
                      // )
                    ),
                  ));
        },
        child: const Icon(Icons.add),
      ),
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
