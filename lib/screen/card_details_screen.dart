import 'package:deck_ng/component/drawer_widget.dart';
import 'package:deck_ng/controller/card_details_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

class CardDetailsScreen extends StatelessWidget {
  final controller = Get.find<CardDetailsController>();

  CardDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Card details"),
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
                          () => controller.isLoading.value
                              ? const Center(child: Text('loading'))
                              : Card(
                                  child: Column(
                                    children: <Widget>[
                                      ListTile(
                                          title: _editTitleTextField(
                                              controller.isTitleEditing,
                                              controller.titleControllerText,
                                              controller.titleController!),
                                          subtitle: _editTitleTextField(
                                              controller.isDescriptionEditing,
                                              controller
                                                  .descriptionControllerText,
                                              controller
                                                  .descriptionEditingController!)),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: MultiSelectDialogField(
                                                title:
                                                    const Text('select labels'),
                                                items: controller.allLabel!
                                                    .map((e) => MultiSelectItem(
                                                        e, e.title))
                                                    .toList(),
                                                listType:
                                                    MultiSelectListType.CHIP,
                                                onConfirm: (values) =>
                                                    controller
                                                        .saveLabels(values)),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                        )),
                  ))
                ],
              )),
        ));
  }

  Widget _editTitleTextField(RxBool isEditingField, RxString isEditingText,
      TextEditingController editingController) {
    if (isEditingField.value) {
      return Center(
        child: TextField(
          onSubmitted: (newValue) {
            isEditingText.value = newValue;
            isEditingField.value = false;
          },
          autofocus: true,
          controller: editingController,
        ),
      );
    }
    return InkWell(
        splashColor: Colors.blue.withAlpha(30),
        onTap: () {
          isEditingField.value = true;
        },
        child: Text(
          isEditingText.value,
        ));
  }
}
