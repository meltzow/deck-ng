import 'package:deck_ng/component/board_item_widget.dart';
import 'package:deck_ng/component/my_app_bar_widget.dart';
import 'package:deck_ng/controller/dashboard_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashboardScreen extends StatelessWidget {
  final DashboardController controller =
      Get.put<DashboardController>(DashboardController());

  DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffffffff),
      appBar: MyAppBar(
        title: "Dashboard".tr,
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
      body: ListView(
        children: [
          Container(
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(0),
            decoration: const BoxDecoration(
              color: Color(0x00ffffff),
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.zero,
            ),
            child: Obx(
              () => controller.isLoading.value
                  ? const Center(child: Text('loading'))
                  : GridView.builder(
                      shrinkWrap: true,
                      itemCount: controller.dashboardData.length,
                      itemBuilder: (context, index) {
                        return Container(
                          alignment: Alignment.center,
                          margin: const EdgeInsets.all(0),
                          padding: const EdgeInsets.all(0),
                          decoration: BoxDecoration(
                            color: const Color(0xffffffff),
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(12.0),
                            border: Border.all(
                                color: const Color(0x4d9e9e9e), width: 1),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                controller.dashboardData[index].count
                                    .toString(),
                                textAlign: TextAlign.start,
                                overflow: TextOverflow.clip,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontStyle: FontStyle.normal,
                                  fontSize: 20,
                                  color: Color(0xff3a57e8),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
                                child: Text(
                                  controller.dashboardData[index].valueName,
                                  textAlign: TextAlign.start,
                                  overflow: TextOverflow.clip,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontStyle: FontStyle.normal,
                                    fontSize: 16,
                                    // color: Color(0xff4c4c4c),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                        // BoardItemWidget(
                        //   board: controller.boardData[index]);
                      },
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                        // childAspectRatio: 0.6,
                      ),
                    ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              "Boards",
              textAlign: TextAlign.center,
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
            decoration: const BoxDecoration(
              // color: Color(0x00ffffff),
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.zero,
            ),
            child: Obx(
              () => controller.isLoading.value
                  ? const Center(child: Text('loading'))
                  : GridView.builder(
                      shrinkWrap: true,
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
                        childAspectRatio: 1,
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
