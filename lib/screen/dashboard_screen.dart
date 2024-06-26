import 'package:deck_ng/app_routes.dart';
import 'package:deck_ng/component/drawer_widget.dart';
import 'package:deck_ng/component/loading_indicator.dart';
import 'package:deck_ng/controller/dashboard_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wiredash/wiredash.dart';

class DashboardScreen extends StatelessWidget {
  final DashboardController _controller = Get.find<DashboardController>();

  DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerWidget(),
      appBar: AppBar(
        title: const Text('Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _controller.fetchData,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Obx(() {
              if (_controller.isLoading.value) {
                return const Center(
                  child: LoadingIndicator(),
                );
              }
              if (_controller.boards.isEmpty) {
                return const Center(
                  child: Text('No boards found'),
                );
              }
              if (kReleaseMode) {
                WidgetsBinding.instance!.addPostFrameCallback((_) {
                  Wiredash.of(context)
                      .showPromoterSurvey(inheritMaterialTheme: true);
                });
              }
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _metricCard('Boards', _controller.boardCount.value),
                  _metricCard('Stacks', _controller.stackCount.value),
                  _metricCard('Tasks', _controller.taskCount.value),
                ],
              );
            }),
            const SizedBox(height: 20),
            const Text(
              'Boards',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Obx(() {
              if (_controller.isLoading.value) {
                return const Center(
                  child: LoadingIndicator(),
                );
              }
              return Expanded(
                child: ListView.builder(
                  itemCount: _controller.boards.length,
                  itemBuilder: (context, index) {
                    final board = _controller.boards[index];
                    return Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      elevation: 3,
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: board.boardColor,
                          child: Text(board.title[0]),
                        ),
                        title: Text(board.title),
                        subtitle: Text('ID: ${board.id}'),
                        onTap: () {
                          Get.offNamed(
                            AppRoutes.kanbanBoard,
                            parameters: {'boardId': board.id.toString()},
                          );
                        },
                      ),
                    );
                  },
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _metricCard(String title, int value) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              value.toString(),
              style: const TextStyle(fontSize: 20, color: Colors.deepPurple),
            ),
          ],
        ),
      ),
    );
  }
}
