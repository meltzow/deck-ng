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
                                : const Column(
                                    children: [
                                      Expanded(
                                          child: Card(
                                        child: Text("I'm a Card"),
                                      ))
                                    ],
                                  )),
                          )))
                ],
              )),
        ));
  }
}
