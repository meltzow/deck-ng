import 'package:deck_ng/modules/detail/widgets/done_list.dart';
import 'package:deck_ng/modules/home/controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

import '../../core/utils/extensions.dart';
import 'widgets/doing_list.dart';

class DetailPage extends StatelessWidget {
  final homeCtrl = Get.find<HomeController>();
  DetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    var task = homeCtrl.task.value!;
    var color = HexColor.fromHex(task.color);
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: Form(
          key: homeCtrl.formKey,
          child: ListView(
            children: [
              Padding(
                padding: EdgeInsets.all(3.0.wp),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: () {
                        Get.back();
                        homeCtrl.updateTodo();
                        homeCtrl.changeTask(null);
                        homeCtrl.formEditCtrl.clear();
                      },
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0.wp),
                child: Row(
                  children: [
                    Icon(
                      IconData(
                        task.icon,
                        fontFamily: 'MaterialIcons',
                      ),
                      color: color,
                    ),
                    SizedBox(
                      width: 3.0.wp,
                    ),
                    Text(
                      task.title,
                      style: TextStyle(
                          fontSize: 12.0.sp, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Obx(
                () {
                  var totalTodos =
                      homeCtrl.doingTodos.length + homeCtrl.doneTodos.length;
                  return Padding(
                    padding: EdgeInsets.only(
                      top: 3.0.wp,
                      left: 16.0.wp,
                      right: 8.0.wp,
                    ),
                    child: Row(
                      children: [
                        Text(
                          '$totalTodos Tasks',
                          style: TextStyle(
                              fontSize: 12.0.sp,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey),
                        ),
                        SizedBox(
                          width: 3.0.wp,
                        ),
                        Expanded(
                          child: StepProgressIndicator(
                            totalSteps: totalTodos == 0 ? 1 : totalTodos,
                            currentStep: homeCtrl.doneTodos.length,
                            size: 5,
                            padding: 0,
                            selectedGradientColor: LinearGradient(
                              colors: [color.withOpacity(0.5), color],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            unselectedGradientColor: LinearGradient(
                              colors: [Colors.grey[300]!, Colors.grey[400]!],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 5.0.wp,
                  vertical: 2.0.wp,
                ),
                child: TextFormField(
                  controller: homeCtrl.formEditCtrl,
                  autofocus: true,
                  decoration: InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey[400]!),
                    ),
                    prefixIcon: Icon(
                      Icons.check_box_outline_blank,
                      color: Colors.grey[400],
                    ),
                    suffixIcon: IconButton(
                      onPressed: () {
                        if (homeCtrl.formKey.currentState!.validate()) {
                          var success =
                              homeCtrl.addTodo(homeCtrl.formEditCtrl.text);
                          if (success) {
                            EasyLoading.showSuccess('Todo item added');
                          } else {
                            EasyLoading.showError('Todo item already exits');
                          }
                          homeCtrl.updateTodo();
                          homeCtrl.formEditCtrl.clear();
                        }
                      },
                      icon: const Icon(Icons.done),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter your todo item';
                    }
                    return null;
                  },
                ),
              ),
              DoingList(),
              DoneList(),
            ],
          ),
        ),
      ),
    );
  }
}
