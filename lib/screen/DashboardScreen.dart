import 'package:deck_ng/component/board_item_widget.dart';
import 'package:deck_ng/controller/board_overview_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final BoardOverviewController controller =
        Get.put<BoardOverviewController>(BoardOverviewController());

    return Scaffold(
      backgroundColor: const Color(0xffffffff),
      appBar: AppBar(
        elevation: 4,
        centerTitle: false,
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xff3a57e8),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.zero,
        ),
        title: const Text(
          "Dashboard",
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontStyle: FontStyle.normal,
            fontSize: 20,
            color: Color(0xfff9f9f9),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.refresh,
              color: Color(0xffffffff),
              size: 22,
            ),
            onPressed: () {
              controller.refreshData();
            },
          )
        ],
      ),
      body: Stack(
        alignment: Alignment.topLeft,
        children: [
          SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                    margin: const EdgeInsets.all(10),
                    padding: const EdgeInsets.all(10),
                    decoration: const BoxDecoration(
                      color: Color(0xffffffff),
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.zero,
                    ),
                    child: const Column(children: [
                      Card(
                          child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          ListTile(
                            title: Text('4'),
                            subtitle: Text('Boards'),
                          ),
                        ],
                      )),
                      Card(
                          child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          ListTile(
                            title: Text('10'),
                            subtitle: Text('Tasks'),
                          ),
                        ],
                      ))
                    ])),
                const Padding(
                  padding: EdgeInsets.all(16),
                  child: Text(
                    "Boards",
                    textAlign: TextAlign.start,
                    overflow: TextOverflow.clip,
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.normal,
                      fontSize: 16,
                      color: Color(0xff000000),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(16),
                  padding: const EdgeInsets.all(0),
                  height: 170,
                  decoration: const BoxDecoration(
                    color: Color(0x00ffffff),
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.zero,
                  ),
                  child: Obx(
                    () => controller.isLoading.value
                        ? const Center(child: Text('loading'))
                        : GridView.builder(
                            itemCount: controller.boardDataCount,
                            itemBuilder: (context, index) {
                              return BoardItemWidget(
                                  board: controller.boardData[index]);
                            },
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 16,
                              mainAxisSpacing: 16,
                              childAspectRatio: 0.6,
                            ),
                          ),
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Container(
              margin: const EdgeInsets.fromLTRB(0, 0, 16, 16),
              padding: const EdgeInsets.all(0),
              width: 60,
              height: 60,
              decoration: const BoxDecoration(
                color: Color(0xff3a57e8),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.add,
                color: Color(0xffffffff),
                size: 24,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
