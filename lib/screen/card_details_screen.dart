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
                                              Obx(() => _editTitleTextField())
                                            ],
                                          ),
                                          Row(
                                            children: <Widget>[
                                              Expanded(
                                                  child: Text(
                                                "Bemerkung",
                                              )),
                                              Expanded(
                                                child: TextField(),
                                              ),
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

  Widget _editTitleTextField() {
    if (controller.isEditingText.value) {
      return Expanded(
          child: Center(
        child: TextField(
          onSubmitted: (newValue) {
            controller.descriptionControllerText.value = newValue;
            controller.isEditingText.value = false;
          },
          autofocus: true,
          controller: controller.editingController,
        ),
      ));
    }
    return InkWell(
        onTap: () {
          controller.isEditingText.value = true;
        },
        child: Text(
          controller.descriptionControllerText.value,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 18.0,
          ),
        ));
  }
}
