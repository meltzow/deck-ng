import 'package:deck_ng/core/utils/extensions.dart';
import 'package:deck_ng/modules/home/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DoingList extends StatelessWidget {
  final homeCtrl = Get.find<HomeController>();
  DoingList({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => homeCtrl.doingTodos.isEmpty && homeCtrl.doneTodos.isEmpty
        ? Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0.wp),
                child: Image.asset(
                  'assets/img/task.png',
                  fit: BoxFit.cover,
                  width: 60.0.wp,
                ),
              ),
              Text(
                'Add Task',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0.sp,
                ),
              )
            ],
          )
        : ListView(
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
            children: [
              ...homeCtrl.doingTodos
                  .map(
                    (element) => Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 9.0.wp,
                        vertical: 3.0.wp,
                      ),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 20,
                            height: 20,
                            child: Checkbox(
                              fillColor: MaterialStateProperty.resolveWith(
                                  (states) => Colors.grey),
                              value: element['done'],
                              onChanged: (value) {
                                homeCtrl.doneTodo(element['title']);
                              },
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 4.0.wp),
                            child: Text(
                              element['title'],
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                  .toList(),
              if (homeCtrl.doingTodos.isNotEmpty)
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.0.wp),
                  child: const Divider(
                    thickness: 2,
                  ),
                )
            ],
          ));
  }
}
