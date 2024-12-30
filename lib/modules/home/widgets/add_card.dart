import 'package:deck_ng/core/utils/extensions.dart';
import 'package:deck_ng/widgets/icon.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import '../../../core/values/colors.dart';
import '../../../data/models/task.dart';
import '../controller.dart';

class AddCard extends StatelessWidget {
  final homeCtrl = Get.find<HomeController>();
  AddCard({super.key});

  @override
  Widget build(BuildContext context) {
    final icons = getIcons();
    var cardWidth = Get.width - 12.0.wp;
    return Container(
      width: cardWidth / 2,
      height: cardWidth / 2,
      margin: EdgeInsets.all(3.0.wp),
      child: InkWell(
        onTap: () async {
          await Get.defaultDialog(
              titlePadding: EdgeInsets.symmetric(vertical: 5.0.wp),
              radius: 10,
              title: 'Task Type',
              content: Form(
                key: homeCtrl.formKey,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 3.0.wp),
                      child: TextFormField(
                        controller: homeCtrl.formEditCtrl,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Title',
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Please enter your task title';
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 4.0.wp),
                      child: Wrap(
                        spacing: 2.0.wp,
                        children: icons
                            .map(
                              (element) => Obx(
                                () {
                                  final index = icons.indexOf(element);
                                  return ChoiceChip(
                                    selectedColor: Colors.grey[200],
                                    pressElevation: 4,
                                    backgroundColor: Colors.white,
                                    label: element,
                                    selected: homeCtrl.chipIndex.value == index,
                                    onSelected: (bool selected) {
                                      homeCtrl.chipIndex.value =
                                          selected ? index : 0;
                                    },
                                  );
                                },
                              ),
                            )
                            .toList(),
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: darkGreen,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        minimumSize: const Size(150, 40),
                      ),
                      onPressed: () {
                        if (homeCtrl.formKey.currentState!.validate()) {
                          int icon =
                              icons[homeCtrl.chipIndex.value].icon!.codePoint;
                          String color =
                              icons[homeCtrl.chipIndex.value].color!.toHex();
                          var task = Task(
                              title: homeCtrl.formEditCtrl.text,
                              icon: icon,
                              color: color);
                          Get.back();
                          homeCtrl.addTask(task)
                              ? EasyLoading.showSuccess('Task Created')
                              : EasyLoading.showError('Task Already Exists');

                          homeCtrl.formEditCtrl.clear();
                          homeCtrl.changeChipIndex(0);
                        }
                      },
                      child: const Text("Confirm"),
                    )
                  ],
                ),
              ));
          homeCtrl.formEditCtrl.clear();
          homeCtrl.changeChipIndex(0);
        },
        child: DottedBorder(
          color: Colors.grey[400]!,
          dashPattern: const [10, 8],
          child: Center(
            child: Icon(
              Icons.add,
              size: 10.0.wp,
              color: Colors.grey,
            ),
          ),
        ),
      ),
    );
  }
}
