import 'package:deck_ng/app_routes.dart';
import 'package:deck_ng/component/drawer_widget.dart';
import 'package:deck_ng/component/loading_indicator.dart';
import 'package:deck_ng/dashboard/dashboard_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
            icon: const Icon(Icons.question_mark),
            onPressed: () {
              _controller.refreshBtnClick();
            },
          ),
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              _controller.refreshBtnClick();
            },
          ),
          Obx(() {
            return DropdownButton<SortOption>(
              value: _controller.sortOption.value,
              onChanged: (SortOption? newValue) {
                if (newValue != null) {
                  _controller.sortBoards(newValue);
                }
              },
              items: SortOption.values.map((SortOption option) {
                return DropdownMenuItem<SortOption>(
                  value: option,
                  child: Text(option == SortOption.name ? 'Name' : 'Date'),
                );
              }).toList(),
            );
          }),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
                          child: Text(
                              board.title.isNotEmpty ? board.title[0] : ''),
                        ),
                        title: Text(board.title ?? ''),
                        onTap: () {
                          Get.toNamed(
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
}
