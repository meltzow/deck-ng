import 'package:deck_ng/component/board_item_widget.dart';
import 'package:deck_ng/component/drawer_widget.dart';
import 'package:deck_ng/component/loading_indicator.dart';
import 'package:deck_ng/controller/dashboard_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashboardScreen extends StatelessWidget {
  final DashboardController controller = Get.find<DashboardController>();

  DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: DrawerWidget(),
        appBar: AppBar(
          title: Text("Dashboard".tr),
          actions: [
            IconButton(
              icon: const Icon(
                Icons.refresh,
                size: 22,
              ),
              onPressed: () {
                controller.refreshData();
              },
            )
          ],
        ),
        body: SafeArea(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Expanded(
              child: RefreshIndicator(
            onRefresh: controller.refreshData,
            child: ListView(
              children: [
                Container(
                  margin: const EdgeInsets.all(16),
                  padding: const EdgeInsets.all(0),
                  decoration: const BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.zero,
                  ),
                  child: Obx(
                    () => controller.isLoading.value
                        ? const LoadingIndicator()
                        : GridView.builder(
                            shrinkWrap: true,
                            itemCount: controller.dashboardData.length,
                            itemBuilder: (context, index) {
                              return Container(
                                alignment: Alignment.center,
                                margin: const EdgeInsets.all(0),
                                padding: const EdgeInsets.all(0),
                                decoration: BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.circular(12.0),
                                  border: Border.all(width: 1),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(controller.dashboardData[index].icon,
                                        size: 24.0),
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
                                      padding: const EdgeInsets.all(0),
                                      child: Text(
                                        controller
                                            .dashboardData[index].valueName,
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
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    "Boards".tr,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.clip,
                    style: const TextStyle(
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.normal,
                      fontSize: 16,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(16),
                  padding: const EdgeInsets.all(0),
                  decoration: const BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.zero,
                  ),
                  child: Obx(
                    () => controller.isLoading.value
                        ? const LoadingIndicator()
                        : ListView.separated(
                            shrinkWrap: true,
                            padding: const EdgeInsets.all(8),
                            itemCount: controller.boardData.length,
                            itemBuilder: (context, index) {
                              return BoardItemWidget(
                                  board: controller.boardData[index]);
                            },
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return const SizedBox(height: 3);
                            },
                          ),
                  ),
                ),
              ],
            ),
          ))
        ])));
  }
}
