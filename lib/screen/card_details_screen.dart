import 'package:deck_ng/component/drawer_widget.dart';
import 'package:deck_ng/controller/card_details_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
                            child: Obx(() => controller.isLoading.value
                                ? const Center(child: Text('loading'))
                                : Card(
                                    color: Colors.white70,
                                    child: Container(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Column(
                                        children: <Widget>[
                                          Row(
                                            children: [
                                              _editTitleTextField(
                                                  controller.isTitleEditing,
                                                  controller
                                                      .titleControllerText,
                                                  controller.titleController!)
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              _editTitleTextField(
                                                  controller
                                                      .isDescriptionEditing,
                                                  controller
                                                      .descriptionControllerText,
                                                  controller
                                                      .descriptionEditingController!)
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  )),
                          )))
                ],
              )),
        ));
  }

  Widget _editTitleTextField(RxBool isEditingField, RxString isEditingText,
      TextEditingController editingController) {
    if (isEditingField.value) {
      return Expanded(
          child: Center(
        child: TextField(
          onSubmitted: (newValue) {
            isEditingText.value = newValue;
            isEditingField.value = false;
          },
          autofocus: true,
          controller: editingController,
        ),
      ));
    }
    return InkWell(
        onTap: () {
          isEditingField.value = true;
        },
        child: Text(
          isEditingText.value,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 18.0,
          ),
        ));
  }
}
